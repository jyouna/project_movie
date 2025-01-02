<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Escape Velocity by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/book_tickets/book_finish.css">
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/book_tickets_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<div class="modal">
			<div class="modal_content">
				<div class="modal_close">x</div>
				<div class="msg_fin">
					<h2>예매가 완료되었습니다</h2>
				</div>
				<div class="book_info">
					<div class="poster">
						영화포스터
					</div>
					
					<div class="book_detail">
				        <div class="row">
				            <div class="header">예매번호</div>
				            <div class="data">0000-1234-5678-111</div>
				        </div>
				        <div class="row">
				            <div class="header">영화</div>
				            <div class="data">해피앤드</div>
				        </div>
				        <div class="row">
				            <div class="header">일시</div>
				            <div class="data">2024.12.13(금) 15:30 ~ 17:15</div>
				        </div>
				        <div class="row">
				            <div class="header">인원</div>
				            <div class="data">일반 1명, 청소년 1명</div>
				        </div>
						 <div class="row">
				            <div class="header">상영관</div>
				            <div class="data">1관</div>
				        </div>
						 <div class="row">
				            <div class="header">좌석</div>
				            <div class="data">D5, D6, D7</div>
				        </div>
						 <div class="row">
				            <div class="header">결제금액</div>
				            <div class="data">19000 원</div>
				        </div>
						 <div class="row">
				            <div class="header">결제수단</div>
				            <div class="data">신용카드</div>
				        </div>
					</div>
					
				</div>
				
				
						
				
				<div class="fin_btn">
					<button class="ticket_info_btn" name="ticket_info_btn" onclick="">예매내역</button>
					<button class="home_btn" name="home_btn" onclick="location.href='./'">홈</button>
				</div>
			</div>
		</div>
		
		<script>
			 $(".modal_close").click(function() {
				$(".modal").css("display", "none");
				$(".modal_content").css("display", "none");
			});
		</script>
	</article>
	
	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>