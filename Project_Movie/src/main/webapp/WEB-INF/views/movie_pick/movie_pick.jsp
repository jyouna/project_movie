<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<!--
	Escape Velocity by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movie_pick/movie_pick.css"/>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/movie_pick/movie_pick.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/movie_pick_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<input type="hidden" id="loginId" value="${sessionScope.sMemberId}">
		<input type="hidden" id="voteCode" value="${voteInfo.vote_code}">
		<div id="movie_pick">
			<div id="page_top">
				영화투표하기
			</div>
			<div id="pick_event_info">
				<img src="${pageContext.request.contextPath}/resources/images/familyMonth.webp">
			</div>
			<div id="pick_movie_list">
				<input type="hidden" id="voteStatus" value="${voteInfo.vote_status}">
				<div id="pick_list_title">
					&lt;&nbsp;${voteInfo.vote_name}&nbsp;&gt;
				</div>
				<c:forEach var="movie" items="${pickMovieList}">
					<div class="movie">
						<input type="hidden" value="${movie.movie_code}">
						<label>${movie.movie_name}</label>(${movie.movie_rating})<br>
						<img src="${movie.movie_img1}"><br>
						<input type="button" value="자세히보기" onclick="location.href='MovieInfoDetail?movie_code=${movie.movie_code}'">
						<input type="button" class="joinVoteBtn" value="투표하기">
						<div class="movie_info">
				            &lt;${movie.movie_name}&gt;
				            <ul>
					            <li>감독: ${movie.movie_director}</li>
					            <li>출연:<br> ${movie.movie_actor}</li>
					            <li>등급: ${movie.age_limit}</li>
					            <li>장르: ${movie.movie_genre}</li>
					            <li>개봉일: ${movie.release_date}</li>
					            <li>러닝 타임: ${movie.running_time}</li>
					            <li>예매가: ${generalPrice}원</li>
				            </ul>
				        </div>
					</div>
				</c:forEach>
				<div class="movie">
					<canvas id="voteCurrentChart" width="450px"></canvas>
				</div>
			</div>
			<div id="pick_notice">
				<div>시즌 영화 투표 안내</div>
				매 시즌마다 5개의 영화 후보 중 3개의 영화를 선정하여 다음 시즌에 상영합니다.<br>
				회원 당 한 시즌에 1번의 투표 기회가 주어지며, 시즌은 3개월 단위로 진행됩니다.<br><br>
				투표 기간 : 매 시즌의 시작일 ~ 3번째달의 15일까지 75일간 진행<br>
				투표 결과 : 투표 종료일 후 투표결과보기 페이지에서  선정된 영화 리스트 발표<br>
				투표 참여 방법 : 회원으로 로그인 후 투표 가능, 투표 기간 동안 투표 리스트 확인 및 영화 선택 <br>
				투표 시 1000포인트 증정 이벤트<br>
				추가 혜택 : 투표에 참여하시면 추첨 이벤트에도 자동으로 응모되며, 추가 포인트 적립 혜택이 주어집니다.<br>
				지금 바로 로그인하여 좋아하는 영화를 선택하고, 푸짐한 혜택을 누리세요!
			</div>
		</div>
	</article>
	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
</body>
</html>