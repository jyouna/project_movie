<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
					${voteInfo.vote_name} 결과
				</div>
				<c:forEach var="movie" items="${voteCurrentInfoList}" varStatus="status">
					<div class="movie" id="movie${status.count}">
						<label>
							${movie.movie_name}(
								<fmt:formatNumber value="${movie.count / totalCount * 100}" pattern="#0.0"></fmt:formatNumber>
							)
						</label><br>
						<img src="${movie.movie_img1}" class="movieImg"><br>
						<input type="button" value="자세히보기" onclick="location.href='MovieInfoDetail?movie_code=${movie.movie_code}'">
						<c:if test="${status.count < 4 }">
							<div class="pick_grade">
								<img src="${pageContext.request.contextPath}/resources/images/${status.count}grade.png">
					        </div>
						</c:if>
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
					<c:if test="${status.count % 3 == 0}"><hr></c:if>
				</c:forEach>
			</div>
			<div id="pick_notice">
				<div>안내사항</div>
				투표에서 선정된 시즌 영화는 다음시즌에 상영될 예정입니다.<br>
				예매는 다음 시즌 시작 3일전부터 가능하며 투표로 선정된 3개의 시즌영화 외에<br>
				6개의 영화가 함께 상영될 예정입니다.(상영예정작 페이지 참고하여 주십시오)<br>
				<br>
				시즌안내<br>
				봄시즌 - 3월 ~ 5월<br>
				여름시즌 - 6월 ~ 8월<br>
				가을시즌 - 9월 ~ 11월<br>
				겨울시즌 - 12월 ~ 2월<br>
			</div>
		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>