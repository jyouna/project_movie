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
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/theater_info_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<div class="content">
    		<h1 style="font-size: 1.5em;">좌석배치도</h1>
    		<hr>
    		<h6 style="font-weight: normal;">※ 1-3관 좌석배치도 동일</h6>
    	<div class="seat-layout">
				<img
					src="${pageContext.request.contextPath}/resources/images/seat.png"
					alt="좌석 배치도" width="779.5" height="451">
			</div>
  		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>