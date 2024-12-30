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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movie_pick/movie_pick_result.css"/>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/movie_pick_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<div id="movie_pick_result">
			<div id="page_top">
				PICK 결과보기
			</div>
			<div id="pick_movie_list">
				<div id="pick_list_title">
					2024 WINTER SEASON 영화 투표 결과
				</div>
				<div id="row01">
					<div class="movie" id="second">
						<label>바람(30%)</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster1.webp"></a><br>
						<input type="button" value="자세히보기" onclick="location.href='MovieInfoDetail'">
						<div class="pick_grade">
							<img src="${pageContext.request.contextPath}/resources/images/silvermedal.png">
				        </div>
					</div>
					<div class="movie" id="first">
						<label>바람(40%)</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster1.webp"></a><br>
						<input type="button" value="자세히보기" onclick="location.href='MovieInfoDetail'">
						<div class="pick_grade">
							<img src="${pageContext.request.contextPath}/resources/images/goldmedal.png">
				        </div>
					</div>
					<div class="movie" id="third">
						<label>바람(20%)</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster1.webp"></a><br>
						<input type="button" value="자세히보기" onclick="location.href='MovieInfoDetail'">
						<div class="pick_grade">
							<img src="${pageContext.request.contextPath}/resources/images/bronzemedal.png">
				        </div>
					</div>
				</div>
				<div id="row02">
					<div class="movie">
						<label>바람(7%)</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster1.webp"></a><br>
						<input type="button" value="자세히보기" onclick="location.href='MovieInfoDetail'">
					</div>
					<div class="movie">
						<label>바람(3%)</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster1.webp"></a><br>
						<input type="button" value="자세히보기" onclick="location.href='MovieInfoDetail'">
					</div>
				</div>
			</div>
			<div id="pick_notice">
				<div>안내사항</div>
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