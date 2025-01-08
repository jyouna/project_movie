<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/book_tickets/book_seat.css">
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/book_tickets/book_seat.js"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/book_tickets_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<!-- 	모달창 -->
		<div class="modal">
			<div class="modal_content">
				<div class="modal_close">x</div>
				<div class="choice_seat">
					<h2>인원/좌석 선택</h2>
				</div>
				<form action="BookSeat" name="seatChoice" method="post">
					<ul>
						<c:forEach var="type" items="성인, 청소년, 노약자">
							<li>
								<strong>${type}</strong>
								<div class="ctrl_box">
									<button type="button" class="minus_btn">-</button>
									<input type="text" class="count" name="count" value="0" readonly>
									<button type="button" class="plus_btn">+</button>
								</div>
							</li>
						</c:forEach>
					</ul>
					
					<span class="space_line"></span>
					
					<div class="seat_container">
						<div class="msg">인원 선택 후 좌석을 선택해주세요</div>
			            <div class="screen">SCREEN</div>
				            <c:forEach var="j" begin="0" end="${rowCount-1}">
					            <div class="seat_row">
					            	<c:forEach var="i" begin="0" end="${colCount-1}">
						                <button type="button" class="seat" name="seatName">${seatList[i + j*10].seat_code}</button>
					            	</c:forEach>
					            </div>
				            </c:forEach>
			        </div>
					
					<span class="space_line"></span>
	
					<div class="mv_info_container">
						<div class="top_info">
							<div class="book_info">예매정보</div>
							<div class="pay_info">결제</div>	
						</div>
						<div class="tnb">
							<div class="bottom_btn">
								<button type="button" class="back_btn" onclick="history.back()">이전</button>
							</div>
							<div class="poster">
								<div class="mv_poster">영화포스터</div>
								<div class="mv_title">해피엔드</div>
							</div>
							<!-- 영화관 정보 섹션 -->
							<div class="mv_info">
						        <div class="row">
						            <div class="header">일시</div>
						            <div class="data">2024.12.30(월) 23:00</div>
						        </div>
						        <div class="row">
						            <div class="header">상영관</div>
						            <div class="data">1관</div>
						        </div>
						        <div class="row">
						            <div class="header">인원</div>
						            <div class="data">일반 1명, 청소년 1명</div>
						        </div>
								 <div class="row">
						            <div class="header">좌석</div>
						            <div class="data">D5, D6, D7</div>
						        </div>
							</div>
							
							<!-- 결제 정보 섹션 -->
						   	<div class="ticket_info">
						        <div class="row">
						            <div class="header">성인</div>
						            <div class="data">
						            	<span class="price">10000</span>
						            	<span class="exe"> 원 X</span>
						            	<span class="qty"> 2</span>
						            </div>
						        </div>
						        <div class="row">
						            <div class="header">청소년</div>
						            <div class="data">
						            	<span class="price">8000</span>
						            	<span class="exe"> 원 X</span>
						            	<span class="qty"> 1</span>
					        		</div>
						        </div>
						        <div class="row">
						            <div class="header">총금액</div>
						            <div class="data">
						            	<span class="price">28000</span>
						                <span class="won"> 원</span>
						            </div>
						        </div>
							</div>
						
							<div class="bottom_btn">
								<button type="button" class="pay_btn" onclick="location.href='BookPay'">결제</button>
							</div>
						</div>
					</div>
				</form>
				
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