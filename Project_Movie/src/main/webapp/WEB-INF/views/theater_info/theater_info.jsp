<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/theater_info/theater_info.css" />
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/theater_info_sidebar.jsp"></jsp:include>
	
	<article class="box post">
			  <div class="content">
	
	    <h1>itwill 영화관</h1>
		<img src="https://via.placeholder.com/150" alt="영화 포스터" class="movie-poster">
	    <p><strong>• 영화관 설명</strong></p>
	    <p>itwill 영화관은 최고의 관람 경험을 제공합니다.</p>
	
	    <div class="table-container">
	      <p><strong>• 이용 요금 안내</strong></p>
	      <table>
	        <thead>
	          <tr>
	            <th rowspan="2">구분</th>
	            <th>일반요금</th>
	            <th colspan="3">할인요금</th>
	          </tr>
	        </thead>
	        <tbody>
	          <tr>
	            <th></th>
	            <th>성인</th>
	            <th>청소년</th>
	            <th>장애인/국가유공자</th>
	            <th>단체(10인이상)</th>
	          </tr>
	          <tr>
	          <th>관람료</th>
	            <th>10000원</th>
	            <th>7000원</th>
	            <th>5000원</th>
	            <th>6000원</th>
	          </tr>
	        </tbody>
	      </table>
	    </div>
	
	    <div class="list-container">
	      <p><strong>• 상영관 운영 수칙</strong></p>
	      <ul>
	        <li>→ 상영 시작 10분 전 입장 바랍니다.</li>
	        <li>→ 상영 중 휴대폰 사용을 삼가주세요.</li>
	        <li>→ 음식물 반입 제한이 있습니다.</li>
	      </ul>
	    </div>
	
	  </div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>