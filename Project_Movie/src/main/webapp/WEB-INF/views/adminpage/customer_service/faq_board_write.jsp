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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/customer_service/faq_post.css" />
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<article id="articleForm">
		<h4>FAQ - 글 작성</h4><br>
		<form action="AdminFaqWrite" method="post">
			<section id="basicInfoArea">
				<table>
					<tr>
						<th width="13.46%">제목</th>
						<td width="34.46%"><input type="text" name="faq_subject"></td>
					</tr>
				</table>
			</section>
			<section id="articleContentArea">
				<textarea rows="15" cols="70" name="faq_content"></textarea>
			</section>
			<div style="text-align: center;">
				<input type="submit" value="등록하기" style="text-align: right;">
				<input type="reset" value="다시쓰기">
				<input type="button" value="뒤로가기" onclick="location.href='AdminFaq'">
			</div>
		</form>
		<hr>
	</article>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>