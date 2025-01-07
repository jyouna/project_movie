	$(function() {
		$(".event_subject").on("click", function(event) {
			let event_code = $(event.target).siblings(".event_code").text();
			console.log("siblings " + event_code);
			location.href = "EventPost?event_code=" + event_code + "&pageNum=${pageInfo.pageNum}";
		
		});
		
		$("#searchButton").on("click", function () {
			confirm("검색버튼 눌렸습니다.")
		});
		
	});