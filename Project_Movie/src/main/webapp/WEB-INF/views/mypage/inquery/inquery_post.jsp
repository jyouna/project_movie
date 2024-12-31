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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inquery/inquery_post.css" />
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/event_sidebar.jsp"></jsp:include>
		<article id="articleForm">
		<h1>1:1문의 - 글 </h1>
		<section id="basicInfoArea">
			<table>
				<tr>
					<th>제목</th>
					<td colspan="3">${event.event_subject}</td>
				</tr>
				<tr>
					<th>등록일</th>
					<td>
						<fmt:formatDate value="${event.event_date}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>	
			</table>
			<table>
				<h6>여기는 글쓰는 자리</h6>
				<tr>
					<th>첨부파일</th>
					<td colspan="3" id="board_file"></td>
				</tr>
			</table>
		</section>
		<section id="articleContentArea">
			${board.board_content}
		</section>
		<section id="commandCell">
				<c:if test="${sessionScope.sId eq board.board_name || sessionScope.sId eq 'admin' }">
					<input type="button" value="수정" >
					<input type="button" value="삭제" onclick="confirmDelete()">
				</c:if>
		</section>
		<section id="commandCell">
			<input type="button" value="△이전글" onclick="">
			<input type="text"> 
			<input type="button" value="목록" onclick="location.href='EventList?pageNum=${param.pageNum}'">
		</section>
		<section id="commandCell">
			<input type="button" value="▽다음글" onclick="">
		</section>
	</article>
	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>