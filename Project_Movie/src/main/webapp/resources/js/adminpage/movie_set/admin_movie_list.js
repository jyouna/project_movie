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
	    if ($("input[name=search_method]:checked").val() == "movieNm") {
	        $("#movie_name").prop("disabled", false);
	        $("#director_name").prop("disabled", true);
	        $("#release_year_select1").prop("disabled", true);
	        $("#release_year_select2").prop("disabled", true);
	    } else if ($("input[name=search_method]:checked").val() == "directorNm") {
	        $("#movie_name").prop("disabled", true);
	        $("#director_name").prop("disabled", false);
	        $("#release_year_select1").prop("disabled", true);
	        $("#release_year_select2").prop("disabled", true);
	    } else if ($("input[name=search_method]:checked").val() == "releaseYear") {
	        $("#movie_name").prop("disabled", true);
	        $("#director_name").prop("disabled", true);
	        $("#release_year_select1").prop("disabled", false);
	        $("#release_year_select2").prop("disabled", true);
	    }
	});
	
	// 영화등록모달의 개봉기간으로 영화정보조회시 사용되는 년도 설렉트박스
	let startYear = 1960;
	let endYear = new Date().getFullYear();
	
	for(let year = startYear; year <= endYear; year++) {
		$("#release_year_select1").append("<option value='" + year + "'>" + year + "</option>");
	}
	
	/*
		조회시작년도 설렉트박스 선택시 조회끝년도 설렉트박스 활성화, 시작년도 보다 높고 현재년도와 낮거나 같은 년도만 선택가능
		조회시작년도 바뀔때마다 <option>이 추가되므로 중첩안되기위해 반복문 시작전 조회끝년도 설렉트박스 자식요소 삭제
	*/ 
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
				itemPerPage : 100
			};
		}
		
		// KOBIS OPEN API로 영화정보 조회 후 데이터 테이블 생성
		$.ajax({
			type : "GET",
			url : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json",
			data: Object.assign({
       			key: "5b3c2582ad7390e87c71c7d1c30f4f55"
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
				$(".search_table > table").append(
					"<tr>"
						+ "<th><input type='radio'name='select_movie'></th>"
						+ "<td>"+ (movie.movieCd ? movie.movieCd : "") +"</td>"
						+ "<td>"+ (movie.movieNm ? movie.movieNm : "") +"</td>"
						+ "<td>"+ (movie.openDt ? movie.openDt : "") +"</td>"
						+ "<td>"+ (movie.repGenreNm ? movie.repGenreNm : "") +"</td>"
						// 감독배열이 없는경우 Cannot read properties of undefined 에러 발생
						// kobis api에 감독이 없는 경우도 있어서 에러발생으로 중간에 조회 멈춤현상 해결
						// 영화감독배열이 존재하고 배열의 첫번째 요소가 존재하는지 판별후 감독명이 존재하면 출력
						+ "<td>"+ (movie.directors && movie.directors[0] && movie.directors[0].peopleNm ? movie.directors[0].peopleNm : "") +"</td>"
					+ "</tr>"
				);	
			}
			
		}).fail(function() {
			alert("영화조회를 실패하였습니다");
		});
		
	}); // 영화조회하기 버튼 클릭이벤트 끝

	// 조회된 영화테이블에서 영화선택시 ajax를 통해 영화상세정보를 가져온후 등록form에 입력
	// document ready 시점에서 table이 없기 때문에 이벤트 위임 사용
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
			
			$("input[name='release_date']").val(movieInfo.openDt);
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
	
	
}); // document ready 끝
	
	
	
	
	
	