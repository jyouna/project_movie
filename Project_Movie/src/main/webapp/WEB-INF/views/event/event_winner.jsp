<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/event/event_winner.css" />
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/event_sidebar.jsp"></jsp:include>
	
	<div id="title">
		<h1>당첨자 발표</h1>
	</div>
	    <div class="search-bar" style="text-align:	right;">
	    <form action="EventWinnerBoard" method="get" name="searchForm">
	      <select name="searchType">
	        <option value="subject">제목</option>
	        <option value="content">내용</option>
	      </select>
	      <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요.">
	      <input type="submit" value="검색">
		</form>
	    </div>
		<section id="listForm">
			<table id="eventWinnerForm" border="1">
				<tr id="tr_top" align="center">
					<td width="35px">순서</td>
					<td width="80px">구분</td>
					<td width="170px">제목</td>
					<td width="100px">당첨자 발표일</td>
					<td width="35px">조회수</td>
				</tr>
				<c:choose>
					<c:when test="${empty eventWinnerBoardList}"> 
						<tr><td colspan="5">게시물이 존재하지 않습니다</td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="eventWinnerBoard" items="${eventWinnerBoardList}" varStatus="status">
							<tr>
								<td class="winner_code" id="winner_code">${eventWinnerBoard.winner_code}</td>
								<td>${eventWinnerBoard.winner_division}</td>
								<td class="winner_subject">${eventWinnerBoard.winner_subject}</td>
								<td>
									<fmt:formatDate value="${eventWinnerBoard.winner_announce_date}" pattern="yyyy-MM-dd"/>
								</td>
								<td>${eventWinnerBoard.winner_views}</td>
							</tr>
						</c:forEach>
					</c:otherwise>					
				</c:choose>
			</table>
		</section>
				<section id="pageList">
			<input type="button" value="&lt" 
				onclick="location.href='WinnerList?pageNum=${pageInfo.pageNum - 1}'" 
				 <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
			
			<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
				<c:choose>
					<c:when test="${i eq pageInfo.pageNum }">
						<strong>${i}</strong>
					
					</c:when>
					<c:otherwise>
						<a href="WinnerList?pageNum=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			
			<input type="button" value="&gt" 
				onclick="location.href='WinnerList?pageNum=${pageInfo.pageNum + 1}'" 
				 <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		</section>
	
	<script type="text/javascript">
		$(function () {
			$(".winner_subject").on("click", function(event) {
				let winner_code = $(event.target).siblings(".winner_code").text();
				console.log("siblings " + winner_code);
				location.href = "WinnerPost?winner_code=" + winner_code + "&pageNum=${pageInfo.pageNum}";
			});
		});
	</script>


	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>