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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movie_info/upcoming_movie_info.css" />
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
				<div id="select_search">
					<select>
						<option>추천순</option>
					</select>
				</div>
			</div>
			<div id="season_movie_list">
				<div>
					<h2>Season Movie</h2>
				</div>
				<div>
					<div class="movie">
						<label>바람</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster1.webp"></a><br>
						<input type="button" value="자세히보기">
						<input type="button" value="예매하기">
						<div class="movie_info">
				            <ul>
		            			<li>영화 제목: 모아나 2</li>
					            <li>감독: 데이빗 테드 주니어</li>
					            <li>출연: 아웃이 크래랙존, 드웨인 존슨</li>
					            <li>등급: 전체 관람가</li>
					            <li>장르: 애니메이션</li>
					            <li>개봉일: 2024.1.27</li>
					            <li> 러닝 타임: 100분</li>
					            <li>발권: 10,000원</li>
				            </ul>
				        </div>
					</div>
					<div class="movie">
						<label>범죄와의전쟁</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster2.jpg"></a><br>
						<input type="button" value="자세히보기">
						<input type="button" value="예매하기">
						<div class="movie_info">
				            <ul>
		            			<li>영화 제목: 모아나 2</li>
					            <li>감독: 데이빗 테드 주니어</li>
					            <li>출연: 아웃이 크래랙존, 드웨인 존슨</li>
					            <li>등급: 전체 관람가</li>
					            <li>장르: 애니메이션</li>
					            <li>개봉일: 2024.1.27</li>
					            <li> 러닝 타임: 100분</li>
					            <li>발권: 10,000원</li>
				            </ul>
				        </div>
					</div>
					<div class="movie">
						<label>신세계</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster3.webp"></a><br>
						<input type="button" value="자세히보기">
						<input type="button" value="예매하기">
						<div class="movie_info">
				            <ul>
		            			<li>영화 제목: 모아나 2</li>
					            <li>감독: 데이빗 테드 주니어</li>
					            <li>출연: 아웃이 크래랙존, 드웨인 존슨</li>
					            <li>등급: 전체 관람가</li>
					            <li>장르: 애니메이션</li>
					            <li>개봉일: 2024.1.27</li>
					            <li> 러닝 타임: 100분</li>
					            <li>발권: 10,000원</li>
				            </ul>
				        </div>
					</div>
				</div>
			</div>
			<div id="movie_list">
				<div>
					<div class="movie">
						<label>바람</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster1.webp"></a><br>
						<input type="button" value="자세히보기">
						<input type="button" value="예매하기">
						<div class="movie_info">
				            <ul>
		            			<li>영화 제목: 모아나 2</li>
					            <li>감독: 데이빗 테드 주니어</li>
					            <li>출연: 아웃이 크래랙존, 드웨인 존슨</li>
					            <li>등급: 전체 관람가</li>
					            <li>장르: 애니메이션</li>
					            <li>개봉일: 2024.1.27</li>
					            <li> 러닝 타임: 100분</li>
					            <li>발권: 10,000원</li>
				            </ul>
				        </div>
					</div>
					<div class="movie">
						<label>범죄와의전쟁</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster2.jpg"></a><br>
						<input type="button" value="자세히보기">
						<input type="button" value="예매하기">
						<div class="movie_info">
				            <ul>
		            			<li>영화 제목: 모아나 2</li>
					            <li>감독: 데이빗 테드 주니어</li>
					            <li>출연: 아웃이 크래랙존, 드웨인 존슨</li>
					            <li>등급: 전체 관람가</li>
					            <li>장르: 애니메이션</li>
					            <li>개봉일: 2024.1.27</li>
					            <li> 러닝 타임: 100분</li>
					            <li>발권: 10,000원</li>
				            </ul>
				        </div>
					</div>
					<div class="movie">
						<label>신세계</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster3.webp"></a><br>
						<input type="button" value="자세히보기">
						<input type="button" value="예매하기">
						<div class="movie_info">
				            <ul>
		            			<li>영화 제목: 모아나 2</li>
					            <li>감독: 데이빗 테드 주니어</li>
					            <li>출연: 아웃이 크래랙존, 드웨인 존슨</li>
					            <li>등급: 전체 관람가</li>
					            <li>장르: 애니메이션</li>
					            <li>개봉일: 2024.1.27</li>
					            <li> 러닝 타임: 100분</li>
					            <li>발권: 10,000원</li>
				            </ul>
				        </div>
					</div>
				</div>
				<div>
					<div class="movie">
						<label>바람</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster1.webp"></a><br>
						<input type="button" value="자세히보기">
						<input type="button" value="예매하기">
						<div class="movie_info">
				            <ul>
		            			<li>영화 제목: 모아나 2</li>
					            <li>감독: 데이빗 테드 주니어</li>
					            <li>출연: 아웃이 크래랙존, 드웨인 존슨</li>
					            <li>등급: 전체 관람가</li>
					            <li>장르: 애니메이션</li>
					            <li>개봉일: 2024.1.27</li>
					            <li> 러닝 타임: 100분</li>
					            <li>발권: 10,000원</li>
				            </ul>
				        </div>
					</div>
					<div class="movie">
						<label>범죄와의전쟁</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster2.jpg"></a><br>
						<input type="button" value="자세히보기">
						<input type="button" value="예매하기">
						<div class="movie_info">
				            <ul>
		            			<li>영화 제목: 모아나 2</li>
					            <li>감독: 데이빗 테드 주니어</li>
					            <li>출연: 아웃이 크래랙존, 드웨인 존슨</li>
					            <li>등급: 전체 관람가</li>
					            <li>장르: 애니메이션</li>
					            <li>개봉일: 2024.1.27</li>
					            <li> 러닝 타임: 100분</li>
					            <li>발권: 10,000원</li>
				            </ul>
				        </div>
					</div>
					<div class="movie">
						<label>신세계</label><br>
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/poster3.webp"></a><br>
						<input type="button" value="자세히보기">
						<input type="button" value="예매하기">
						<div class="movie_info">
				            <ul>
		            			<li>영화 제목: 모아나 2</li>
					            <li>감독: 데이빗 테드 주니어</li>
					            <li>출연: 아웃이 크래랙존, 드웨인 존슨</li>
					            <li>등급: 전체 관람가</li>
					            <li>장르: 애니메이션</li>
					            <li>개봉일: 2024.1.27</li>
					            <li> 러닝 타임: 100분</li>
					            <li>발권: 10,000원</li>
				            </ul>
				        </div>
					</div>
				</div>
			</div>
		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>