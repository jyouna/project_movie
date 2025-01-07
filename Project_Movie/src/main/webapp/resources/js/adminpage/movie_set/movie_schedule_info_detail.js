//$(function() {
//	// 선택 날짜 변수
//	let scheduleDate = $("#btnGroup01 input[type=date]").val();
//	
//	// 날짜변경시 변경날짜 변수저장, 모달창 상영날짜 입력
//	$("#btnGroup01 input[type=date]").change(function() {
//		scheduleDate = $("#btnGroup01 input[type=date]").val();
//	});
//	
//	// 상영예정작 조회후 추가
//	$.ajax({
//		type : "GET",
//		url : "AdminMovieSetSearchBox",
//		data : {
//			column_name : "movie_status",
//			select_condition : "상영예정작"
//		}
//	}).done(function(movieList) {
//		for(let movie of movieList) {
//			$("select[name='selected_movie']").append(
//				"<option value='" + movie.movie_code + "'>" + movie.movie_name + "</option>"
//			);
//		}
//	});
//	
//	
//	// 스케줄 등록 모달 오픈
//	$("#regist_schedule_btn").click(function() {
//		$("#schedule_regist_modal").css("display", "block");
//		$("input[name='str_schedule_date']").val(scheduleDate);
//	});
//	
//    // 영화선택 설렉트박스 change 이벤트시 해당영화정보 스케줄 폼에 입력
//	$("select[name='selected_movie']").change(function () {
//		let movie_code = $("select[name='selected_movie']").val();
//		
//		$.ajax({
//			type : "GET",
//			url : "SelectMovieInfo",
//			data : {
//				movie_code : movie_code
//			}
//		}).done(function(movie) {
//			$("input[name='movie_code']").val(movie.movie_code);
//		}).fail(function(){
//			alert("영화정보 불러오기 실패하였습니다");
//		});
//	});
//	
//    // 스케줄 등록 모달 닫기
//	$(".close_modal").click(function() {
//		location.reload();
//	});
//	
//}); // document ready 끝
	
	
	
	
	
	