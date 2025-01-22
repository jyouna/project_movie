<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
						<img src="${schedule.movie_img1}">
					</div>
					
					<div class="book_detail">
				        <div class="row">
				            <div class="header">예매번호</div>
				            <div class="data">${param.payment_code}</div>
				        </div>
				        <div class="row">
				            <div class="header">영화</div>
				            <div class="data">${schedule.movie_name}</div>
				        </div>
				        <div class="row">
				            <div class="header">일시</div>
				            <div class="data">
				            	<fmt:parseDate var="parsedReplyDate"
												value="${schedule.start_time}"
												pattern="yyyy-MM-dd HH:mm"
												type="both" />
								<fmt:formatDate value="${parsedReplyDate}" pattern="yyyy.MM.dd'('E')' HH:mm"/>
			            	</div>
				        </div>
				        <div class="row">
				            <div class="header">인원</div>
				            <div class="data">
				            	<c:if test="${param.adult != 0}">
				            		일반 ${param.adult}명&nbsp;
				            	</c:if>
				            	<c:if test="${param.youth != 0}">
				            		청소년 ${param.youth}명&nbsp; 
				            	</c:if>
				            	<c:if test="${param.senior != 0}">
				            		경로/우대 ${param.senior}명
				            	</c:if>
				            </div>
				        </div>
						 <div class="row">
				            <div class="header">상영관</div>
				            <div class="data">
				            	<c:choose>
									<c:when test="${schedule.theater_code eq 'T1'}">
										1관
									</c:when>
									<c:when test="${schedule.theater_code eq 'T2'}">
										2관
									</c:when>
									<c:otherwise>
										3관
									</c:otherwise>
								</c:choose>
				            </div>
				        </div>
						 <div class="row">
				            <div class="header">좌석</div>
				            <div class="data">${param.totalSeat}</div>
				        </div>
						 <div class="row">
				            <div class="header">결제금액</div>
				            <div class="data">${param.total_payment} 원</div>
				        </div>
						 <div class="row">
				            <div class="header">결제수단</div>
				            <div class="data">${param.payment_method}</div>
				        </div>
					</div>
				</div>
				
						
				
				<div class="fin_btn">
					<button class="ticket_info_btn" name="ticket_info_btn" onclick="window.open('ReservationDetail', '_blank', 'width=1300, height=800, top=150, left=300, resizable=no')">예매내역</button>
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