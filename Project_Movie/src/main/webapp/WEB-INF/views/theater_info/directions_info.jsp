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

    		<h1 style="font-size: 1.5em;">오시는 길</h1>
    		<hr>
    		<div id ="map" style="width: 880px; height:400px;"></div>
    		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2c5b5e9afc6d3af813d2e295bea48e20"></script>
    		<script type="text/javascript">
    			var container = document.getElementById('map');
    			var options = {
    					center: new kakao.maps.LatLng(35.158492, 129.062055),
    					level:3
    			};
 				var map = new kakao.maps.Map(container, options);   		
    		</script>

    	<div class="list-container">
     	 <p><strong>• 도로명 주소 : (47246) 부산광역시 부산진구 동천로 109 (삼환골든게이트) 7층</strong></p>
     	 <p><strong>• 지번 주소 : 부산광역시 부산진구 부전동 112-3 7층</strong></p>
     	 <p><strong>• 대표 전화 : ☎ (051)803-0909</strong></p>
     	 	<ul>
	       	 	<li><h4>버스 이용시</h4> 10, 20, 22, 24, 27, 39, 40, 41, 42, 51, 83, 83-1, 108-1, 131, 139, 155, 583, 1003 </li>
	        	<li><h4>지하철 이용시</h4>1호선 : 부산역 → 서면역 8번출구<br>
						   				2호선 : 서부시외버스터미널 사상역 → 서면역 8번출구</li>
	        	<li><h4>자차 이용시</h4>건물 내 지하주차장 이용</li>
   			</ul>
   		</div>

  		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>