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
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/movie_set/upcoming_movie_set.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<section>
		<div id="body_top">
			<div id="title">상영예정작 관리</div>
			<div id="btnGroup01">
				<input type="button" id="set_date_btn" value="상영기간설정">
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
						<th><input type="radio" disabled="disabled"></th>
						<th>영화코드</th>
						<th>영화제목</th>
						<th>상영예정기간</th>
						<th>상영시간</th>
						<th>관람연령</th>
						<th>영화분류</th>
					</tr>
					<c:forEach var="i" begin="0" end="2">
						<tr>
							<th><input type="radio" name="movie_radio"></th>
							<td>${movieList[i].movie_code}</td>
							<td>${movieList[i].movie_name}</td>
							<c:choose>
								<c:when test="${empty movieList[i].start_screening_date or empty movieList[i].end_screening_date}">
									<td>상영예정기간을 입력해주세요.</td>
								</c:when>
								<c:otherwise>
									<td>${movieList[i].start_screening_date} ~ ${movieList[i].end_screening_date}</td>
								</c:otherwise>
							</c:choose>
							<td>${movieList[i].running_time}</td>
							<td>${movieList[i].age_limit}</td>
							<td>${movieList[i].movie_type}</td>
						<tr>
					</c:forEach>
				</table>
			</div>
			<div id="movie_list">
				<table>
					<tr>
						<th><input type="radio" disabled="disabled"></th>
						<th>영화코드</th>
						<th>영화제목</th>
						<th>상영예정기간</th>
						<th>상영시간</th>
						<th>관람연령</th>
						<th>영화분류</th>
					</tr>
					<c:forEach var="i" begin="3" end="8">
						<tr>
							<th><input type="radio" name="movie_radio"></th>
							<td>${movieList[i].movie_code}</td>
							<td>${movieList[i].movie_name}</td>
							<c:choose>
								<c:when test="${empty movieList[i].start_screening_date or empty movieList[i].end_screening_date}">
									<td>상영예정기간을 입력해주세요.</td>
								</c:when>
								<c:otherwise>
									<td>${movieList[i].start_screening_date} ~ ${movieList[i].end_screening_date}</td>
								</c:otherwise>
							</c:choose>
							<td>${movieList[i].running_time}</td>
							<td>${movieList[i].age_limit}</td>
							<td>${movieList[i].movie_type}</td>
						<tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div id="screening_date_modal" class="modal">
		   <div class="modal_content">
	       	   <h4>상영 예정기간을 설정해주세요</h4>
		       <hr>
		       <div>
		       	   <input type="date" class="start_date">
		       	   ~ <input type="date" class="end_date">
		       </div>
		       <div class="btnGroup">
		           <input type="button" id="set_btn" value="입력">
		           <input type="button" class="close_modal" value="닫기">
		       </div>
		   </div>
	   </div>
	</section>
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>