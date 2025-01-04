<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/customer_service/faq_post.css" />
		<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/customer_service_sidebar.jsp"></jsp:include>
	
	<article id="articleForm">
		<h1>FAQ - 글</h1>
		<section id="basicInfoArea">
			<table>
				<tr>
					<th>제목</th>
					<td colspan="3">${board.board_subject}</td>
				</tr>
				<tr>
					<th>등록일</th>
					<td>
						<fmt:formatDate value="${board.board_date}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
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
				<input type="button" value="수정" id="Modify" >
				<input type="button" value="삭제" id="Delete">
			</c:if>
			<%-- 목록 버튼 항상 표시 --%>
			<input type="button" value="목록" onclick="location.href='BoardList?pageNum=${param.pageNum}'">
			<input type="button" value="△이전글" onclick="">
			<input type="button" value="▽다음글" onclick="">
		</section>
	</article>
	<script type="text/javascript">
		$(function() {
			$("#Modify").on("click", function () {
				confirm("수정하시겠습니까?")
			});
			
			$("#Delete").on("click", function () {
				confirm("삭제하시겠습니까?")
			});
		});
	
	
	</script>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>