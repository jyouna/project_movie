$(function() {
	
	// 이벤트페이지 이전글 조회 
	$("#eventPrevBtn").click(function() {
		let tableName = "event_board";
		let columnName = "event_code"
		preNext("EventPost", tableName, columnName, columnValue, 0);
	});
	
	// 이벤트페이지 다음글 조회 
	$("#eventNextBtn").click(function() {
		let tableName = "event_board";
		let columnName = "event_code"
		preNext("EventPost", tableName, columnName, columnValue, 1);
	});
	
	// 공지사항페이지 이전글 조회 
	$("#noticePrevBtn").click(function() {
		let tableName = "notice_board";
		let columnName = "notice_code"
		preNext("NoticePost", tableName, columnName, columnValue, 0);
	});
	
	// 공지사항페이지 다음글 조회 
	$("#noticeNextBtn").click(function() {
		let tableName = "notice_board";
		let columnName = "notice_code"
		preNext("NoticePost", tableName, columnName, columnValue, 1);
	});
	
	// FAQ 이전글 조회 
	$("#faqPrevBtn").click(function() {
		let tableName = "faq_board";
		let columnName = "faq_code"
		preNext("FaqPost", tableName, columnName, columnValue, 0);
	});
	
	// FAQ 다음글 조회 
	$("#faqNextBtn").click(function() {
		let tableName = "faq_board";
		let columnName = "faq_code"
		preNext("FaqPost", tableName, columnName, columnValue, 1);
	});
	
	// 1:1문의 이전글 조회 
	$("#inquiryPrevBtn").click(function() {
		let tableName = "Inquiry";
		let columnName = "inquiry_code"
		preNext("InquiryPost", tableName, columnName, columnValue, 0);
	});
	
	// 1:1문의 다음글 조회 
	$("#inquiryNextBtn").click(function() {
		let tableName = "Inquiry";
		let columnName = "inquiry_code"
		preNext("InquiryPost", tableName, columnName, columnValue, 1);
	});
	
//	 이전 글, 다음 글 코드 조회메서드
	function preNext(url, tableName, columnName, columnValue, whereMove) {
		$.ajax({
			type : "GET",
		    url : "SearchPreNextCode",
			data : {
				tableName,
				columnName,
				columnValue
			}
		}).done(function(result) {
			if(whereMove == 0) {
				if(result.prevCode == null) {
					alert("이전 게시글이 존재하지 않습니다");
					return;
				} else {
					location.href = url + "?" + columnName + "=" + result.prevCode + "&pageNum=" + pageNum;
				}
			} else {
				if(result.nextCode == null) {
					alert("다음 게시글이 존재하지 않습니다");
					return;
				} else {
					location.href = url + "?" + columnName + "=" + result.nextCode + "&pageNum=" + pageNum;
				}
			}
		}).fail(function() {
			alert("이전글/다음글 조회에 실패하셨습니다");
		});
	}
});