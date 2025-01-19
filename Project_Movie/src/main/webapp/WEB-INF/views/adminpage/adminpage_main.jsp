<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html lang="en">
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>관리자페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminMainPage.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
	
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<article id="testArticle">
		<section id="sec01" class="secMain">
			<h5>※ 공지사항</h5>
			<div id="noticeBoardMain" class="secitonBoard">
				<p>공지사항 게시판 작성영역</p>
			</div>
			<ul>
				<li>test</li>
				<li>test</li>
			</ul>
		</section>
		<section id="sec02" class="secMain">
			<h5>※ 1:1 문의 내역</h5>
			<div class="secitonBoard">
				<p>1:1문의 상태 표시판</p>
			</div>			
			<ol>
				<li>test</li>
				<li>test</li>
			</ol>
		</section>
		<section id="sec03" class="secMain">
			<h5>※ 매출 통계</h5>
			<div class="secitonBoard">
				<p>매출 통계 그래프 표시판</p>
			</div>				
			<p>sec03</p>
		</section>
		<section id="sec04" >
			<span id="showPeriod"></span><br>
<!-- 			<h5>※ 가입자 통계</h5> -->
<!-- 			<div class="secitonBoard"> -->
<!-- 			<input type="button" value="2024년" onclick="location.href='StaticsNewMember'"> -->
<!-- 			<input type="button" value="전체 기간" id="totalPeriodSearch"> -->
<!-- 			조회기간 -->
<!-- 			<br> -->
<!-- 			<select id="year"> -->
<!-- 				<option selected>연도</option> -->
<!-- 				<option value="2025">2025</option> -->
<!-- 				<option value="2024">2024</option> -->
<!-- 				<option value="2023">2023</option> -->
<!-- 				<option value="2022">2022</option> -->
<!-- 				<option value="2021">2021</option> -->
<!-- 				<option value="2020">2020</option> -->
<!-- 			</select> -->
<!-- 			<select id="month"> -->
<!-- 				<option value="">월</option> -->
<!-- 				<option value="1">1월</option> -->
<!-- 				<option value="2">2월</option> -->
<!-- 				<option value="3">3월</option> -->
<!-- 				<option value="4">4월</option> -->
<!-- 				<option value="5">5월</option> -->
<!-- 				<option value="6">6월</option> -->
<!-- 				<option value="7">7월</option> -->
<!-- 				<option value="8">8월</option> -->
<!-- 				<option value="9">9월</option> -->
<!-- 				<option value="10">10월</option> -->
<!-- 				<option value="11">11월</option> -->
<!-- 				<option value="12">12월</option> -->
<!-- 				<option value="yearTotal">전체</option> -->
<!-- 			</select> -->
<!-- 		</div> -->
		<div id="chartArea">
			<canvas class="myChart"></canvas>
		</div>
		</section>
	</article>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>

<script type="text/javascript">
$(function(){
	let myChart;
	let date = new Date();
	let year = date.getFullYear()-1;
	let month = date.getMonth();
	$("#showPeriod").text(" : " + year).css("color", "blue");
/*
*
*
*			디폴트 화면 표시 차트 
*
*
*
*/
	$.ajax({
		url: "AdminMainGetYearTotalMemberJoinStaticsInfo",
		type: "get",
		data : {
			year : year,
		},
		dataType: "json",
		success: function(response){
  			if(myChart){myChart.destroy();} // 차트가 존재하면 먼저 지우고 새 차트를 생성
			
  			const monthOrder = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
 			const data = monthOrder.map(month => response[month] || 0); // 월 순서에 맞게 배열로 변환 (값이 없으면 0)
			const ctx = document.getElementsByClassName('myChart')[0].getContext('2d');
			
			let yearTotal = 0;
			for(let i = 0; i < monthOrder.length; i++) {
				yearTotal += data[i];
			}
			console.log(yearTotal);
			
			$("#showPeriod").text("가입자 통계 (" + year + ") 신규 가입자 : " + yearTotal.toLocaleString('ko-KR') + "명");
 			
 			myChart = new Chart(ctx, {
				type: "line",
				data: {
					labels : monthOrder, // 축
					datasets: [{ // 각 축에 들어갈 값 설정
						label: year + "년 가입자 수", // 값 이름
						data: data, // 값
						backgroundColor: 'rgba(255, 99, 132, 0.2)',
						borderColor: 'rgba(54, 162, 235, 1)',
						borderWidth: 2
					}]
				},
				options: {
					plugins: {
			            legend: {
			                labels: {
			                    usePointStyle: true, // 범례를 점 모양으로
			                    pointStyle: 'line'  // 범례를 직선으로 설정
			                }
			            },						
// 						subtitle: { // 차트 제목
// 							display: true,
// 							text: '연간 가입자 통계' 
// 						}
					},
					scales: {
						x : {
							ticks: {
								color: 'rgba(75, 192, 192, 1)'
							}
						},
						y: {
							min : 0,
							max : 500,
							ticks: {
								color: 'rgba(75, 192, 192, 1)',
								stepSize: 50
							}
						}
					}
				}
			});
		}
	});
})
	
</script>	

</body>
</html>