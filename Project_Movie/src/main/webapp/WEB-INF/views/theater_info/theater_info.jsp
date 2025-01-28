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
     <div class="content">
      	<img src="${pageContext.request.contextPath}/resources/images/pickcine.png" alt="영화관" id="pickcine">
      	<p><strong>• 영화관 설명</strong></p>
			<p>PICKCINE는 가족과 연인이 함께 즐길 수 있는 특별한 경험을 제공하는 영화관 입니다.<br>
				각 시즌마다 투표를 통해 새롭고 다양한 테마를 도입하여 항상 신선한 콘텐츠를 만나볼 수 있게 합니다.
 				PICKCINE의 목표는 관객들이 언제나 기대하고 설레며, 영화 관람을 통해 더욱 가까워지는 시간과 공간을 마련하는 것입니다.
			</p> 
			<br>
      	<p><strong>• 시즌 안내</strong></p>
		<div id="season">
			<h5>봄 시즌 (3월 - 5월)</h5>
			"설렘이 가득한 봄, 감성을 자극하는 로맨스 영화와 따뜻한 감동을 전하는 영화들을 만나보세요."
	
			<h5>여름 시즌 (6월 - 8월)</h5>
			"태양처럼 뜨거운 여름, 시원한 액션 블록버스터와 유쾌한 코미디 영화로 무더위를 날려보세요. 영화관에서 즐기는 특별한 여름휴가를 선사합니다!"
			
			<h5>가을 시즌 (9월 - 11월)</h5>
			"가을의 낭만과 깊이를 담은 계절, 마음을 울리는 드라마와 잔잔한 여운을 남기는 명작들이 여러분을 기다립니다. 낙엽처럼 물드는 감동을 경험하세요."
			
			<h5>겨울 시즌 (12월 - 2월)</h5>
			"추운 겨울, 따뜻한 영화가 여러분을 감싸줍니다. 가족, 사랑, 그리고 연말 분위기를 물씬 느낄 수 있는 영화들과 함께 특별한 겨울을 만들어보세요."
		</div>  
			
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
		      <th>단체(8인이상)</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <td>관람료</td> 
		      <td>13000원</td>
		      <td>11000원</td>
		      <td>9000원</td>
		      <td>*별도문의</td>
		    </tr>
		  </tbody>
		</table>
       </div>
   
       <div class="list-container" >
         <div id="rule">
         	• 상영관 운영 수칙
         </div>
         <ol style="font-weight: 540;">
           <li><h5>핸드폰 사용 금지</h5>
				<p style="font-weight: normal;">영화 상영 중에는 핸드폰 사용을 자제해야 합니다. 화면 밝기나 소리가 다른 관객의 영화 감상에 <br> 방해가 될 수 있습니다.</p></li>
           <li><h5>조용히 관람하기</h5>
				<p style="font-weight: normal;">대화, 소음, 큰 소리로 웃는 행동은 주변 관객들에게 피해를 줄 수 있으므로 상영 중에는 조용히<br> 관람해야 합니다.</p></li>
           <li><h5>정해진 좌석에 앉기</h5>
           		<p style="font-weight: normal;">예매한 좌석에 앉아야 하며, 다른 관객의 자리나 공간을 침범하지 않도록 주의해야 합니다.</p></li>
           <li><h5>음식 섭취 시 주의</h5>
           		<p style="font-weight: normal;">상영 중 음식을 섭취할 때는 냄새가 강하거나 소리가 큰 음식은 자제하고, 깨끗하게 먹어야 합니다.</p></li>
           <li><h5>쓰레기 정리</h5>
           		<p style="font-weight: normal;">관람 후 자신이 사용한 쓰레기는 상영관 밖에 있는 쓰레기통에 버려야 하며, 좌석을 깨끗하게<br> 유지해야 합니다.</p></li>

         </ol>
       </div>
       
     </div>
   </article>
	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>

</body>
</html>