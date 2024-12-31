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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movie_info/season_movie_info.css">
</head>
<body class="left-sidebar is-preload">

   <jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
   <jsp:include page="/WEB-INF/views/inc/page/theater_info_sidebar.jsp"></jsp:include>
   
   <article class="box post">
     <div class="content">
     	<div id ="title">
     		• itwill 영화관
     	</div>
      	<img src="https://via.placeholder.com/150" alt="영화 포스터" class="movie-poster">
      	<p><strong>• 영화관 설명</strong></p>
       	<p>itwill 영화관은 독립영화란 이윤 확보를 1차 목표로 하는 일반 상업영화와는 달리 창작자의 의도가 우선시되는 영화로 주제와 형식, 제작방식 면에서 차별화됩니다.
			여기에서 ‘독립’이란 자본과 배급망으로부터의 독립을 뜻합니다.
			
			작은영화, 소형영화, 민중영화, 독립영화 등 시대별로 각각 다양하게 불려왔던 한국 독립영화는 미국 인디필름이나 일본 자주영화 등과는 다른 보다 포괄적인 개념을 담아왔습니다.
			
			1980년대, 암울했던 시대와 이른바 ‘충무로’로 대표되던 주류 한국영화계에 대한 반발에서 본격화되면서 한국 독립영화는 정치적이고 진보적인 성향이 강한 정체성을 형성해 왔습니다.
			하지만 동시에 상업영화의 반대급부로서 새롭고 다양한 미학적 시도를 통해 ‘다른 영화’의 가능성을 확인시켰으며 상업영화로는 대체할 수 없는 특별한 영역을 형성해 왔습니다.
			무엇보다 독립영화는 관객 개개인에게도 단순한 수용자로가 아닌 스스로 카메라를 들고 영화를 만들 수 있다는, 창작의식을 고취시키는데 중요한 역할을 해 왔습니다.</p>
   
       <div class="table-container">
         <div id="fee">
	        • 이용 요금 안내
         </div>
         <table border="1">
		  <thead>
		    <tr>
		      <th rowspan="2">구분</th> 
		      <th colspan="1">일반요금</th>
		      <th colspan="3">할인요금</th> 
		    </tr>
		    <tr>
		      <th>성인</th>
		      <th>청소년</th>
		      <th>장애인/국가유공자</th>
		      <th>단체(10인이상)</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <td>관람료</td> 
		      <td>10000원</td>
		      <td>7000원</td>
		      <td>5000원</td>
		      <td>6000원</td>
		    </tr>
		  </tbody>
		</table>
       </div>
   
       <div class="list-container">
         <div id="rule">
         	• 상영관 운영 수칙
         </div>
         <ul>
           <li>상영 시작 10분 전 입장 바랍니다.</li>
           <li> 상영 중 휴대폰 사용을 삼가주세요.</li>
           <li>음식물 반입 제한이 있습니다.</li>
         </ul>
       </div>
       
     </div>
   </article>


	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>