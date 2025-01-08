$(function() {
	// 선택 날짜 변수저장, 스케줄 등록 폼에 입력
	let scheduleDate = $("#btnGroup01 input[type=date]").val();
	// 선택 관 변수저장, 스케줄 등록폼에 입력
	let selectTheater = $("#btnGroup01>select").val();
	$("input[name=theater_code]").val(selectTheater);
	
	// 상영예정작 조회후 추가
	$.ajax({
		type : "GET",
		url : "AdminMovieSetSearchBox",
		data : {
			column_name : "movie_status",
			select_condition : "상영예정작"
		}
	}).done(function(movieList) {
		for(let movie of movieList) {
			// 영화상영기간 미설정 여부 판단, 영화상영기간 설정이 완료된 후에 상영스케줄 설정 가능
			// 아래에 selectbox 핸들러에 change이벤트시 경고창 및 영화상영기간 설정창으로 이동 작업예정
			if(movie.start_screening_date == null || movie.end_screening_date == null) {
				$("select[name='selected_movie']").append(
					"<option value='noPeriod'>" + movie.movie_name + "</option>"
				);
			} else {
				$("select[name='selected_movie']").append(
					"<option value='" + movie.movie_code + "'>" + movie.movie_name + "</option>"
				);
			}
		}
	});
	
	// 스케줄 등록 모달 오픈
	$("#regist_schedule_btn").click(function() {
		$("#schedule_regist_modal").css("display", "block");
	});
	
    // 스케줄 등록 모달 닫기
	$(".close_modal").click(function() {
		location.reload();
	});
	
    // 영화선택 설렉트박스 change 이벤트시 해당영화정보 스케줄 등록 폼에 입력
	$("select[name='selected_movie']").change(function () {
		// 상영기간 미설정 영화 선택시 상영기간 설정 필수 알람창 노출
		if($("select[name='selected_movie']").val() == "noPeriod") {
			alert("영화 상영기간이 설정되지 않았습니다\n 상영기간 설정화면으로 이동합니다");
			location.href="AdminMovieSetUpcoming";
		}
		
		let movie_code = $("select[name='selected_movie']").val();
		
		$.ajax({
			type : "GET",
			url : "SelectMovieInfo",
			data : {
				movie_code : movie_code
			}
		}).done(function(movie) {
			$("input[name='movie_code']").val(movie.movie_code);
			$("input[name='movie_name']").val(movie.movie_name);
			$("input[name='running_time']").val(movie.running_time);
		}).fail(function(){
			alert("영화정보 불러오기 실패하였습니다");
		});
	});
	
	// 시작시간이 입력되었을때 러닝타임과 계산하여 끝시간 입력
	$("input[name='s_time']").change(function() {
		if($("select[name='selected_movie']").val() == "") {
			alert("영화를 선택해 주세요\n(종료시간 및 스케줄 등록 가능여부 판별 위해 러닝타임 필요)");
			$(this).val("");
		} else {
			let runningTime = $("input[name=running_time]").val();
			let startTime = scheduleDate + " " + $(this).val();
			
			// 선택한시간에 러닝타임을 더해 상여종료 시간 계산 후 스케줄 입력 폼요소에 입력
			$("input[name='str_start_time']").val(startTime);
			//String 타입을 날짜시간 계산을위해 Date 타입으로 변환
			let dateTime = new Date(startTime);
			// 시작 시간을 기준으로 영화타입 "조조", "일반", "심야" 판별 후 폼요소에 입력
			let showtimeType = "";
			if(dateTime.getHours() < 10) {
				showtimeType = "조조"
			} else if(dateTime.getHours() >= 22) {
				showtimeType = "심야"
			} else {
				showtimeType = "일반"
			}
			
			// 상영시간대타입 폼요소에 입력
			$("input[name='showtime_type']").val(showtimeType);
			
			// 변환된 Date에 러닝타임 더하기 계산
			dateTime.setMinutes(dateTime.getMinutes() + Number(runningTime));
			// 계산된 Date form에 입력, 스트링타입으로 form 요청 후 자바에서 원하는형식으로 변환후 스케줄 insert 예정
			$("input[name='str_end_time']").val(dateTime);
			// 계산된 시간을 보여주기위해 HH:mm 형식으로 변환 후 input type="time"에 입력
			calHour = dateTime.getHours() < 10 ? '0' + dateTime.getHours() : dateTime.getHours()
			calMinute = dateTime.getMinutes() < 10 ? '0' + dateTime.getMinutes() : dateTime.getMinutes()
			calTime = calHour + ":" + calMinute;
			$("input[name='e_time']").val(calTime);
			
			
		}
	});
	
}); // document ready 끝
	
