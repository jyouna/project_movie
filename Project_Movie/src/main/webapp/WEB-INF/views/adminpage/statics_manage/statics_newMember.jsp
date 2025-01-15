<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/statics.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/statics.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<style type="text/css">
#headTitle {
	background-color: lightblue;
}
#myChart {
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<div id="tableDiv">
		<h2 id="headTitle">신규 가입자 통계</h2>
<!-- 			<input type="button" onclick="location.href='makeNewmember'" value="회원생성"> -->
			<input type="button" value="전체 기간" id="totalPeriodSearch">
			기간설정 
			<select id="year">
				<option selected>연도</option>
				<option value="2024">2024</option>
				<option value="2023">2023</option>
				<option value="2022">2022</option>
				<option value="2021">2021</option>
				<option value="2020">2020</option>
			</select>
			<select id="month">
				<option value="">월</option>
				<option value="1">1월</option>
				<option value="2">2월</option>
				<option value="3">3월</option>
				<option value="4">4월</option>
				<option value="5">5월</option>
				<option value="6">6월</option>
				<option value="7">7월</option>
				<option value="8">8월</option>
				<option value="9">9월</option>
				<option value="10">10월</option>
				<option value="11">11월</option>
				<option value="12">12월</option>
				<option value="yearTotal">전체</option>
			</select>
	</div>
	<div id="chartArea">
		<canvas id="myChart"></canvas>
	</div>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	let myChart;
	let date = new Date();
	let year = date.getFullYear()-1;
	let month = date.getMonth();
	
	$.ajax({
		url: "GetYearTotalMemberJoinStaticsInfo",
		type: "get",
		data : {
			year : year,
		},
		dataType: "json",
		success: function(response){
  			if(myChart){myChart.destroy();} // 차트가 존재하면 먼저 지우고 새 차트를 생성
			const monthOrder = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
 			const data = monthOrder.map(month => response[month] || 0); // 월 순서에 맞게 배열로 변환 (값이 없으면 0)
			const ctx = document.getElementById('myChart').getContext('2d');
			
  				
			myChart = new Chart(ctx, {
				type: "bar",
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
						subtitle: { // 차트 제목
							display: true,
							text: '연간 가입자 통계' 
						}
					},
					scales: {
						x : {
							ticks: {
								color: 'rgba(75, 192, 192, 1)'
							}
						},
						y: {
							min : 0,
							max : 600,
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
	
	
	
	
	
	$("#totalPeriodSearch").on("click",function(){

	});

	$("#monthlySearch").on("click",function(){

	});
	
	$("#specificPeriodSearch").on("click",function(){

	});
	
	$("#year").on("change", function(){
		let year = $("#year").val();
		
		if(year === "연도") {
			$("#month").css("display", "none");
		} else {
			$("#month").css("display", "inline-block");
		}
	})
	
	$("#month").on("change", function(){
		let year = $("#year").val();
		let month = $("#month").val();
		let yearAndMonth = year + "년 " + month + "월";
		
		if(month !== "" && month !== "yearTotal") {
			console.log("year : " + year);	
			console.log("month : " + month);	
			
			$.ajax({
				url: "GetMonthlyMemberJoinStaticsInfo",
				type: "get",
				data : {
					year : year,
					month : month
				},
				dataType: "json",
				success: function(response){
					if(myChart){myChart.destroy();}
					const ctx = document.getElementById('myChart').getContext('2d');
					myChart = new Chart(ctx, {
						type: "bar",
						data: {
							labels : [yearAndMonth], // 축
							datasets: [{ // 각 축에 들어갈 값 설정
								label:  year + "년 가입자 수", // 값
								backgroundColor: 'rgba(255, 99, 132, 0.2)',
								borderColor: 'rgba(54, 162, 235, 1)',
								borderWidth: 2
							}]
						},
						options: {
							plugins: {
								subtitle: { // 차트 제목
									display: true,
									text: '연간 가입자 통계' 
								}
							},
							scales: {
								x : {
									ticks: {
										color: 'rgba(75, 192, 192, 1)'
									}
								},
								y: {
									min : 0,
									max : 600,
									ticks: {
										color: 'rgba(75, 192, 192, 1)',
										stepSize: 50
									}
									
								}
							}
						}
					});
				}
			})
		} else if(month === "yearTotal") {
			console.log("연간 통계 선택");
			$.ajax({
				url: "GetYearTotalMemberJoinStaticsInfo",
				type: "get",
				data : {
					year : year,
				},
				dataType: "json",
				success: function(response){
					const monthOrder = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
    				const data = monthOrder.map(month => response[month] || 0); // 월 순서에 맞게 배열로 변환 (값이 없으면 0)
					const ctx = document.getElementById('myChart').getContext('2d');
					
    				if(myChart){myChart.destroy();} // 차트가 존재하면 먼저 지우고 새 차트를 생성
    				
					myChart = new Chart(ctx, {
						type: "bar",
						data: {
							labels : monthOrder, // 축
							datasets: [{ // 각 축에 들어갈 값 설정
								label:  year + "년 가입자 수" , // 값 이름
								data: data, // 값
								backgroundColor: 'rgba(255, 99, 132, 0.2)',
								borderColor: 'rgba(54, 162, 235, 1)',
								borderWidth: 2
							}]
						},
						options: {
							plugins: {
								subtitle: { // 차트 제목
									display: true,
									text: '연간 가입자 통계' 
								}
							},
							scales: {
								x : {
									ticks: {
										color: 'rgba(75, 192, 192, 1)'
									}
								},
								y: {
									min : 0,
									max : 600,
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
			
		}
	});
});

</script>
</body>
</html>