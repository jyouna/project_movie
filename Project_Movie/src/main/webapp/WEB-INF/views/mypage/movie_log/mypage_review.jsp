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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/movie_log/mypage_review.css" />
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<div id="title">
			<h1>관람평</h1>
		</div>
			<div id="topButton" style="text-align: right;">
				<input type="button" value="수정" id="reviewModify">
				<input type="button" value="삭제" id="delete">
			</div>
	      <section id="listForm">
	         <table>
	            <tr id="tr_top" align="center">
	               <td width="30"><input type="radio" disabled="disabled"></td>
	               <td width="100">영화명</td>
	               <td width="200">한줄평</td>
	               <td width="80">추천 / 비추천</td>
	               <td width="90">작성자</td>
	            </tr>
	               
	            <c:choose>	
	               <c:when test="${empty review}"> 
	                  <tr><td colspan="7">게시물이 존재하지 않습니다</td></tr>
	               </c:when>
	               <c:otherwise>
	                  <c:forEach var="review" items="${review}" varStatus="status">
	                     <tr>
	                        <td><input type="radio" ></td>
	                        <td>${review.movie_name }</td>
	                        <td>${review.review_content}</td>
	                        <td>
	                        	<c:choose>
		                        	<c:when test=" ${review.review_recommend == 0}">추천</c:when>
		                        	<c:when test=" ${review.review_recommend == 1}">비추천</c:when>
	                        	</c:choose>
	                       </td>
	                        <td>${review.review_writer}</td>
	                     </tr>
	                  </c:forEach>
	               </c:otherwise>               
	            </c:choose>
	         </table>
	      </section>
	            <section id="pageList">
	         <input type="button" value="&lt" 
	            onclick="location.href='Review?pageNum=${pageInfo.pageNum - 1}'" 
	             <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
	         
	         <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
	            <c:choose>
	               <c:when test="${i eq pageInfo.pageNum }">
	                  <strong>${i}</strong>
	               
	               </c:when>
	               <c:otherwise>
	                  <a href="Review?pageNum=${i}">${i}</a>
	               </c:otherwise>
	            </c:choose>
	         </c:forEach>
	         
	         
	         <input type="button" value="&gt" 
	            onclick="location.href='Review?pageNum=${pageInfo.pageNum + 1}'" 
	             <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
	      </section>
		</article>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>