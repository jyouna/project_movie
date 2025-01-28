<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- 장민기 20250123 -->
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	
	
	<title>관리자_리뷰_관리_페이지 admin_review_manage.jsp</title>
	
	
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
 	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" /> 
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" /> --%>
<%--  	<link href="${pageContext.request.contextPath}/resources/css/adminpage/review_manage/admin_review_manage.css" />  --%>
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage_styles.css" rel="stylesheet" /> --%>

<%-- 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/movie_log/mypage_review.css" /> --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminpage/review_manage/admin_review_manage.css" />


	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<%-- 	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script> --%>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/review_manage/admin_review_manage.js"></script>

</head>


<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
		<article class="box post">
		<div id="title">
			<h1>관리용 전체 리뷰 목록</h1>
		</div>
			<div id="topButton">
				<input type="button" value="수정" id="Modify" >
				<input type="button" value="삭제" id="delete">
			</div>
			<div id="search-bar" style="text-align:	left;">
<!-- 		여기서 선택하고 검색한 값을 넘겨줘야하니까 form 태그로 감싸고 action = NoticeList , 전달방식 - get -->
				<form action="AdminReviewManage" method="get" name="searchForm">
					<select id="searchType" name="searchType">
	<!-- 			옵션에 각각 값을 넣어준다 -->
						<option value="movie_name">영화명</option>
<!-- 						<option value="movie_code">영화코드</option> -->
						<option value="review_writer">작성자아이디</option>
						
					</select>
	<!-- 			검색어에는 name값을 searchKeyword로 준다 -->
					<input type="text" name ="searchKeyword" placeholder="검색어를 입력하세요.">
					<input type="submit" value="검색">
				</form>
	    	</div>
	      <section id="listForm">
	         <table>
	            <tr id="tr_top" align="center">
	               <td width="1%">택</td>
	               <td width="7%">리뷰코드</td> 
	               <td width="100">영화명</td>
	               <td width="170">영화리뷰</td>
	               <td width="6%">추천여부</td>
	               <td width="15%">작성자</td>
	            </tr>
	               
	            <c:choose>	
	               <c:when test="${empty reviewList}"> 
	                  <tr><td colspan="7">게시물이 존재하지 않습니다</td></tr>
	               </c:when>
	               <c:otherwise>
	                  <c:forEach var="review" items="${reviewList}" varStatus="status">
	                     <tr>
	                        <td><input type="radio" name="movie_code" value="${review.movie_code}" class="movie_code"></td>
	                        <td>${review.review_code}</td> <!-- 리뷰 코드 표시 -->
	                        <td>${review.movie_name}</td>
	                        <td>${review.review_content}</td>
	                        <td>
	                        	<c:choose>
								    <c:when test="${review.review_recommend eq 0}">
								        추천
								    </c:when>
								    <c:otherwise>
								        비추천
								    </c:otherwise>
								</c:choose>
	                       </td>
	                        <td>${review.review_writer}</td>
	                     </tr>
	                  </c:forEach>
	               </c:otherwise>               
	            </c:choose>
	         </table>
	      </section>
	      <c:if test="${not empty param.searchKeyword}">
				<c:set var="searchParam" value="&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}" />
			</c:if>
	            <section id="pageList">
	         <input type="button" value="&lt" 
	            onclick="location.href='AdminReviewManage?pageNum=${pageInfo.pageNum - 1}${searchParam}'" 
	             <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
	         
	         <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
	            <c:choose>
	               <c:when test="${i eq pageInfo.pageNum }">
	                  <strong>${i}</strong>
	               
	               </c:when>
	               <c:otherwise>
	                  <a href="AdminReviewManage?pageNum=${i}${searchParam}">${i}</a>
	               </c:otherwise>
	            </c:choose>
	         </c:forEach>
	         
	         
	         <input type="button" value="&gt" 
	            onclick="location.href='AdminReviewManage?pageNum=${pageInfo.pageNum + 1}${searchParam}'" 
	             <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
	      </section>
		</article>
		
		<div id="watched_movie_modify_modal" class="modal">
		    <div class="watched_movie_modify">
		        <h2>리뷰 수정</h2>
		        <hr>
		        <div>
		            <!-- 영화명 표시 (readonly로 수정 불가능하게 설정) -->
		            <label id="review_content">영화명<input type="text" name="movie_name" readonly></label><br>
		            
		            <!-- 리뷰 내용 표시 -->
		            <label id="review_content">영화 리뷰내용</label>
		            <br>
		            <!-- 리뷰 내용을 입력할 textarea (필수 입력 필드) -->
		            <textarea cols="40" rows="3" name="review" required="required"></textarea>
		            <br> 
		            
		            <!-- 추천 여부 선택 (라디오 버튼) -->
		            <label id="review_recommend0">추천</label>
		            <input type="radio" name="review_recommend" value="0" required="required">
		            <label id="review_recommend1">비추천</label>
		            <input type="radio" name="review_recommend" value="1"><br>
		        </div>
		        <hr>
		        <div class="btnGroup">
		            <!-- 수정 완료 버튼 -->
		            <button type="button" class="submit_modal">등록</button>
		            <!-- 취소 버튼 -->
		            <button type="button" class="cancel_modal">취소</button>
		        </div>
		    </div>
		</div>

	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>