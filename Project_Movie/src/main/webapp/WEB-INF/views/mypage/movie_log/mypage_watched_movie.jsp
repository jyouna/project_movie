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
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/movie_log/mypage_watched_movie.css" />
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
	<article class="box post">
		<div id="title">
			<h1>내가 본 영화</h1>
		</div>
			<div id="selectBox"> 
				<select>
					<option>2024</option>
					<option>2023</option>
					<option>2022</option>
					<option>2021</option>
					<option>2020</option>
				</select>
				<input type="button" value="조회" id="inquire">
			</div>
	<!-- 			순서 체크하고 리뷰등록 누를경우 작성팝업 생성 -->
			<div style="text-align: right;">
				<input type="button" value="리뷰 등록" id="reviewRegister" >
			</div>
	      <section id="listForm">
	         <table>
	            <tr id="tr_top">
<!-- 	            순서는 체크박스 -->
	               <td>순서</td>
	               <td>영화명</td>
	               <td>관람일시</td>
	               <td>관람인원</td>
	               <td>관람좌석</td>
	               <td>상영관</td>
	            </tr>
	               
	            <c:choose>
	               <c:when test="${empty boardList}"> 
	                  <tr><td colspan="6">게시물이 존재하지 않습니다</td></tr>
	               </c:when>
	               <c:otherwise>
	                  <c:forEach var="board" items="${boardList}" varStatus="status">
	                     <tr>
	                        <td class="board_num">${board.board_num}</td>
	                        <td class="board_subject">${board.board_subject}</td>
	                        <td>${board.board_name}</td>
	                        <td>
	                           <fmt:formatDate value="${board.board_date}" pattern="yy-MM-dd - yy-MM-dd"/>
	                        </td>
	                        <td>${board.board_readcount}</td>
	                     </tr>
	                  </c:forEach>
	               </c:otherwise>               
	            </c:choose>
	         </table>
	      </section>
	            <section id="pageList">
	         <input type="button" value="&lt" 
	            onclick="location.href='BoardList?pageNum=${pageInfo.pageNum - 1}'" 
	             <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
	         
	         <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
	            <c:choose>
	               <c:when test="${i eq pageInfo.pageNum }">
	                  <strong>${i}</strong>
	               
	               </c:when>
	               <c:otherwise>
	                  <a href="BoardList?pageNum=${i}">${i}</a>
	               </c:otherwise>
	            </c:choose>
	         </c:forEach>
	         
	         
	         <input type="button" value="&gt" 
	            onclick="location.href='BoardList?pageNum=${pageInfo.pageNum + 1}'" 
	             <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
	      </section>
		</article>
	<script type="text/javascript">
		$(function () {
			$("#inquire").on("click", function() {
				confirm("조회 버튼 누르셨습니다.")
			});
			
			$("#reviewRegister").on("click", function() {
				window.open(
					'reviewRegister',
					'리뷰 등록 창',
					'width=400, height=700, scrollbars=no, resizeable=no');
			});
			
			
		});
	</script>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>