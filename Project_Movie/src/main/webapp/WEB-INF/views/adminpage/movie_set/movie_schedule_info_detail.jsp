<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/movie_set/movie_schedule_info_detail.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/movie_set/movie_schedule_info_detail.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<section>
		<div id="body_top">
			<div id="title">스케줄 상세페이지</div>
			<div id="btnGroup01">
				<input type="date" placeholder="날짜선택">
				<input type="button" id="regist_schedule_btn" value="스케줄등록">
				<input type="button" value="스케줄변경">
				<input type="button" value="스케줄삭제">
			</div>
			<div id="btnGroup02">
				<input type="button" value="영화정보">
			</div>
		</div>
		<div id="body_main">
		</div>
		<div id="schedule_regist_modal" class="modal">
			<div class="modal_content">
				<form>
					<h2>스케줄 등록</h2>
					<hr>
					   <label>영화선택</label>
					<select name="selected_movie">
						<option value="" selected="selected">선택</option>
					</select>
					<br>
				    <label>영화코드</label>
				    <input type="text" name="movie_code" readonly="readonly"><br>
				    <label>영화명</label>
				    <input type="text" name="movie_name" readonly="readonly"><br>
				    <label>러닝타임</label>
				    <input type="text" name="running_time" readonly="readonly"><br>
				    <label>상영관선택</label>
				    <select name="theater_code">
						<option value="" selected="selected">선택</option>
						<option value="T1">1관</option>
						<option value="T2">2관</option>
						<option value="T3">3관</option>
					</select>	
				    <br>
				    <label>상영날짜</label>
				    <input type="date" name="str_schedule_date"><br>
				    <label>상영시작시간</label>
				    <input type="time" name="str_start_time"><br>
				    <label>상영종료시간</label>
				    <input type="time" name="str_end_time" readonly="readonly"><br>
				    <label>청소 및 준비시간</label>
				    <input type="text" value="30분" readonly="readonly"><br>
				    <label>상영시간대</label>
				    <select name="showtime_type">
				        <option value="" selected="selected" >선택</option>
				        <option value="조조" >조조</option>
				        <option value="일반" >일반</option>
				        <option value="심야" >심야</option>
				    </select><br>
				    <label>예매가능여부</label>
				    <select name="booking_avail">
				        <option value="0" selected="selected">예매불가</option>
				        <option value="1">예매가능</option>
				    </select><br>
				    <div class="form_btnGroup">
				    	<input type="submit" value="등록">
				    	<input type="reset" value="초기화">
				    	<input type="button" class="close_modal" value="닫기">
				    </div>
				    <div>
				    </div>
				</form>
			</div>
		</div>
	</section>
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>