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
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<h2 id="headTitle">신규 가입자 통계</h2>
	<div id="tableDiv">
		<input type="button" value="2024년" onclick="location.href='StaticsNewMember'">
		<input type="button" value="전체 기간" id="totalPeriodSearch">
		조회기간
		<span id="showPeriod"></span>
		<br>
		<select id="year">
			<option selected>연도</option>
			<option value="2025">2025</option>
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
		<canvas class="myChart"></canvas>
	</div>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	let myChart;
	let date = new Date();
	let year = date.getFullYear()-1;
	let month = date.getMonth();
	$("#showPeriod").text(" : " + year).css("color", "blue");
	
	// 1. 디폴트 화면 표시 차트
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
			const ctx = document.getElementsByClassName('myChart')[0].getContext('2d');
			
			let yearTotal = 0;
			for(let i = 0; i < monthOrder.length; i++) {
				yearTotal += data[i];
			}
			console.log(yearTotal);
			
			$("#showPeriod").text(year + " (" + yearTotal.toLocaleString('ko-KR') + "명)");
 			
 			myChart = new Chart(ctx, {
				type: "line",
				data: {
					labels : monthOrder, // 축
					datasets: [{ // 각 축에 들어갈 값 설정
						label: year + "년 가입자 수(명)", // 값 이름
						data: data, // 값
						backgroundColor: 'rgba(255, 99, 132, 0.2)',
						borderColor: 'rgba(54, 162, 235, 1)',
						borderWidth: 2
					}]
				},
				options: {
			        responsive: true, // 반응형 차트 설정
			        maintainAspectRatio: false, // 가로세로 비율 고정 해제						
					plugins: {
			            legend: {
			                labels: {
			                    usePointStyle: true, // 범례를 점 모양으로
			                    pointStyle: 'line'  // 범례를 직선으로 설정
			                }
			            },						
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
							max : 2000,
							ticks: {
								color: 'rgba(75, 192, 192, 1)',
								stepSize: 100
							}
						}
					}
				}
			});
		}
	});
		
// 연도 선택
	$("#year").on("change", function(){
		let year = $("#year").val();
		
		if(year === "연도") {
			$("#month").css("display", "none");
		} else {
			$("#month").css("display", "inline-block");
		}
		
		$("#month").trigger("change"); 
		// "연도 선택" 시 자동으로 "현재 선택된 월"에 따른 차트를 표시하도록 트리거 작동
	})
	
/* 
 * 
 					연도 - 월 차례로 선택 시 나타나는 차트
 * 
*/
	$("#month").on("change", function(){
		let year = $("#year").val();
		let month = $("#month").val();
		let yearAndMonth = year + "년 " + month + "월";
		
		
		if(month !== "" && month !== "yearTotal") {
		$("#showPeriod").text(" : " + year + "." + month).css("color", "blue");
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
					$("#showPeriod").append(" (" + response.toLocaleString('ko-KR') + "명)");
					if(myChart){
						myChart.destroy();
					}
					
					const ctx = document.getElementsByClassName('myChart')[0].getContext('2d');
					myChart = new Chart(ctx, {
						type: "bar",
						data: {
							labels : [month+"월"], // 축
							datasets: [{ // 각 축에 들어갈 값 설정
								label:  yearAndMonth + "년 가입자 수(명)", // 값이름
								data: [response], // 값
								backgroundColor: 'rgba(255, 99, 132, 0.2)',
// 								borderColor: 'rgba(54, 162, 235, 1)',
// 								borderWidth: 2
							}]
						},
						options: {
					        responsive: true, // 반응형 차트 설정
					        maintainAspectRatio: false, // 가로세로 비율 고정 해제								
							plugins: {
								subtitle: { // 차트 제목
									display: true,
									text: '월 가입자 통계' 
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
									max : 2000,
									ticks: {
										color: 'rgba(75, 192, 192, 1)',
										stepSize: 100
									}
									
								}
							}
						}
					});
				}
			})
			
