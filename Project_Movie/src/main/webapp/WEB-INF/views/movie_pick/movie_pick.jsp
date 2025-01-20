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
		<div id="movie_pick">
			<div id="page_top">
				영화투표하기
			</div>
			<div id="pick_event_info">
				<img src="${pageContext.request.contextPath}/resources/images/familyMonth.webp">
			</div>
			<div id="pick_movie_list">
				<div id="pick_list_title">
					2025 SPRING SEASON 영화 투표
				</div>
				<div id="row01">
					<c:forEach var="i" begin="0" end="2">
						<div class="movie">
							<label>${movieList[i].movie_name}(${movieList[i].movie_rating})</label><br>
							<a href=""><img src="${movieList[i].movie_img1}"></a><br>
							<input type="button" value="자세히보기" onclick="location.href='MovieInfoDetail?movie_code=${movieList[i].movie_code}'">
							<input type="button" value="투표하기">
							<div class="movie_info">
					            &lt;${movieList[i].movie_name}&gt;
					            <ul>
						            <li>감독: ${movieList[i].movie_director}</li>
						            <li>출연:<br> ${movieList[i].movie_actor}</li>
						            <li>등급: ${movieList[i].age_limit}</li>
						            <li>장르: ${movieList[i].movie_genre}</li>
						            <li>개봉일: ${movieList[i].release_date}</li>
						            <li>러닝 타임: ${movieList[i].running_time}</li>
						            <li>예매가: 10,000원</li>
					            </ul>
					        </div>
						</div>
					</c:forEach>
				</div>
				<div id="row02">
					<c:forEach var="i" begin="3" end="4">
						<div class="movie">
							<label>${movieList[i].movie_name}(${movieList[i].movie_rating})</label><br>
							<a href=""><img src="${movieList[i].movie_img1}"></a><br>
							<input type="button" value="자세히보기" onclick="location.href='MovieInfoDetail?movie_code=${movieList[i].movie_code}'">
							<input type="button" value="투표하기">
							<div class="movie_info">
					            <ul>
			            			<li>영화 제목: ${movieList[i].movie_name}</li>
						            <li>감독: ${movieList[i].movie_director}</li>
						            <li>출연: ${movieList[i].movie_actor}</li>
						            <li>등급: ${movieList[i].age_limit}</li>
						            <li>장르: ${movieList[i].movie_genre}</li>
						            <li>개봉일: ${movieList[i].release_date}</li>
						            <li>러닝 타임: ${movieList[i].running_time}</li>
						            <li>예매가: 13,000원</li>
					            </ul>
					        </div>
						</div>
					</c:forEach>
					<div class="movie">
						<canvas id="voteCurrentChart" width="450px"></canvas>
					</div>
				</div>
			</div>
			<div id="pick_notice">
				<div>투표 주의사항</div>
				시즌 영화 투표 리스트 출력, 5개의 후보중 3개의 영화 선정예정, 회원 당 한시즌
				1투표 가능 한시즌 - 3개월, 이번 시즌 1~2번째 달 투표 후 다음시즌에 영화 상영 예정 투표 기간 - 투표 리스트 출력
				투표 기간 끝 시즌 영화 선정완료 - 선정된 영화 리스트 출력 투표 기간일때 투표 유도를 위해 추첨이벤트 및 포인트 추가
				적립 내용 고지 로그인 후 투표 가능
			</div>
		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>