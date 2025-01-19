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
	<title>관리자페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/mypage/inquiry/inquiry_list.css" rel="stylesheet"/>
		<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<article id="articleForm">
			<h1>1:1문의 - 글 </h1>
			<section id="basicInfoArea">
			<form action="AdmininquiryModify" method="post">
			<input type="hidden" name = "inquiry_code" value="${inquiry.inquiry_code }">
			<input type="hidden" name = "pageNum" value="${param.pageNum }">
				<table>
					<tr>
						<th width="100">제목</th>
						<td colspan="3"><input type="text" value="${inquiry.inquiry_subject}"></td>
						<th width="120">등록일</th>
						<td width="180">
							<fmt:formatDate value="${inquiry.inquiry_date}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
				</table>
				<textarea rows="15" cols="40">	${inquiry.inquiry_content}</textarea>
				<hr>
				<div style="text-align: right;" >
					<input type="submit" value="등록">
				</div>
			</form>
		</section>
	</article>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>