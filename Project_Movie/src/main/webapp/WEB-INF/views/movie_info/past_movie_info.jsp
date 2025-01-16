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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movie_info/past_movie_info.css" />
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/movie_info_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<div id="past_movie_info">
			<div id="page_top">
				<div id="title">
					지난상영작
				</div>
				<div>
					<div id="movie_search">
						<form action="PastMovieInfo" method="get">
							<select name="howSearch">
								<option value="movie_name" <c:if test="${param.howSearch eq 'movie_name'}">selected</c:if>>영화제목</option>
								<option value="movie_genre" <c:if test="${param.howSearch eq 'movie_genre'}">selected</c:if>>장르</option>
								<option value="age_limit" <c:if test="${param.howSearch eq 'age_limit'}">selected</c:if>>관람등급</option>
							</select>
							<input type="text" name="searchKeyword" placeholder="검색어를 입력하세요">
							<input type="submit" value="검색">
						</form>
					</div>
<!-- 					<select> -->
<!-- 						<option>가나다순 ▲</option> -->
<!-- 						<option>가나다순 ▼</option> -->
<!-- 						<option>평점순 ▲</option> -->
<!-- 						<option>평점순 ▼</option> -->
<!-- 					</select> -->
				</div>
			</div>
			<div id="past_movie_list">
				<c:choose>
					<c:when test="${movieList.size() eq 0}">
							조회된 영화가 없습니다.<br>
							다시 검색해 주세요.
					</c:when>
					<c:otherwise>
						<c:forEach var="movie" items="${movieList}">
							<div class="movie">
								<div class="movie_poster">
									<a href="MovieInfoDetail?movie_code=${movie.movie_code}"><img src="${movie.movie_img1}" title="상세페이지로 이동"></a>
								</div>
								<div class="movie_info">
									<b id="movie_name">${movie.movie_name}</b><br>
									<b>감독</b> : ${movie.movie_director} | <b>출연</b> : ${movie.movie_actor}<br>
									<b>등급</b> : ${movie.age_limit} | <b>장르</b> : ${movie.movie_genre}<br>
									<b>개봉일</b> : ${movie.release_date} | <b>러닝타임</b> : ${movie.running_time}<br>
									<b>평점</b> : ${movie.movie_rating}<br>
									<b>줄거리</b> - ${movie.movie_synopsis}<br>
								    <input type="button" value="자세히보기" onclick="location.href='MovieInfoDetail?movie_code=${movie.movie_code}'">
								</div>
							</div>
						</c:forEach>
						<div id="page_button_group">
							<c:if test="${not empty param.searchKeyword}">
								<c:set var="searchParam" value="&howSearch=${param.howSearch}&searchKeyword=${param.searchKeyword}"/>			
							</c:if>
							<c:if test="${pageInfo.maxPage != 0}">
					            <input type="button" value="<" <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>
					            	onclick="location.href='PastMovieInfo?pageNum=${pageInfo.pageNum - 1}${searchParam}'">
					            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
					            	<c:choose>
					            		<c:when test="${pageInfo.pageNum eq i}">
					            			<b>${i}</b>
					            		</c:when>
					            		<c:otherwise>
					            			<a href="AdminMovieSetList?pageNum=${i}${searchParam}">${i}</a>
					            		</c:otherwise>
					            	</c:choose>
					            </c:forEach>
					            <input type="button" value=">" <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>
					            onclick="location.href='PastMovieInfo?pageNum=${pageInfo.pageNum + 1}${searchParam}'">
							</c:if>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>