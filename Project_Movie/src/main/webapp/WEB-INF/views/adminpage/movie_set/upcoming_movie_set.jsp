<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/movie_set/upcoming_movie_set.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<section>
		<div id="body_top">
			<div id="title">상영예정작 관리</div>
			<div id="btnGroup01">
				<input type="button" value="등록하기">
				<input type="button" value="상영스케줄설정">
				<input type="button" value="현재상영작으로등록">
				<input type="button" value="변경하기">
				<input type="button" value="삭제하기">
			</div>
			<div id="btnGroup02">
				<input type="button" value="영화정보">
			</div>
		</div>
		<div id="body_main">
			<div id="season_movie_list">
				<table>
					<tr>
						<th><input type="checkbox" class="seasonCheck"></th>
						<th>영화코드</th>
						<th>영화제목</th>
						<th>상영예정기간</th>
						<th>상영시간</th>
						<th>관람연령</th>
						<th>영화분류</th>
						<th>등록계정</th>
					</tr>
					<c:forEach var="i" begin="0" end="2">
						<tr>
							<th><input type="checkbox" class="seasonCheck"></th>
							<td>${movieList[i].movie_code}</td>
							<td>${movieList[i].movie_name}</td>
							<td></td>
							<td>${movieList[i].running_time}</td>
							<td>${movieList[i].age_limit}</td>
							<td>${movieList[i].movie_type}</td>
							<td>${movieList[i].regist_admin_id}</td>
						<tr>
					</c:forEach>
				</table>
			</div>
			<div id="movie_list">
				<table>
					<tr>
						<th><input type="checkbox" class="check"></th>
						<th>영화코드</th>
						<th>영화제목</th>
						<th>상영예정기간</th>
						<th>상영시간</th>
						<th>관람연령</th>
						<th>영화분류</th>
						<th>등록계정</th>
					</tr>
					<c:forEach var="i" begin="3" end="8">
						<tr>
							<th><input type="checkbox" class="seasonCheck"></th>
							<td>${movieList[i].movie_code}</td>
							<td>${movieList[i].movie_name}</td>
							<td></td>
							<td>${movieList[i].running_time}</td>
							<td>${movieList[i].age_limit}</td>
							<td>${movieList[i].movie_type}</td>
							<td>${movieList[i].regist_admin_id}</td>
						<tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</section>
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>