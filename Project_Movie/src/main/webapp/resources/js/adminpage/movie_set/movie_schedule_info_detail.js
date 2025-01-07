$(function() {
	// 선택 날짜 변수
	let scheduleDate = $("#btnGroup01 input[type=date]").val();
	// db에서 조회한 러닝타임
	
	// 날짜변경시 변경날짜 변수저장
	$("#btnGroup01 input[type=date]").change(function() {
		scheduleDate = $("#btnGroup01 input[type=date]").val();
	});
	
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
			$("select[name='selected_movie']").append(
				"<option value='" + movie.movie_code + "'>" + movie.movie_name + "</option>"
			);
		}
	});
	
	
	// 스케줄 등록 모달 오픈
	$("#regist_schedule_btn").click(function() {
		$("#schedule_regist_modal").css("display", "block");
		$("input[name='show_date']").val(scheduleDate);
	});
	
    // 스케줄 등록 모달 닫기
	$(".close_modal").click(function() {
		location.reload();
	});
	
    // 영화선택 설렉트박스 change 이벤트시 해당영화정보 스케줄 폼에 입력
	$("select[name='selected_movie']").change(function () {
		let movie_code = $("select[name='selected_movie']").val();
		
		$.ajax({
			type : "GET",
			url : "SelectMovieInfo",
			data : {
				movie_code : movie_code
			}
		}).done(function(movie) {
			// 시간 계산을 위해 변수에 저장
			runningTime = movie.running_time;
			$("input[name='movie_code']").val(movie.movie_code);
			$("input[name='movie_name']").val(movie.movie_name);
			$("input[name='running_time']").val(runningTime);
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
//			let startTime = scheduleDate + " " + $(this).val();
//			$("input[name='str_start_time']").val(startTime);
//			let dateTime = new Date(startTime);
//			dateTime.setMinutes(dateTime.getMinutes() + runningTime);
//			console.log(dateTime.getFullYear.toString());
//			hour = dateTime.getHours().toString().padStart(2, "0");
//			minute = dateTime.getMinutes.toString().padStart(2, "0");
//			$("input[name='e_time']").val(hour + ":" + minute);
			
		}
	});
	
	
}); // document ready 끝
	
