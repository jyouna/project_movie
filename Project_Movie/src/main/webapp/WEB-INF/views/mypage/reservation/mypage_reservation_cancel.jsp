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
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/reservation/mypage_reservation_cancel.css" />
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
<article class="box post">
	<div id="title">
		<h1>취소내역</h1>
	</div>
      <section id="listForm">
         <table>
            <tr id="tr_top">
               <td width="33%">영화명</td>
               <td width="15%">관람일시</td>
               <td width="10%">관람인원</td>
               <td width="12%">취소승인상태</td>
               <td width="15%"> 취소승인일</td>
               <td width="15%">환불금액</td>
            </tr>
               
            <c:choose>
               <c:when test="${empty reservationCancel}"> 
                  <tr><td colspan="6">게시물이 존재하지 않습니다</td></tr>
               </c:when>
               <c:otherwise>
                  <c:forEach var="reservationCancel" items="${reservationCancel}" varStatus="status">
                     <tr>
                        <td>${reservationCancel.movie_name}</td>
                        <td>${reservationCancel.start_time}</td>
                        <td>${reservationCancel.ticket_count}</td>
                        <td>
<!--                         true일때는 취소완, false일때는 승인전 -->
	                   		<c:choose>
						      	<c:when test="${reservationCancel.refund_status}">취소완료</c:when> 
						      	<c:otherwise>승인전</c:otherwise>
						    </c:choose>
				
                        </td>
                        <td>
                           <fmt:formatDate value="${reservationCancel.refund_completed_date}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td>${reservationCancel.refund_amount}</td>
                     </tr>
                  </c:forEach>
               </c:otherwise>               
            </c:choose>
         </table>
      </section>

         <section id="pageList">
         <input type="button" value="&lt" 
            onclick="location.href='ReservationCancel?pageNum=${pageInfo.pageNum - 1}'" 
             <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
         
         <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
            <c:choose>
               <c:when test="${i eq pageInfo.pageNum }">
                  <strong>${i}</strong>
               </c:when>
               <c:otherwise>
                  <a href="ReservationCancel?pageNum=${i}">${i}</a>
               </c:otherwise>
            </c:choose>
         </c:forEach>
         
         
         <input type="button" value="&gt" 
            onclick="location.href='ReservationCancel?pageNum=${pageInfo.pageNum + 1}'" 
             <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
      </section>
	</article>

	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>