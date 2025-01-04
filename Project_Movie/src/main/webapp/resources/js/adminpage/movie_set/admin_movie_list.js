$(function() {
   	let modal = $("#regist_movie_modal");
    let openModal = $("#regist_modal_open");
    let closeModal = $("#close_modal");

    // 영화 등록 모달 열기
    openModal.on('click', function() {
        modal.css("display", "block");
		document.querySelector('.form01').reset();
		document.querySelector('.form02').reset();
		$(".search_table").empty();
    });

    // 영화 등록 모달 닫기
    closeModal.on('click', function() {
        modal.css("display", "none");
    });
	
	// 영화등록 모달에서 영화정보조회 방법 선택시 해당 조회 방법만 활성화
	$("input[name=search_method]").change(function() {
		// 영화명으로 조회시 감독명, 개봉년도로 조회 비활성화
	    if ($("input[name=search_method]:checked").val() == "movieNm") {
	        $("#movie_name").prop("disabled", false);
	        $("#director_name").prop("disabled", true);
	        $("#release_year_select1").prop("disabled", true);
	        $("#release_year_select2").prop("disabled", true);
		// 감독명으로 조회시 영화명, 개봉년도로 조회 비활성화
	    } else if ($("input[name=search_method]:checked").val() == "directorNm") {
	        $("#movie_name").prop("disabled", true);
	        $("#director_name").prop("disabled", false);
	        $("#release_year_select1").prop("disabled", true);
	        $("#release_year_select2").prop("disabled", true);
		// 개봉년도로 조회시 감동명, 영화명으로 조회 비활성화
	    } else if ($("input[name=search_method]:checked").val() == "releaseYear") {
	        $("#movie_name").prop("disabled", true);
	        $("#director_name").prop("disabled", true);
	        $("#release_year_select1").prop("disabled", false);
	        $("#release_year_select2").prop("disabled", true);
	    }
	});
	
	// 영화등록모달의 개봉기간으로 영화정보조회시 사용되는 년도 설렉트박스
	let startYear = 1970;
	let endYear = new Date().getFullYear();
	
	for(let year = startYear; year <= endYear; year++) {
		$("#release_year_select1").append("<option value='" + year + "'>" + year + "</option>");
	}
	
	// 조회시작년도 설렉트박스 선택시 조회끝년도 설렉트박스 활성화, 시작년도 보다 높고 현재년도와 낮거나 같은 년도만 선택가능
	// 조회시작년도 바뀔때마다 <option>이 추가되므로 중첩안되기위해 반복문 시작전 조회끝년도 설렉트박스 옵션요소 삭제
	$("#release_year_select1").change(function() {
		if( $("#release_year_select1").val() == "선택" ) {
			$("#release_year_select2").prop("disabled", true);
			$("#release_year_select2").empty();
			$("#release_year_select2").append("<option value='선택'>선택</option>");
		} else {
			$("#release_year_select2").prop("disabled", false);
			$("#release_year_select2").empty();
			for(let year = $("#release_year_select1").val(); year <= endYear; year++) {
				$("#release_year_select2").append("<option value='" + year + "'>" + year + "</option>");
			}
		}
	});
	
	// 영화등록모달의 영화조회하기 버튼 클릭시 AJAX사용으로 영화정보 json 데이터 조회
	$("#request_movie_info_btn").click(function() {
		
		// 재조회시 이전 조회 테이블 삭제
		$(".search_table").empty();
		
		let checkRadio = $("input[name=search_method]:checked").val();
		let ajaxData = {};
		
		if(checkRadio == "movieNm") {
			ajaxData = {movieNm : $("#movie_name").val()};
		} else if(checkRadio == "directorNm") {
			ajaxData = {directorNm : $("#director_name").val()};
		} else if(checkRadio == "releaseYear") {
			ajaxData = {
				openStartDt : $("#release_year_select1").val(),
				openEndDt : $("#release_year_select2").val(),
				itemPerPage : 100,
				curPage : 3
			};
		}
		
		// KOBIS OPEN API로 영화정보 조회 후 영화목록 테이블에 입력
		$.ajax({
			type : "GET",
			url : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json",
			data : Object.assign({
       			key : "5b3c2582ad7390e87c71c7d1c30f4f55"
    		}, ajaxData),
			dataType : "json"	
		}).done(function(result) {
			$(".search_table").append(
			"<table>"
				+ "<tr>"
					+ "<th><b><input type='radio'name='select_movie' disabled></b></th>"
					+ "<th><b>영화코드</b></th>"
					+ "<th><b>영화명</b></th>"
					+ "<th><b>개봉일</b></th>"
					+ "<th><b>영화장르</b></th>"
					+ "<th><b>감독명</b></th>"
				+ "</tr>"
			+ "</table>"
			);	
			
			for(let movie of result.movieListResult.movieList) {
				movie.repGenreNm ? movie.repGenreNm : "";
				// 성인물 제외 하기 위한 코드
				let isPassedMovie = true
			    let checkList = ["성인물", "멜로", "에로", "다큐멘터리", "기타"];

				for(let checkKeyword of checkList) {
					if(movie.repGenreNm.includes(checkKeyword) || movie.repGenreNm == "") {
						isPassedMovie = false;
					}
				}
				
				// 조회 장르에 checkList에 있는 단어 미포함 영화만 출력
				if(isPassedMovie) {
					$(".search_table > table").append(
						"<tr>"
							+ "<th><input type='radio'name='select_movie'></th>"
							+ "<td>"+ (movie.movieCd ? movie.movieCd : "") +"</td>"
							+ "<td>"+ (movie.movieNm ? movie.movieNm : "") +"</td>"
							+ "<td>"+ (movie.openDt ? movie.openDt : "") +"</td>"
							+ "<td>"+ movie.repGenreNm +"</td>"
							// 감독배열이 없는경우 Cannot read properties of undefined 에러 발생
							// kobis api에 감독이 없는 경우도 있어서 에러발생으로 중간에 조회 멈춤현상 해결
							// 영화감독배열이 존재하고 배열의 첫번째 요소가 존재하는지 판별후 감독명이 존재하면 출력
							+ "<td>"+ (movie.directors && movie.directors[0] && movie.directors[0].peopleNm ? movie.directors[0].peopleNm : "") +"</td>"
						+ "</tr>"
					);	
				}
			}
			
		}).fail(function() {
			alert("영화조회를 실패하였습니다");
		});
		
	}); // 영화조회하기 버튼 클릭이벤트 끝

	// 조회된 영화테이블에서 영화선택시 ajax를 통해 영화상세정보를 가져온후 영화등록form에 입력
	// 이벤트 위임 사용
	$(".search_table").on("click","tr",function() {
		$(this).find("input[type=radio]").prop("checked", true);
		// 선택될때마다 해당영화의 정보를 form에 입력하기위해 form 리셋
		$(".form02 button[type=reset]").trigger("click");
		
		let SearchedMovieCode = $(this).find("td:eq(0)").text();
		
		$.ajax({
			
			type : "GET",
			url : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
			data: {
       			key : "5b3c2582ad7390e87c71c7d1c30f4f55",
				movieCd : SearchedMovieCode
    		},
			dataType : "json"	
			
		}).done(function(data) {
			let movieInfo = data.movieInfoResult.movieInfo;
			$("input[name='movie_code']").val(SearchedMovieCode);
			$("input[name='movie_name']").val(movieInfo.movieNm);
			
			$("input[name='movie_genre']").val(function() {
				let genreResult = "";
				for(let genre of movieInfo.genres) {
					genreResult += genre.genreNm + " ";
				}
				return genreResult;
			});
			
			$("input[name='movie_director']").val(function() {
				let directorResult = "";
				for(let director of movieInfo.directors) {
					directorResult += director.peopleNm + " ";
				}
				return directorResult;
			});
			
			$("input[name='movie_actor']").val(function() {
				let actorResult = "";
				let count = 0;
				for(let actor of movieInfo.actors) {
					actorResult += actor.peopleNm + " ";
					count++;
					if(count == 4) {
						break;
					}
				}
				return actorResult;
			});
			
			// 개봉일이 String 으로 넘어와서 Date 타입 형식으로 변환
			let dateStr = movieInfo.openDt;
			let year = dateStr.substring(0, 4);
			let month = dateStr.substring(4, 6);
			let day = dateStr.substring(6,8);
			let formatDateStr = year + "-" + month + "-" + day;
			
			$("input[name='release_date']").val(formatDateStr);
			$("input[name='running_time']").val(movieInfo.showTm);
			$("input[name='age_limit']").val(movieInfo.audits[0].watchGradeNm);
			
			
			// KOBIS API를 통해 가져온 정보를 토대로 영화 평점, 줄거리, 이미지url, 트레일러 url를 
			// TBDM API를통해 조회 입력
			$.ajax({
				type : "GET",
				url : "http://api.themoviedb.org/3/search/movie",
				data : {
					api_key: "771dc18089a49dbfb0c5cefdfb38b1bf",
					query: movieInfo.movieNm,
					year: movieInfo.openDt.substring(0, 4),
					language: "ko"
				},
				dataType : "json"
			}).done(function(data) {
				let movieInfo2 = data.results[0];
				$("input[name='movie_rating']").val(Math.round(movieInfo2.vote_average * 10) / 10);
				$("textarea[name='movie_synopsis']").val(movieInfo2.overview);
				$("input[name='movie_img1']").val("https://image.tmdb.org/t/p/w500/" + movieInfo2.poster_path);
				
				// 영화이미지 url 조회 입력
				$.ajax({
					type : "GET",
					url : "http://api.themoviedb.org/3/movie/" + movieInfo2.id + "/images",
					data : {
						api_key: "771dc18089a49dbfb0c5cefdfb38b1bf",
					},
					dataType : "json"
				}).done(function(data) {
					let movieStillCutArr = data.backdrops;
					let stillCutCount = 0;
					for(let movieStillCut of movieStillCutArr) {
						$("input[name='movie_img" + (stillCutCount + 2) + "']").val("https://image.tmdb.org/t/p/w500/" + movieStillCut.file_path);
						stillCutCount++;
						if(stillCutCount == 4) {
							break;
						}
					}
				}).fail(function() {
					alert("영화상세정보를 가져오지 못했습니다");
				});
				
				// 영화 트레일러 url 조회 입력
				$.ajax({
					type : "GET",
					url : "http://api.themoviedb.org/3/movie/" + movieInfo2.id + "/videos",
					data : {
						api_key : "771dc18089a49dbfb0c5cefdfb38b1bf",
						language : "ko"
					},
					dataType : "json"
				}).done(function(data) {
					let trailerArr = data.results;
					for(let trailer of trailerArr) {
						if(trailer.name.includes("메인")) {
							$("input[name='movie_trailer']").val("http://www.youtube.com/watch?v=" + trailer.key);
							break;
						}
					}
				}).fail(function() {
					alert("영화상세정보를 가져오지 못했습니다");
				});
				
			}).fail(function() {
				alert("영화상세정보를 가져오지 못했습니다");
			});
			
			
		}).fail(function() {
			alert("영화상세정보를 가져오지 못했습니다");
		});
		
	});
	
	// ajax를 통해 검색어 검색으로 영화목록 요청
	$("#search02 input[type=button]").click(function() {
		// 검색어가 ""일경우 모든 영화출력됨으로 ""일경우 검색어 입력 경고창 출력
		if($("#search02>input[type=text]").val() == "") {
			alert("검색어를 입력해주세요");
		} else {
			$.ajax({
				type : "GET",
				url : "AdminMovieSetSearchBox",
				data : {
					howSearch : $(".search_box").val(),
					searchKeyword: $("#search02>input[type=text]").val()
				},
				dataType : "json"
			}).done(function(MovieList) {
				
				$("#sec02 > div").hide();
				
				$("#sec02>table").html(
					"<tr>"
						+ "<th><b><input type='radio'name='select_movie' disabled></b></th>"
						+ "<th>영화코드</th>"
						+ "<th>영화제목</th>"
						+ "<th>장르</th>"
						+ "<th>관람등급</th>"
						+ "<th>영화상태</th>"
						+ "<th>등록일자</th>"
						+ "<th>등록계정</th>"
					+ "</tr>"
				);
				
				// 조회 내역이 0이면 조회 조건 표시
				if(MovieList[0] == null) {
						$("#sec02>table").append(
								"<tr>"
									+ "<th  colspan='8'>검색 결과가 없습니다. 검색어를 확인해주세요<br>"
									+ "(영화상태 - 대기, 투표영화, 상영예정작, 현재상영작, 과거상영작<br>"
									+ "영화장르 - 코미디, 드라마, 액션, SF, 범죄,  스릴러, 공포, 판타지<br>"
									+ "애니메이션, 어드벤처, 미스터리... )"
									+ "</th>"
								+ "</tr>"
						);	
				} else {
					for(let movie of MovieList) {
						$("#sec02>table").append(
								"<tr>"
									+ "<th><input type='radio'name='select_movie'></th>"
									+ "<td>" + movie.movie_code + "</td>"
									+ "<td>" + movie.movie_name + "</td>"
									+ "<td>" + movie.movie_genre + "</td>"
									+ "<td>" + movie.age_limit + "</td>"
									+ "<td>" + movie.movie_status + "</td>"
									+ "<td>" + movie.str_regist_date +"</td>"
									+ "<td>" + movie.regist_admin_id  +"</td>"
								+ "</tr>"
						);	
					}
				}
			}).fail(function() {
				alert("검색에 실패하셨습니다")
			});
		}
	});
	
	// 선택된 행의 영화코드, 영화명, 영화상태 저장을 위한 변수(페이지로드시 마다 초기화)
	// 변수를 이용하여 영화정보조회, 영화삭제, 투표영화로등록, 상영예정작으로등록
	let selectMovieCode = "";
	let selectMovieName = "";
	let selectMovieStatus = "";
	
	// 테이블의 행 클릭시 해당행의 라디오버튼 클릭
	$("#sec02 > table").on("click", "tr", function() {
		$(this).find("input[type=radio]").prop("checked", true);
		selectMovieCode = $(this).find("td:eq(1)").text();
		selectMovieName = $(this).find("td:eq(2)").text();
		selectMovieStatus = $(this).find("td:eq(5)").text();
	});
	
	
	// 상영예정작으로 등록 버튼 클릭시 영화 상태 변경
	$("#regist_upcoming").click(function() {
		// 영화 선택 여부 판별
		if(selectMovieCode != "") {
			// 상영예정작으로 등록 가능 여부 판별
			if(selectMovieStatus != "대기") {
				alert("해당영화는 상영예정작으로 등록할 수 없습니다\n(영화상태가 대기인 경우에만 상영예정작으로 등록가능)")
			} else if(confirm("<" + selectMovieName + ">을 상영예정작으로 등록 하시겠습니까?")){
				$.ajax({
					type : "POST",
					url : "UpdateMovieStatusToUpcoming",
					data : {
						movie_code : selectMovieCode,
						movie_status : "상영예정작",
						column_name : "movie_status"
					},
				}).done(function(result) {
					console.log(typeof(result));
					console.log(result);
					alert(JSON.stringify(result));
				}).fail(function() {
					alert("상영예정작으로 등록 실패");
				});
			}
		} else {
			alert("영화를 선택해주세요");
		}
	});
	
	// 투표영화로 등록 버튼 클릭시 영화 상태 변경
	$("#regist_pick").click(function() {
		// 영화 선택 여부 판별
		if(selectMovieCode != "") {
			// 투표영화로 등록 가능 여부 판별
			if(selectMovieStatus != "대기") {
				alert("해당영화는 투표영화로 등록할 수 없습니다\n(영화상태가 대기인 경우에만 투표영화로 등록가능)")
			} else if(confirm("<" + selectMovieName + ">을 투표영화로 등록 하시겠습니까?")){
				$.ajax({
					type : "POST",
					url : "UpdateMovieStatusToPick",
					data : {
						movie_code : selectMovieCode,
						movie_status : "투표영화",
						column_name : "movie_status"
					},
				}).done(function(result) {
					console.log(typeof(result));
					console.log(result);
					alert(JSON.stringify(result));
				}).fail(function() {
					alert("투표예정작으로 등록 실패");
				});
			}
		} else {
			alert("영화를 선택해주세요");
		}
	});
	
}); // document ready 끝
	
	
	
	
	
	