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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movie_info/movie_info_detail.css" />
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/movie_info_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<div id="movie_info_detail">
			<div id="page_top">
				${movie.movie_status}
			</div>
			<div>
				<div id="movie_poster">
					<img src="${movie.movie_img1}"><br>
					<input type="button" value="예매하기">
				</div>
				<div id="movie_info">
					<b>${movie.movie_name}</b>
					<p id="p01">
						★(${movie.movie_rating}) <br>
						${movie.release_date} | ${movie.running_time} | ${movie.age_limit}
					</p>
					<p id="p02">
					    감독 : ${movie.movie_director}<br>
						출연 : ${movie.movie_actor}<br>
						장르 : ${movie.movie_genre}
					</p>
					줄거리
					<div id="movie_summary">
						${movie.movie_synopsis}
					</div>
				</div>
			</div>
			<div id="movie_trailer">
				메인예고편
				<div>
					<iframe id="video" width="850" height="500" src="${movie.movie_trailer}"></iframe>
				</div>
			</div>
			<div id="movie_stillcut">
				Still Cut
				<div>
					<img src="${movie.movie_img1}">
					<div class="stillcut">
						<img src="${movie.movie_img2}">
						<img src="${movie.movie_img3}"><br>
						<img src="${movie.movie_img4}">
						<img src="${movie.movie_img5}">
					</div>
				</div>
			</div>
			<div id="movie_review">
				<div id="review_title">관람평</div>
				<div>
					<table>
						<tr>
							<th>ID</th>
							<th>영화명</th>
							<th>한줄평</th>
							<th>추천/비추천</th>
							<th>작성일자</th>
						</tr>
						<c:forEach var="i" begin="1" end="10">
							<tr>
								<td>asdfqer</td>
								<td>소방관</td>
								<td>다시 보고 싶은 영화입니다.</td>
								<td>추천</td>
								<td>2024-12-16</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div id="page_button_group">
					<input type="button" value="<">
					<input type="button" value="1">
					<input type="button" value=">">
				</div>
			</div>
		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>