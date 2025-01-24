$(function() {
	let theater_code = $("#btnGroup select").val();
	let selectedMonth = $("#btnGroup input[type='month']").val();
	
	// 뷰페이지 로딩 끝나고 달력이 만들어진 후 해당날에 등록된 스케줄 수 조회후 달력에 입력
	$.ajax({
		type : "GET",
		url : "GetScheduleCountOfDay",
		data : {
			theater_code,
			selectedMonth
		}
	}).done(function(scheduleCountList) {
		for(let scheduleCount of scheduleCountList) {
			$("." + scheduleCount.day).append(
				"<br><br><span><b>등록 스케줄 : " + scheduleCount.count + "개</b><span>"
			)
		}
	}).fail(function() {
		alert("스케줄 수 읽어오는대 실패 하였습니다");
	});
	
	// 상단의 관선택, 월선택 태그가 변경되었을 때 해당 관과 해당 월의 달력으로 포워딩
	$(".changeScheduleTable").change(function() {
		location.href = "AdminMovieSetSchedule?theater_code=" + $("#btnGroup select").val()
			+ "&selectedMonth=" + $("#btnGroup input[type='month']").val();
	});
	
	// 달력의 날짜를 클릭했을 때 해당날의 상세스케줄 페이지로 이동
	$("#body_main td").click(function() {
		// 날짜가없는 td 선택시 이벤트헨들러 종료
		if($(this).text().trim() == "") {
			return;
		}
		
		let select_date = selectedMonth + "-" + $(this).find(".day").text();
		location.href = "AdminMovieSetScheduleDetail?select_date=" + select_date + "&theater_code=" + theater_code;
	});
	
	// 날짜 판별후 오늘날짜 배경색 지정
	let today = new Date();
	let year = today.getFullYear();
	let month = today.getMonth() + 1
	month = month < 10 ? "0" + month : month;
	let day = today.getDate();
	today = year + '-' + month;
	
	if(selectedMonth == today) {
		$("." + day).css("background-color", "#FFFFE0")
	}

}); // document ready 끝
	
	
	
	
	
	