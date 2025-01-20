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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movie_info/upcoming_movie_info.css" />
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/movie_info_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<div id="upcoming_movie_info">
			<div id="page_top">
				<div id="title">
					상영예정작
				</div>
<!-- 				<div id="select_search"> -->
<!-- 					<select> -->
<!-- 						<option>제목순</option> -->
<!-- 						<option>별점순</option> -->
<!-- 						<option>예매율순</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
			</div>
			<c:choose>
				<c:when test="${totalCount eq 0}">
					<img src="${pageContext.request.contextPath}/resources/images/coming_soon.jpg">
				</c:when>
				<c:otherwise>
					<jsp:include page="/WEB-INF/views/inc/page/movie_info/currently_upcoming_movieList.jsp"></jsp:include>
				</c:otherwise>
			</c:choose>
		</div>
	</article>
	
	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	<script type="text/javascript">
		$(function() {
			$("#bookingBtn").prop("disabled", true);
			
			setTimeout(function() {
				if(${seasonMovieCount < 3}) {
					if(confirm("시즌 상영예정작 투표중입니다\n투표하러 가시겠습니까?")) {
						location.href = "MoivePick";
					}
				}
			}, 1000);
		});
	</script>
</body>
</html>