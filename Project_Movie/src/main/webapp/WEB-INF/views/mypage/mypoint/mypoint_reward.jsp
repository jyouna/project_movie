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
	<link href="${pageContext.request.contextPath}/resources/css/mypage/mypoint/mypoint_reward.css"  rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
	<article class="box post">
		<div id="title">
			<h1>포인트</h1>
		</div>
		<h6>${sessionScope.sMemberId } 님의 사용 가능한 포인트는 <fmt:formatNumber pattern="#,###" value="${member.point}"></fmt:formatNumber>포인트 입니다.</h6>
        <p>* 포인트는 소멸되지 않습니다.</p>
	      <section id="listForm">
	         <table>
	            <tr id="tr_top">
	               <td width="100px">적립날짜</td>
	               <td width="180px">상세내용</td>
	               <td width="100px">적립포인트</td>
	               <td width="100px">인출포인트</td>
	            </tr>
	               
	            <c:choose>
	               <c:when test="${empty pointList}"> 
	                  <tr><td colspan="5">포인트 내역이 존재하지 않습니다</td></tr>
	               </c:when>
	               <c:otherwise>
	                  <c:forEach var="point" items="${pointList}" varStatus="status">
	                     <tr>
	                        <td>
	                           <fmt:formatDate value="${point.regis_date}" pattern="yyyy-MM-dd"/>
	                        </td>
	                        <td>
	                        	<c:if test="${not empty point.event_subject}">
	                        			${point.event_subject}
                       			</c:if>
	                        	<c:if test="${point.point_debited != null && empty point.event_subject}">
	                        			영화 예매 포인트 차감
                       			</c:if>
	                        	<c:if test="${point.point_credited > 0 && empty point.event_subject}">
	                        			영화 예매 취소 포인트 적립
                       			</c:if>
	                        </td>
	                        <td>
	                        	<c:choose>
									<c:when test="${point.point_credited > 0}">
									 +<fmt:formatNumber pattern="#,###" value="${point.point_credited}"></fmt:formatNumber>
									</c:when>                        
	                        	</c:choose>
	                       </td>
	                        <td>
                             	<c:choose>
									<c:when test="${point.point_debited != null}">
									  -<fmt:formatNumber pattern="#,###" value="${point.point_debited}"></fmt:formatNumber>
									</c:when>                        
	                        	</c:choose>
	                       </td>
	                     </tr>
	                  </c:forEach>
	               </c:otherwise>               
	            </c:choose>
	         </table>
	      </section>
          <section id="pageList">
	         <input type="button" value="&lt" 
	            onclick="location.href='MypointReward?pageNum=${pageInfo.pageNum - 1}'" 
	             <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
	         
	         <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
	            <c:choose>
	               <c:when test="${i eq pageInfo.pageNum }">
	                  <strong>${i}</strong>
	               </c:when>
	               <c:otherwise>
	                  <a href="MypointReward?pageNum=${i}">${i}</a>
	               </c:otherwise>
	            </c:choose>
	         </c:forEach>
	         
	         
	         <input type="button" value="&gt" 
	            onclick="location.href='MypointReward?pageNum=${pageInfo.pageNum + 1}'" 
	             <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
	      </section>
		</article>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>