<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/inquery/inquery_list.css" />
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/event_sidebar.jsp"></jsp:include>
	
	<article>
		<h1>전체 이벤트</h1>
	    <div class="search-bar">
	      <select >
	        <option>제목▼</option>
	        <option>내용</option>
	      </select>
	      <input type="text">
	      <button >검색</button>
	    </div>
		<section id="listForm">
			<table>
				<tr id="tr_top">
					<td width="50px">상태</td>
					<td width="150px" >제목</td>
					<td width="100px">당첨자 발표일</td>
				</tr>
					
				<c:choose>
					<c:when test="${empty eventList}"> 
						<tr><td colspan="5">게시물이 존재하지 않습니다</td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="event" items="${eventList}" varStatus="status">
							<tr>
								<td class="event_num">${event.event_num}</td>
								<td class="event_subject">${event.event_subject}</td>
								<td>${event.event_name}</td>
								<td>
									<fmt:formatDate value="${event.event_date}" pattern="yy-MM-dd - yy-MM-dd"/>
								</td>
								<td>${event.event_readcount}</td>
							</tr>
						</c:forEach>
					</c:otherwise>					
				</c:choose>
			</table>
		</section>
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
	</article>
</body>
</html>