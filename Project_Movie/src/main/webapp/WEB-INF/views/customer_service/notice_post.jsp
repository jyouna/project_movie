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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/customer_service/notice_post.css" />
		<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/customer_service_sidebar.jsp"></jsp:include>
	
	<article id="articleForm">
		<h1>공지사항 - 글</h1>
		<section id="basicInfoArea">
			<table>
				<tr>
					<th width="120px">제목 </th>
					<td>${notice.notice_subject}</td>
				</tr>
				<tr>
					<th width="120px">등록일</th>
					<td>
						<fmt:formatDate value="${notice.regis_date}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
				<tr>
					<th width="120px">첨부파일</th>
					<td colspan="3" id="notice_file"></td>
				</tr>
			</table>
		</section>
		<section id="articleContentArea">
			${notice.notice_content}
		</section>
		<hr>
		<div style="text-align: right;" >
		<input type="button" value="목록" id="listButton" onclick="location.href='NoticeList?pageNum=${param.pageNum}'">
		</div>
<!-- 		다음글이 없을 경우 if문 사용해서 해당 글이 존재하지 x 라고 표시 -->
		<table id="buttonTable">
			<tr>
				<td>
					<input type="button" value="△이전글" id="tableButton" onclick="location.href='NoticePost?notice_code=${param.notice_code-1}&pageNum=${param.pageNum}'"
					<c:if test="${param.notice_code-1 eq 0}">alert("해당 게시글이 존재하지 않습니다.")</c:if>>
				</td>
<!-- 				이전글 제목 가져오기 -->
				<td>${param.notice_code-1}</td>
			</tr>
			<tr>
				<td>
					<input type="button" value="▽다음글" id="tableButton" onclick="location.href='NoticePost?notice_code=${param.notice_code+1}&pageNum=${param.pageNum}'"
					<c:if test="${param.inquiry_code-1 eq null}">alert("해당 게시글이 존재하지 않습니다.")</c:if>>
				</td>
				<td><a href="onclick=location.href='NoticePost?notice_code=${param.notice_code+1}&pageNum=${param.pageNum}'">${notice.notice_subject}</a></td>
			</tr>
		</table>		

	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>