/*
 *
				월 옵션에서 "전체" 선택 시 나타나는 차트 
 */
 
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
					
    				if(myChart){myChart.destroy();} // 차트가 존재하면 먼저 지우고 새 차트를 생성

    				const monthOrder = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
    				const data = monthOrder.map(month => response[month] || 0); // 월 순서에 맞게 배열로 변환 (값이 없으면 0)
    				const ctx = document.getElementsByClassName('myChart')[0].getContext('2d');
    				
    				let yearTotal = 0;
    				for(let i = 0; i < monthOrder.length; i++) {
    					yearTotal += data[i];
    				}
    				console.log(yearTotal);
    				
    				$("#showPeriod").text(year + " (" + yearTotal.toLocaleString('ko-KR') + "명)");
    				
					myChart = new Chart(ctx, {
						type: "line",
						data: {
							labels : monthOrder, // 축
							datasets: [{ // 각 축에 들어갈 값 설정
								label:  year + "년 가입자 수(명)" , // 값 이름
								data: data, // 값
								backgroundColor: 'rgba(255, 99, 132, 0.2)',
								borderColor: 'rgba(54, 162, 235, 1)',
								borderWidth: 2
							}]
						},
						options: {
					        responsive: true, // 반응형 차트 설정
					        maintainAspectRatio: false, // 가로세로 비율 고정 해제								
							plugins: {
					            legend: {
					                labels: {
					                    usePointStyle: true, // 범례를 점 모양으로
					                    pointStyle: 'line'  // 범례를 직선으로 설정
					                }
					            },								
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
									max : 2000,
									ticks: {
										color: 'rgba(75, 192, 192, 1)',
										stepSize: 100
									}
									
								}
							}
						}
					});
				}
			});
			
		}
	});

	// 전체 기간 조회
	$("#totalPeriodSearch").on("click", function(){
		
		const getPeriod = $("#year option").map(function(){
			return $(this).val();
		}).get();
		
		const period = getPeriod.slice(1); // "선택"이 0번 인덱스에 포함되어 있으므로 제거.
		const periodStart = getPeriod.slice(1); // 종료연도 shift()를 위한 변수 
		const startYear = getPeriod.pop(); // 시작년도
		const endYear = periodStart.shift(); // 종료연도
		
		console.log(startYear);
		console.log(endYear);
		
		$("#showPeriod").text(" : " + startYear + " - " + endYear).css("color", "blue");
		console.log("period : " + period);
		console.log("period : " + typeof(period));
		
		$.ajax({
			url: "getTotalPeriodMemberJoinStatics",
			type: "post",
		    contentType: "application/json",
		    data: JSON.stringify({period: period}),
			datatype: "json",
			
		}).done(function(response){
			console.log("ajax통해 컨트롤러에서 전달받은 값 : " + response);
			console.log(JSON.stringify(response, null, 2));		
			const years = Object.keys(response);
			const counts = Object.values(response);	
			console.log(years);
			console.log(counts);
			
			if(myChart){myChart.destroy();} // 차트가 존재하면 먼저 지우고 새 차트를 생성
			const ctx = document.getElementsByClassName('myChart')[0].getContext('2d');
			
			let periodTotal = 0;
			for(let i = 0; i < counts.length; i++) {
				periodTotal += parseInt(counts[i]);
			}
			
			$("#showPeriod").append(" (" + periodTotal.toLocaleString('ko-KR') + "명)");
			
			myChart = new Chart(ctx, {
				type: "line",
				data: {
					labels : years, // 축
					datasets: [{ // 각 축에 들어갈 값 설정
						label:  "연도별 가입자 수(명)" , // 값 이름
						data: counts, // 값
						backgroundColor: 'transparent',
						borderColor: 'rgba(54, 162, 235, 1)',
						borderWidth: 2
					}]
				},
				options: {
			        responsive: true, // 반응형 차트 설정
			        maintainAspectRatio: false, // 가로세로 비율 고정 해제						
					plugins: {
			            legend: {
			                labels: {
			                    usePointStyle: true, // 범례를 점 모양으로
			                    pointStyle: 'line'  // 범례를 직선으로 설정
			                }
			            },						
						subtitle: { // 차트 제목
							display: true,
							text: '전체 가입자 통계' 
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
							max : 18000,
							ticks: {
								color: 'rgba(75, 192, 192, 1)',
								stepSize: 1000
							}
							
						}
					}
				}
			});			
			
		}).fail(function(){
			
		})
	});
});
</script>
</body>
</html>