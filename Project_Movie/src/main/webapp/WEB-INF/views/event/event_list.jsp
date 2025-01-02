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
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/event_sidebar.jsp"></jsp:include>
	
		<h1>전체 이벤트</h1>
	    <div class="search-bar">
	      <select>
	        <option>제목▼</option>
	        <option>내용</option>
	      </select>
	      <input type="text">
	      <button style="width: 100px; height: 50px;" >검색</button>
	    </div>
		<div id="listForm">
			<table id="eventForm" border="1">
				<tr id="tr_top" align="center">
					<td width="75px">상태</td>
					<td width="150px" >제목</td>
					<td width="125px">이벤트 기간</td>
				</tr>
				<tr>
					<td>진행중</td>
					<td>수험생 관람료 할인</td>
					<td>2024.11.14 - 2024.12.31</td>
				</tr>
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${empty eventList}">  --%>
<!-- 						<tr><td colspan="5">게시물이 존재하지 않습니다</td></tr> -->
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<%-- 						<c:forEach var="event" items="${eventList}" varStatus="status"> --%>
<!-- 							<tr> -->
<%-- 								<td class="event_num">${event.event_num}</td> --%>
<%-- 								<td class="event_subject">${event.event_subject}</td> --%>
<%-- 								<td>${event.event_name}</td> --%>
<!-- 								<td> -->
<%-- 									<fmt:formatDate value="${event.event_date}" pattern="yy-MM-dd - yy-MM-dd"/> --%>
<!-- 								</td> -->
<%-- 								<td>${event.event_readcount}</td> --%>
<!-- 							</tr> -->
<%-- 						</c:forEach> --%>
<%-- 					</c:otherwise>					 --%>
<%-- 				</c:choose> --%>
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
	
	<script type="text/javascript">
		$(".event_subject").on("click", function(event) {
			console.log(event.target);
			let event_num = $(event.target).siblings(".event_num").text();
			console.log("siblings " + event_num);
			location.href = "EventDetail?event_num=" + event_num + "&pageNum=${pageInfo.pageNum}";
		
		});
	</script>


	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>