<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/theater_info/directions_info.css" />
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/theater_info_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<div class="content">

    		<h2 style="font-size: 30px;">오시는 길</h2>
    		<h6>여기는 지도 api자리</h6>
<!-- 			<img src="" alt="지도api 이용"> -->
	
 

    	<div class="list-container">
     	 <p><strong>• 도로명 주소 : (48513) 부산광역시 남구 용소로 45 </strong></p>
     	 <p><strong>• 지번 주소 : 부산광역시 남구 용소로 45</strong></p>
     	 <p><strong>• 대표 전화 : ☎ (051)629-4114</strong></p>
     	 	<ul>

	       	 	<li><h4>버스 이용시</h4> 10, 20, 22, 24, 27, 39, 40, 41, 42, 51, 83, 83-1, 108-1, 131, 139, 155, 583, 1003 </li>
	        	<li><h4>지하철 이용시</h4>1호선 : 부산역에서 학교로 부산역 → 서면(환승) → 경성대,부경대역 3번 출구<br>
						   2호선 : 서부시외버스터미널에서 학교로 사상 → 서면 → 경성대,부경대역 3번 출구</li>
   			</ul>
   		</div>

  		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>