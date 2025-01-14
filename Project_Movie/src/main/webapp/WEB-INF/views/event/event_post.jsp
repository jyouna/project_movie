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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/event/event_post.css" />
		<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/event_sidebar.jsp"></jsp:include>
		<article id="articleForm">
		<h1>이벤트 - 글</h1>
		<section id="basicInfoArea">
			<table>
				<tr>
					<th width="90px">제목</th>
					<td width="220px">${event.event_subject}</td>
					<th width="90px">등록일</th>
					<td width="160px">
						<fmt:formatDate value="${event.event_start_date}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
					<tr>
					<th width="90px">첨부파일</th>
					<td colspan="3">${event.event_file1}</td>
				</tr>
			</table>
		</section>
		<section id="articleContentArea">
			${event.event_content}
		</section>
		<input type="button" value="목록" id="listButton" style="float: right;" onclick="location.href='EventList?pageNum=${param.pageNum}'">
		<hr>
		<table id="postList">
			<tr>
				<th><input type="button" value="△이전글" id="tableButton" onclick="location.href='EventPost?event_code=${event.event_code-1}&pageNum=${PageInfo.pageNum }'"></th>
				<th>이거는 이전 글 </th>
			</tr>
			<tr>
				<th><input type="button" value="▽다음글" id="tableButton" onclick="location.href='EventPost?event_code=${event.event_code+1}&pageNum=${PageInfo.pageNum }'"></th>
				<th>여기는 다음글</th>
			</tr>
		</table>

	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>