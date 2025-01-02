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
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/event_sidebar.jsp"></jsp:include>
	

		<h1>당첨자 발표</h1>
	    <div class="search-bar">
	      <select>
	        <option>제목</option>
	        <option>내용</option>
	      </select>
	      <input type="text">
	      <button style="width: 100px; height: 50px;">검색</button>
	    </div>
		<section id="listForm">
			<table id="eventWinnerForm" border="1">
				<tr id="tr_top" align="center">
					<td width="100px">구분</td>
					<td width="150px">제목</td>
					<td width="100px">당첨자 발표일</td>
				</tr>
				<tr>
					<td>시사회 / 무대인사</td>
					<td>소방관 시사회 당첨자 발표</td>
					<td>2024.11.25</td>
				</tr>	
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${empty winnerList}">  --%>
<!-- 						<tr><td colspan="5">게시물이 존재하지 않습니다</td></tr> -->
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<%-- 						<c:forEach var="winner" items="${winnerList}" varStatus="status"> --%>
<!-- 							<tr> -->
<%-- 								<td class="winner_num">${winner.winner_num}</td> --%>
<%-- 								<td class="winner_subject">${winner.winner_subject}</td> --%>
<%-- 								<td>${winner.winner_name}</td> --%>
<!-- 								<td> -->
<%-- 									<fmt:formatDate value="${winner.winner_date}" pattern="yy-MM-dd"/> --%>
<!-- 								</td> -->
<%-- 								<td>${winner.winner_readcount}</td> --%>
<!-- 							</tr> -->
<%-- 						</c:forEach> --%>
<%-- 					</c:otherwise>					 --%>
<%-- 				</c:choose> --%>
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
		$(".winner_subject").on("click", function(event) {
			console.log(event.target);
			let board_num = $(event.target).siblings(".winner_num").text();
			console.log("siblings " + winner_num);
			location.href = "WinnerDetail?board_num=" + Winner_num + "&pageNum=${pageInfo.pageNum}";
		
		});
	</script>


	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>