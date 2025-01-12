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
			<div id="title">상영예정작 관리</div>
			<div id="btnGroup01">
				<input type="button" id="set_date_btn" value="상영기간설정/변경">
				<input type="button" id="to_schedule_regist" value="상영스케줄설정">
				<input type="button" id="to_currently_movie" value="현재상영작으로등록">
				<input type="button" id="remove_from_upcoming_btn" value="상영예정작에서 삭제">
			</div>
			<div id="btnGroup02">
				<input type="button" value="영화정보">
			</div>
		</div>
		<div id="body_main">
			<div id="season_movie_list">
				<table>
					<tr>
						<th style="width:30px"><input type="radio" disabled="disabled"></th>
						<th style="width:80px">영화코드</th>
						<th style="width:250px">영화제목</th>
						<th style="width:242px">상영예정기간</th>
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
						</c:when>
						<c:otherwise>
							<tr><th colspan="7">시즌 상영예정작이 존재하지 않습니다</th></tr>
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
						<th style="width:242px">상영예정기간</th>
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
									<c:choose>
										<c:when test="${(empty movieList[i].start_screening_date or empty movieList[i].end_screening_date)
											and not empty movieList[i]}">
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
						</c:when>
						<c:otherwise>
							<tr><th colspan="7">일반 상영예정작이 존재하지 않습니다</th></tr>
						</c:otherwise>
					</c:choose>
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
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/movie_set/movie_info_modal.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>