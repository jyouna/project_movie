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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/movie_set/upcoming_currently_movie_set.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/movie_set/upcoming_currently_movie_set.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<section>
		<div id="body_top">
			<div id="title">현재상영작 관리</div>
			<div id="btnGroup01">
				<input type="button" value="스케줄관리하러가기" onclick="location.href='AdminMovieSetSchedule'">
				<input type="button" id="to_past_movie" value="지난상영작으로등록">
			</div>
			<div id="btnGroup02">
				<input type="button" value="영화정보">
			</div>
		</div>
		<div id="body_main">
			<div id="currently_movie_list">
				<table>
					<tr>
						<th style="width:30px"><input type="radio" disabled="disabled"></th>
						<th style="width:80px">영화코드</th>
						<th style="width:250px">영화제목</th>
						<th style="width:242px">상영기간</th>
						<th style="width:100px">상영시간</th>
						<th style="width:180px">관람연령</th>
						<th style="width:80px">영화분류</th>
					</tr>
					<c:choose>
						<c:when test="${seasonMovieCount != 0}">
							<c:forEach var="i" begin="0" end="${seasonMovieCount - 1}">
								<tr>
									<th><input type="radio" name="movie_radio"></th>
									<td>${movieList[i].movie_code}</td>
									<td>${movieList[i].movie_name}</td>
									<td>${movieList[i].start_screening_date} ~ ${movieList[i].end_screening_date}</td>
									<td>${movieList[i].running_time}</td>
									<td>${movieList[i].age_limit}</td>
									<td>${movieList[i].movie_type}</td>
								<tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><th colspan="7">시즌 현재상영작이 존재하지 않습니다</th></tr>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			<div id="movie_list">
				<table>
					<tr>
						<th style="width:30px"><input type="radio" disabled="disabled"></th>
						<th style="width:80px">영화코드</th>
						<th style="width:250px">영화제목</th>
						<th style="width:242px">상영기간</th>
						<th style="width:100px">상영시간</th>
						<th style="width:180px">관람연령</th>
						<th style="width:80px">영화분류</th>
					</tr>
					<c:choose>
						<c:when test="${generalMovieCount != 0}">
							<c:forEach var="i" begin="${seasonMovieCount}" end="${seasonMovieCount + generalMovieCount - 1}">
								<tr>
									<th><input type="radio" name="movie_radio"></th>
									<td>${movieList[i].movie_code}</td>
									<td>${movieList[i].movie_name}</td>
									<td>${movieList[i].start_screening_date} ~ ${movieList[i].end_screening_date}</td>
									<td>${movieList[i].running_time}</td>
									<td>${movieList[i].age_limit}</td>
									<td>${movieList[i].movie_type}</td>
								<tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><th colspan="7">일반 현재상영작이 존재하지 않습니다</th></tr>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
		</div>
	</section>
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/movie_set/movie_info_modal.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>