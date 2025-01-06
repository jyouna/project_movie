<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/theater_info/theater_info.css">
</head>
<body class="left-sidebar is-preload">

   <jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
   <jsp:include page="/WEB-INF/views/inc/page/theater_info_sidebar.jsp"></jsp:include>
   
   <article class="box post">
		<div id="title">
			<h1 style="font-size: 1.5em;">itwill 영화관</h1>
		</div>
     <div class="content">
      	<img src="https://via.placeholder.com/150" alt="영화 포스터" class="movie-poster">
      	<p><strong>• 영화관 설명</strong></p>
			<p>어떤 영화는 시간이 지나도 우리의 가슴 속에 남아있습니다. 
			그 영화가 처음 상영되던 순간의 감동, 그리운 장면과 대사, 그리고 함께했던 추억까지. 이제 그 특별한 순간을 다시 느낄 수 있는 곳이 있습니다.

			저희 영화관은 고객 여러분의 의견을 소중히 여깁니다. 시즌별로 상영이 종료된 영화들을 대상으로 투표를 진행하여, 가장 많은 사랑을 받은 작품들을 다시 스크린에 올립니다. 단순한 재상영이 아니라, 추억을 되살리고, 잊지 못할 경험을 선사하는 특별한 기회를 제공합니다.
			여러분의 사랑으로 완성되는 영화관, 그 감동을 다시 함께 만들어 가겠습니다. 
			잊지 못할 영화의 순간들을 다시 만날 준비가 되셨나요? 지금, 여러분의 소중한 투표로 영화의 새로운 역사를 함께 써 내려가 주세요!

			</p>   
       <div class="table-container">
         <div id="fee">
	        • 이용 요금 안내
         </div>
         <table border="1">
		  <thead>
		    <tr>
		      <th rowspan="2" style="text-align: center;">구분</th> 
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
         <ol style="font-weight: 540;">
           <li>핸드폰 사용 금지
				<p style="font-weight: normal;">영화 상영 중에는 핸드폰 사용을 자제해야 합니다. 화면 밝기나 소리가 다른 관객의 영화 감상에 방해가 될 수 있습니다.</p></li>
           <li>조용히 관람하기
				<p style="font-weight: normal;">대화, 소음, 큰 소리로 웃는 행동은 주변 관객들에게 피해를 줄 수 있으므로 상영 중에는 조용히 관람해야 합니다.</p></li>
           <li>정해진 좌석에 앉기
           		<p style="font-weight: normal;">예매한 좌석에 앉아야 하며, 다른 관객의 자리나 공간을 침범하지 않도록 주의해야 합니다.</p></li>
           <li>음식 섭취 시 주의
           		<p style="font-weight: normal;">상영 중 음식을 섭취할 때는 냄새가 강하거나 소리가 큰 음식은 자제하고, 깨끗하게 먹어야 합니다.</p></li>
           <li>쓰레기 정리
           		<p style="font-weight: normal;">관람 후 자신이 사용한 쓰레기는 상영관 밖에 있는 쓰레기통에 버려야 하며, 좌석을 깨끗하게 유지해야 합니다.</p></li>

         </ol>
       </div>
       
     </div>
   </article>


	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>