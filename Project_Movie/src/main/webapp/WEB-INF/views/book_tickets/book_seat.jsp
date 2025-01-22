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
				<form action="BookPay"  method="post">
					<input type="hidden" name="schedule_code" value="${schedule.schedule_code}">
					<ul>
						<c:forEach var="type" items="${ticketType}">
							<li>
								<strong>${type.ticket_type}</strong>
								<div class="ctrl_box">
									<button type="button" class="minus_btn" value="${schedule.showtime_type}">-</button>
									<input type="text" class="count" value="0" readonly)>
									<button type="button" class="plus_btn" value="${schedule.showtime_type}">+</button>
								</div>
							</li>
					
						</c:forEach>
					</ul>
					<!-- 관객 타입별 인원수 받아오기 -->
					<input type="hidden" name="adult" id="adult">
					<input type="hidden" name="youth" id="youth">
					<input type="hidden" name="senior" id="senior">
					<span class="space_line"></span>
					
					<!-- 좌석 버튼 -->
					<div class="seat_container">
						<div class="msg">인원 선택 후 좌석을 선택해주세요</div>
			            <div class="screen">SCREEN</div>
			            <c:forEach var="j" begin="0" end="${rowCount-1}">
				            <div class="seat_row">
				            	<c:forEach var="i" begin="0" end="${colCount-1}">
					                <button type="button" class="seat"
					                	<c:forEach var="disabledSeat" items="${disabledSeatList}">
					                		<c:if test="${seatList[i + j*10].seat_code eq disabledSeat.seat_code}">
					                			disabled 
					                		</c:if>
					                	</c:forEach>
					                	<c:if test="${(i eq 7 and j eq 0) or (i eq 8 and j eq 0)}">name="wheelChairSeat"</c:if>>
					                	${seatList[i + j*10].seat_code}
				                	</button>
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
								<div class="mv_poster"><img src="${schedule.movie_img1}"></div>
								<div class="mv_title">
									<div>${schedule.movie_name}</div>
								</div>
							</div>
							<!-- 영화관 정보 섹션 -->
							<div class="mv_info">
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
						        	<!-- data 부분 ajax로 append -->
						            <div class="header">인원</div>
						            <div class="data"></div>
						        </div>
								 <div class="row">
						            <div class="header">좌석</div>
						            <div class="data"></div>
						        </div>
							</div>
							<input type="hidden" name="totalSeat" id="totalSeat">
							<!-- 결제 정보 섹션 -->
						   	<div class="ticket_info">
						   		<input type="hidden" id="totalAmount" name="totalAmount">
							</div>
						
							<div class="bottom_btn">
								<button type="submit" class="pay_btn">결제</button>
							</div>
						</div>
					</div>
				</form>
				
			</div>
		</div>
		
		<script>
			// 모달창 닫기 버튼
			$(".modal_close").click(function() {
				$(".modal").css("display", "none");
				$(".modal_content").css("display", "none");
			});
			
			let contextPath = "${pageContext.request.contextPath}";
			
			// 긴 영화제목 스크롤 애니메이션 효과
			$(document).ready(function () {
			    $('.mv_title').each(function () {
			        let title = $(this); // 현재 mv_title 요소
			        let inner = title.find('div'); // 내부 텍스트 div 선택

			        // 실제 텍스트 너비와 컨테이너 너비 비교
			        if (inner[0].scrollWidth > title.width()) {
			        	inner.css("animation", "marquee-scroll 5s linear infinite");
			            inner.addClass('marquee-scroll'); // 애니메이션 클래스 추가
			        } else {
			            $inner.removeClass('marquee-scroll'); // 애니메이션 클래스 제거
			        }
			    });
			});	
		</script>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>