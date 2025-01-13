$(function(){
	let myChart;
	
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
					const ctx = document.getElementById('myChart').getContext('2d');
					
					if(myChart){myChart.destroy();}
					
					myChart = new Chart(ctx, {
						type: "bar",
						data: {
							labels : [yearAndMonth], // 축
							datasets: [{ // 각 축에 들어갈 값 설정
								label: "가입자 수", // 값 이름
								data: [response], // 값
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
					
					if(myChart){myChart.destroy();}
					
					myChart = new Chart(ctx, {
						type: "bar",
						data: {
							labels : monthOrder, // 축
							datasets: [{ // 각 축에 들어갈 값 설정
								label: "가입자 수", // 값 이름
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