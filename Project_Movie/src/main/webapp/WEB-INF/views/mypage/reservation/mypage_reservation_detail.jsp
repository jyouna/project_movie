<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html lang="en">
<html>
<head>	
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>마이페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/mypage/reservation/mypage_reservation_detail.css" rel="stylesheet" />
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/mypage/reservation_detail.js"></script>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
 <article class="box post">
 	<div id="title">
		<h1>예매내역</h1>
 	</div>
		<h6>${sessionScope.sMemberId}님 관람가능한 예매내역이 ${reservationList.size() }건 입니다.</h6>
      <section id="listForm">
         <table>
            <tr id="tr_top">
	           	<td width="5%"><input type="radio" name="reservationRadio" disabled="disabled"></td>
				<td width="12%">예매번호</td>
				<td width="20%">영화명</td>
				<td width="11%">관람인원</td>
				<td width="11%">관람좌석</td>
				<td width="9%">상영관</td>
				<td width="15%">상영일시</td>
				<td width="10%">금액</td>
            </tr>
               
            <c:choose>
               <c:when test="${empty reservationList}"> 
                  <tr><td colspan="9">예매내역이 존재하지 않습니다</td></tr>
               </c:when>
               <c:otherwise>
                  <c:forEach var="reservationDetail" items="${reservationList}" varStatus="status">
                     <tr>
                    	<td><input type="radio" name="reservationRadio"></td>
                        <td>${reservationDetail.payment_code}</td>
                        <td>${reservationDetail.movie_name}</td>
                        <td>${reservationDetail.ticket_count}</td>
                        <td>${reservationDetail.total_seat_code}</td>
                        <td>
                        	<c:choose>
                        		<c:when test="${reservationDetail.theater_code eq 'T1'}">1관</c:when>
                        		<c:when test="${reservationDetail.theater_code eq 'T2'}">2관</c:when>
                        		<c:when test="${reservationDetail.theater_code eq 'T3'}">3관</c:when>
                        	</c:choose>
                        <td>
                           <fmt:formatDate value="${reservationDetail.start_time}" pattern="yyyy-MM-dd HH:mm"/>
                        </td>
                        <td>${reservationDetail.total_payment}</td>
                     </tr>
                  </c:forEach>
               </c:otherwise>               
            </c:choose>
         </table>
      </section>
      <br>
	<div id="underButton" style="text-align: right;">
      <input type="button" value="상세보기" id="detail">
      <input type="button" value="예매취소" id="cancel">
	</div>
         <section id="pageList">
         <input type="button" value="&lt" 
            onclick="location.href='ReservationDetail?pageNum=${pageInfo.pageNum - 1}'" 
             <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
         
         <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
            <c:choose>
               <c:when test="${i eq pageInfo.pageNum }">
                  <strong>${i}</strong>
               
               </c:when>
               <c:otherwise>
                  <a href="ReservationDetail?pageNum=${i}">${i}</a>
               </c:otherwise>
            </c:choose>
         </c:forEach>
         
         
         <input type="button" value="&gt" 
            onclick="location.href='ReservationDetail?pageNum=${pageInfo.pageNum + 1}'" 
             <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
      </section>
	</article>
	<div id="reservation_detail_modal" class="modal">
		<div class="reservation_detail">
		    <h2>상세 정보</h2>
		    <hr>
	        <label>예매번호</label><input type="text" name="payment_code" readonly><br>
	        <label>영화명</label><input type="text" name="movie_name" readonly><br>
	        <label>상영관</label><input type="text" name="theater_code" readonly><br>
	        <label>좌석</label><input type="text" name="total_seat_code" readonly><br>
	        <label>관람인원</label><input type="text" name="ticket_count" readonly><br>
	        <label>가격</label><input type="text" name="total_amount" readonly><br>
	        <hr>
			<h3>취소환불규정안내</h3>
			<div id= "content">
				<b>취소 마감시간</b>은 상영 시작 시간 30분 전입니다.<br>
				<b>관람일 전일 오후 5시 이후</b>(일요일은 오전 11시) 또는 <b>관람일 당일</b> 예매하신 건에 대해서는 예매 후 취소∙변경∙환불이 불가합니다.<br>
				<b>토요일이 공휴일인 경우</b>, 토요일 오전 11시 기준으로 적용됩니다.<br>

			</div>
	        <div class="btnGroup">
	        	<button type="button" class="close_modal">닫기</button>
	        </div>
		</div>
	</div>
	

	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
</body>
</html>