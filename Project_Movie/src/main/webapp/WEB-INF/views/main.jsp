<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>    
<!DOCTYPE HTML>
<!--
	Escape Velocity by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
	<title>Movie</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
</head>
<body class="homepage is-preload">

	<jsp:include page="/WEB-INF/views/inc/main_top.jsp"></jsp:include>

		<section id="intro" class="wrapper style1">
			<div class="title">Currently Movies</div>
			<div class="container">
				<p class="style2">
					<img src="${pageContext.request.contextPath}/resources/images/poster1.webp" width=400>
					<img src="${pageContext.request.contextPath}/resources/images/poster2.jpg" width=400>
					<img src="${pageContext.request.contextPath}/resources/images/poster3.webp" width=400>
				</p>
				<ul class="actions">
					<li><input type="button" class="button style3 large" value="<"></li>
					<li><input type="text" class="button style3 large" value="1관" readonly></li>
					<li><input type="button" class="button style3 large" value=">"></li>
				</ul>
			</div>
		</section>
	
		<section id="highlights" class="wrapper style3">
			<div class="container">
				<div class="row aln-center">
					<div class="col-4 col-12-medium">
						<section class="highlight">
							<h3><a href="#">공지사항</a></h3>
							<p>Eget mattis at, laoreet vel amet sed velit aliquam diam ante, dolor aliquet sit amet vulputate mattis amet laoreet lorem.</p>
							<ul class="actions">
								<li><a href="" class="button style1">Learn More</a></li>
							</ul>
						</section>
					</div>
					<div class="col-4 col-12-medium">
						<section class="highlight">
							<h3><a href="#">FAQ</a></h3>
							<p>Eget mattis at, laoreet vel amet sed velit aliquam diam ante, dolor aliquet sit amet vulputate mattis amet laoreet lorem.</p>
							<ul class="actions">
								<li><a href="#" class="button style1">Learn More</a></li>
							</ul>
						</section>
					</div>
					<div class="col-4 col-12-medium">
						<section class="highlight">
							<h3><a href="#">광고판</a></h3>
							<p>Eget mattis at, laoreet vel amet sed velit aliquam diam ante, dolor aliquet sit amet vulputate mattis amet laoreet lorem.</p>
							<ul class="actions">
								<li><a href="#" class="button style1">Learn More</a></li>
							</ul>
						</section>
					</div>
				</div>
			</div>
		</section>
	
	<jsp:include page="/WEB-INF/views/inc/main_bottom.jsp"></jsp:include>
	
</body>
</html>