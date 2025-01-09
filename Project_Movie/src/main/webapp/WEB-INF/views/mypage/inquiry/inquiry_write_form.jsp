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
	<title>마이페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage_styles.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/inquiry/inquiry_write_form.css" />
	</head>
	<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
		<div id="title">
			<h1>게시판 글 등록</h1>
		</div>
		<article id="writeForm">
			<form action="BoardWrite" name="writeForm" method="post">
				<table>
					<tr>
						<td class="write_td_left"><label for="board_name">글쓴이</label></td>
						<td class="write_td_right"><input type="text" name="board_name" value="${sessionScope.sId }" readonly/></td>
					</tr>
					<tr>
						<td class="write_td_left"><label for="board_subject">제목</label></td>
						<td class="write_td_right"><input type="text" id="board_subject" name="board_subject" required="required" /></td>
					</tr>
					<tr>
						<td class="write_td_left"><label for="board_content">내용</label></td>
						<td class="write_td_right">
							<textarea id="board_content" name="board_content" rows="15" cols="40" required="required"></textarea>
						</td>
					</tr>
				</table>
				<section id="commandCell">
					<input type="submit" value="등록">&nbsp;&nbsp;
					<input type="reset" value="다시쓰기">&nbsp;&nbsp;
					<input type="button" value="취소" onclick="history.back()">
				</section>
			</form>
		</article>
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>