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
	<link href="${pageContext.request.contextPath}/resources/css/mypage/movie_log/mypage_watched_movie.css" rel="stylesheet"/>
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/is/mypage/watched_movie.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
	<article class="box post">
		<div id="title">
			<h1>내가 본 영화</h1>
		</div>
			* 영화 조회는 최근 5년 내역만 조회가 가능합니다
			<div id="selectBox">
				<form action="watchedMovie" method="get">
					<select name="searchYear">
						<option>2025</option>
						<option>2024</option>
						<option>2023</option>
						<option>2022</option>
						<option>2021</option>
					</select>
					<input type="submit" value="조회">
				</form>
			</div>
	<!-- 			순서 체크하고 리뷰등록 누를경우 작성팝업 생성 -->
			<div style="text-align: right;">
				<input type="button" value="리뷰 등록" id="reviewRegister" >
			</div>
	      <section id="listForm">
	         <table>
	            <tr id="tr_top">
	               <td><input type="radio" name ="watchedMovie" disabled="disabled"></td>
	               <td>영화명</td>
	               <td>관람일시</td>
	               <td>관람인원</td>
	               <td>리뷰 등록</td>
	            </tr>
	           
	            <c:choose>
	               <c:when test="${empty watchedMovie}"> 
	                  <tr><td colspan="5">게시물이 존재하지 않습니다</td></tr>
	               </c:when>
	               <c:otherwise>
	                  <c:forEach var="watchedMovie" items="${watchedMovie}" varStatus="status">
	                     <tr>
	                      	<td><input type="radio"></td>
	                        <td>${watchedMovie.w_moviename}</td>
	                        <td>
	                        	<fmt:formatDate value="${watchedMovie.w_date}" pattern="yyyy-MM-dd"/>
                        	</td>
	                        <td>${watchedMovie.w_people}</td>
	                        <td>
	                        	<c:choose>
	                        		<c:when test="${watchedMovie.w_review == 0}">리뷰등록전</c:when>
	                        		<c:when test="${watchedMovie.w_review == 1}">리뷰등록완료</c:when>
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
	            onclick="location.href='WatchedMovie?pageNum=${pageInfo.pageNum - 1}'" 
	             <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
	         
	         <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
	            <c:choose>
	               <c:when test="${i eq pageInfo.pageNum }">
	                  <strong>${i}</strong>
	               
	               </c:when>
	               <c:otherwise>
	                  <a href="WatchedMovie?pageNum=${i}">${i}</a>
	               </c:otherwise>
	            </c:choose>
	         </c:forEach>
	         <input type="button" value="&gt" 
	            onclick="location.href='WatchedMovie?pageNum=${pageInfo.pageNum + 1}'" 
	             <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
	      </section>
		</article>
		<div id="watched_movie_review_modal" class="modal">
		<div class="watched_movie_review">
		    <h2>리뷰 등록</h2>
		    <hr>
	        <label>영화명</label><input type="text" name="r_moviename" readonly><br>
	        <label>관람일</label><input type="datetime-local" name="r_date" readonly><br>
	        <label>추천</label><input type="radio" name="a"><br>
	        <label>비추천</label><input type="radio" name="a"><br>
	        <hr>
	        <div class="btnGroup">
	        	<button type="submit" class="submit_modal">등록</button>
	        	<button type="button" class="cancel_modal">취소</button>
	        </div>
		</div>
	</div>
		
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>