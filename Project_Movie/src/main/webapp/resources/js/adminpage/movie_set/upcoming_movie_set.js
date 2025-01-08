$(function() {
	// 테이블의 값을 저장하기위한변수
	let movie_code = "";
	let movie_name = "";
	let screening_date = "";
	let start_screening_date = "";
	let end_screening_date = "";
	
	// 테이블 행 클릭시 해당행 라디오버튼 클릭 및 변수에 값 저장
	$("table").on("click", "tr", function() {
		$(this).find("input[type='radio']").prop("checked", true);
		movie_code = $(this).find("td:eq(0)").text();
		movie_name = $(this).find("td:eq(1)").text();
		screening_date = $(this).find("td:eq(2)").text()
		
		if(screening_date != "") {
			screening_date_Arr =screening_date.split(" ~ ");
			start_screening_date = screening_date_Arr[0];
			end_screening_date = screening_date_Arr[1];
		}
	});
	
    // 상영기간설정 모달 오픈
    $("#set_date_btn").on("click", function() {
		if(movie_code == "") {
			alert("영화를 선택해 주세요");
		} else if(screening_date != "") {
			alert("상영예정기간을 이미 입력하셨습니다")
		} else {
	        $("#screening_date_modal").css("display", "block");
			$(".modal_content").prepend("<h4><" + movie_name + "></h4>")
		}
    });

    // 모든 모달 닫기
    $(".close_modal").on("click", function() {
		location.reload();
    });
	
	// 상영기간설정 입력 버튼 클릭시 해당 기간으로 영화db정보 업데이트
	// 및 모달창닫고 reload
	$("#set_btn").click(function() {
		// 영화선택 여부 판별
		if(!isClicked()) {
			return;
		}
		
		// ajax를 통해 movie테이블의 상영시작일, 상영종요일 업데이트
		$.ajax({
			type : "post",
			url : "UpdateScreeningDate",
			data : {
				movie_code : movie_code,
				start_screening_date : start_screening_date,
				end_screening_date : end_screening_date
			}
		}).done(function(result) {
			$("#screening_date_modal").css("display", "none");
			location.reload();
			alert(result.msg);
		}).fail(function() {
			alert("상영일자설정 실패")
		});

	});
	
	// 영화정보 버튼 클릭시 ajax를 통해 DB영화정보 모달창에 출력
	$("#btnGroup02 input[type=button]").click(function() {
		
		if(!isClicked()) {
			return;
		}
		
		$("#movie_info_modal").css("display", "block");
		
		$.ajax({
			type : "GET",
			url : "SelectMovieInfo",
			data : {
				movie_code : movie_code
			}
		}).done(function(movie) {
			$("input[name='movie_code']").val(movie.movie_code);
			$("input[name='movie_name']").val(movie.movie_name);
			$("input[name='movie_genre']").val(movie.movie_genre);
			$("input[name='movie_director']").val(movie.movie_director);
			$("input[name='movie_actor']").val(movie.movie_actor);
			$("input[name='release_date']").val(movie.str_release_date);
			$("input[name='running_time']").val(movie.running_time);
			$("input[name='age_limit']").val(movie.age_limit);
			$("input[name='movie_rating']").val(movie.movie_rating);
			$("textarea[name='movie_synopsis']").val(movie.movie_synopsis);
			$("input[name='movie_img1']").val(movie.movie_img1);
			$("input[name='movie_img2']").val(movie.movie_img2);
			$("input[name='movie_img3']").val(movie.movie_img3);
			$("input[name='movie_img4']").val(movie.movie_img4);
			$("input[name='movie_img5']").val(movie.movie_img5);
			$("input[name='movie_trailer']").val(movie.movie_trailer);
			$("select[name='movie_status']").val(movie.movie_status);
		}).fail(function() {
			alert("영화정보를 가져오는데 실패하였습니다.");
		});
		
	});
	
	$("#remove_from_upcoming_btn").click(function() {
		
	});
	
	// 상영스케줄 설정버튼 클릭시 해당영화의 상영시작날짜의 1관 스케줄 상세 페이지로 포워딩
	$("#to_schedule_regist").click(function() {
		// 영화 선택여부 판별
		if(!isClicked()) {return};
		// 영화 상영기간 설정 여부 판별
		if(start_screening_date == "" || end_screening_date == "") {
			alert("상영기간을 설정해 주세요");
		} else {
			location.href = "AdminMovieSetScheduleDetail?theater_code=T1&select_date=" + start_screening_date;
		}
	});
	
	// 테이블 선택여부 판별 메서드
	function isClicked() {
		if(movie_code == "") {
			alert("영화를 선택해 주세요");
			return false;
		}
		return true;
	}
}); // document ready 끝
	
	
	
	
	
	