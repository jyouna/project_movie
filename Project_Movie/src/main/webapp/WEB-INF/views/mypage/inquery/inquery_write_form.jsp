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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/inquery/inquery_write_form.css" />
	</head>
	<body class="left-sidebar is-preload">
	
		<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
		<jsp:include page="/WEB-INF/views/inc/page/event_sidebar.jsp"></jsp:include>
			<h1>게시판 글 등록</h1>
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
	
		<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
		
	</body>
	</html>