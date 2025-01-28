<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movie_info/season_movie_info.css">
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/movie_info_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<div class="season_movie">
		    <div id="title">
		        <img src="${pageContext.request.contextPath}/resources/images/merry-christmas.png" alt="Merry Christmas">
		    </div>
		
		    <div class="movie_poster">
		    	<c:forEach var="movie" items="${movieList}" varStatus="status">
			        <div class="poster" id="poster${status.count}" onclick="location.href='MovieInfoDetail?movie_code=${movie.movie_code}'">
			            <img src="${movie.movie_img1}">
			        </div>
		    	</c:forEach>
		    </div>
		
		    <div id="season_info">
		        이번 겨울 시즌,<br>
				영화와 함께 겨울의 분위기를 만끽할 수 있는 특별한 상영관을 준비했습니다.<br>
				지금 바로 저희 영화관을 방문하셔서 사랑하는 가족들과 즐거운 시간을 보내세요.<br>
				따뜻한 영화와 함께하는 특별한 겨울을 놓치지 마세요!
		    </div>
		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>