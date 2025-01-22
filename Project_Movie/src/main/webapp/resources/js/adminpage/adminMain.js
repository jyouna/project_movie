$(function(){
	let myChart;
	let myChart2;
	let date = new Date();
	let year = date.getFullYear()-1;
	let month = date.getMonth();
	$("#showPeriod").text(" : " + year).css("color", "black");

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
			
			$("#showPeriod").text(year + "년 신규 가입자 : " + yearTotal.toLocaleString('ko-KR') + "명").css("font-size", "16px");;
 			
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
			        responsive: true, // 반응형 차트 설정
			        maintainAspectRatio: false, // 가로세로 비율 고정 해제	
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
	
	$("#showPeriod2").text(" : " + year).css("color", "black");
	$.ajax({
		url: "GetYearSales",
		type: "get",
		data : {
			year : year,
		},
		dataType: "json",
		success: function(response){
  			if(myChart2){myChart2.destroy();} // 차트가 존재하면 먼저 지우고 새 차트를 생성
			
  			const monthOrder = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
 			const data = monthOrder.map(month => response[month] || 0); // 월 순서에 맞게 배열로 변환 (값이 없으면 0)
			const ctx = document.getElementsByClassName('myChart2')[0].getContext('2d');
			
			let yearTotal = 0;
			for(let i = 0; i < monthOrder.length; i++) {
				yearTotal += data[i];
			}
			console.log(yearTotal);
			
			$("#showPeriod2").text(year + "년 매출액 : " + yearTotal.toLocaleString('ko-KR') + "원").css("font-size", "16px");
 			
 			myChart = new Chart(ctx, {
				type: "bar",
				data: {
					labels : monthOrder, // 축
					datasets: [{ // 각 축에 들어갈 값 설정
						label: year + "년 매출액", // 값 이름
						data: data, // 값
						backgroundColor: 'rgba(255, 99, 132, 0.2)',
						borderColor: 'rgba(54, 162, 235, 1)',
						borderWidth: 1
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
							max : 25000000,
							ticks: {
								color: 'rgba(75, 192, 192, 1)',
								stepSize: 2500000
							}
						}
					}
				}
			});
		}
	});
})