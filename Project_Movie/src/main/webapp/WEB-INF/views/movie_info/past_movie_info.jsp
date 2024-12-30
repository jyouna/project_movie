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
						<select>
							<option>제목+내용</option>
						</select>
						<input type="text" placeholder="검색어를 입력하세요">
						<input type="button" value="검색">
					</div>
					<div id="select_search">
						<select>
							<option>추천순</option>
							<option>추천순</option>
							<option>추천순</option>
						</select>
					</div>
				</div>
			</div>
			<div id="past_movie_list">
				<c:forEach var="i" begin="1" end="10">
					<div class="movie">
						<div class="movie_poster">
							<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster1.webp"></a>
						</div>
						<div class="movie_info">
							<b>영화제목</b><br>
							감독 : xxx | 출연 : 로버트 다우니 주니어, 아놀드 슈왈츠 제네거, 박정현 | 등급 : 전체관람가<br>
							장르 : 액션 | 개봉일 : 2024/12/31 | 러닝타임 : 120분<br>
							별점 ★★★★★<br>
							줄거리 - 그댄아시나요 있잖아요 그대가 너무 그리워요 고개숙여 눈물훔쳐요 당신의
							이름을 불러요 꼭 이렇게 날남겨두고 떠나갸야만 했는지 너만 생각하면 머리아퍼 독하디
							독한 술 같어 술 뿐이겠어 병이지 매일 앓아 누워 몇 번인지...
						    <input type="button" value="예매하기">
						    <input type="button" value="자세히보기">
						</div>
					</div>
				</c:forEach>
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