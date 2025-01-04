<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inquery/inquery_post.css" />
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
		<article id="articleForm">
		<h1>1:1문의 - 글 </h1>
		<section id="basicInfoArea">
			<table>
				<tr>
					<th width="40">제목</th>
					<td>${event.event_subject}</td>
				</tr>
				<tr>
					<th width="40">등록일</th>
					<td>
						<fmt:formatDate value="${event.event_date}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>	
			</table>
			<table>
				<h6>여기는 글쓰는 자리</h6>
				<tr>
					<th width="40">첨부파일</th>
					<td id="board_file"></td>
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
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>