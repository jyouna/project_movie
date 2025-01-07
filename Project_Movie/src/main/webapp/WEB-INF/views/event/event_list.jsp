<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>event page</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/event/event_list.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/event_sidebar.jsp"></jsp:include>
		<div id="title">
			<h1>전체 이벤트</h1>
		</div>
	    <div class="search-bar">
	      <select>
	        <option>제목</option>
	        <option>내용</option>
	      </select>
	      <input type="text" placeholder="검색어를 입력하세요.">
  		  <input type="button" value="검색" id="searchButton">
	    </div>
		<div id="listForm">
			<table id="eventForm" border="1">
				<tr id="tr_top" align="center">
					<td width="75px">상태</td>
					<td width="150px" >제목</td>
					<td width="125px">이벤트 기간</td>
					<td width="45px">조회수</td>
				</tr>
				<c:choose>
					<c:when test="${empty eventList}"> 
						<tr><td colspan="4">게시물이 존재하지 않습니다</td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="event_board" items="${eventList}" varStatus="status">
							<tr>
								<td class="event_code">${event_board.event_code}</td>
								<td class="event_subject">${event_board.event_subject}</td>
								<td>
									<p>${event_board.event_start_date} - ${event_board.event_end_date}</p>
<%-- 									<fmt:formatDate value="${event_board.event_start_date} " pattern="yy-MM-dd "/> --%>
<%-- 									- ${event_board.event_end_date}- yy-MM-dd --%>
								</td>
								<td>${event_board.view_count}</td>
							</tr>
						</c:forEach>
					</c:otherwise>					
				</c:choose>
			</table>
		</div>
		
		<section id="pageList">
			<input type="button" value="&lt" 
				onclick="location.href='EventList?pageNum=${pageInfo.pageNum - 1}'" 
				 <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
			
			<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
				<c:choose>
					<c:when test="${i eq pageInfo.pageNum }">
						<strong>${i}</strong>
					
					</c:when>
					<c:otherwise>
						<a href="EventList?pageNum=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			
			<input type="button" value="&gt" 
				onclick="location.href='EventList?pageNum=${pageInfo.pageNum + 1}'" 
				 <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		</section>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>