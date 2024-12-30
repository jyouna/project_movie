<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		        <div class="poster" id="poster1" onclick="location.href=''">
		            <img src="${pageContext.request.contextPath}/resources/images/poster6.png">
		        </div>
		        <div class="poster" id="poster2" onclick="location.href=''">
		            <img src="${pageContext.request.contextPath}/resources/images/poster4.png">
		        </div>
		        <div class="poster" id="poster3" onclick="location.href=''">
		            <img src="${pageContext.request.contextPath}/resources/images/poster5.png">
		        </div>
		    </div>
		
		    <div id="season_info">
		        <div>
		        	시즌 컨셉 및 시즌 이벤트 간략 소개
		        </div>
		        ㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱ
		        fffffffffffffffffffffffffffffffffffffffffff
		        ffffffffffffffffffffffffffffffffffffffffff
		    </div>
		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>