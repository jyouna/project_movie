$(function() {
	// 투표등록버튼 클릭시 투표등록 모달창 출력
	$("#registPickBtn").click(function() {
		if($(".pickMovie").length < 5) {
			alert("투표등록을 위해선 현재 투표영화가 5개 여야합니다.\n영화목록에서 투표영화를 추가등록해주세요\n(현재 투표영화 : " + $(".pickMovie").length + "개)")
			location.reload(true);
		}
		$(".modal").css("display", "block");
	});
	
	// 모달창의 닫기버튼 클릭시 모달창 닫기
	$(".close_modal").click(function() {
		location.reload(true);
	});
	
	// 투표삭제 버튼 클릭시 해당 투표정보 삭제
	// 단, 투표상태가 비활성화이고 투표한 내역이 없을때만 삭제가능
	// (= 투표를 잘못등록했을때 삭제, 회원이 투표한 경우 삭제 불가)
	// jsp에서 위에 조건 불만족시 버튼 비활성화
	$("#deletePickBtn").click(function() {
		if($("#voteCode").val() == null) {
			alert("삭제할 투표 정보가 없습니다");
		} else {
			if(confirm("투표 삭제 하시겠습니까?")) {
				location.href = "DeleteVoteInfo?vote_code=" + $("#voteCode").val();
			}
		}
	});
	
	// 상단의 설렉트박스 투표목록선택시 해당 투표 정보 출력
	$("#btnGroup01 select").change(function() {
		location.href = "AdminMoviePickSet?vote_code=" + $(this).val();
	});
	
	// 투표영화목록 체크박스 클릭시 모든 체크박스 클릭, 해제
	$("#allCheck").click(function() {
		if($(this).prop("checked")) {
			$(".check").prop("checked", true);
		} else {
			$(".check").prop("checked", false);
		}
	});
	
	// 투표영화에서 삭제 버튼 클릭시 movie_status를 '대기'로 변경
	$("#removeFromPickBtn").click(function() {
		let checkMovieCodeStr = getCheckedMovieCode();
		// 영화 선택여부 판별
		if(checkMovieCodeStr == "") {
			alert("영화를 선택해 주세요");
		} else if($("#isActivation").val() == "1") {
			alert("활성화된 투표의 투표영화는 삭제할 수 없습니다");
		} else {
			location.href = "RemoveMovieFromPick?movieCodeStr=" + checkMovieCodeStr;
		}
	});
	
	// 투표시작 버튼 클릭시 투표 활성화
	$("#startVoteBtn").click(function() {
		if($("#voteCode").val() == null) {
			alert("투표정보가 없습니다(투표시작 불가)");	
		} else if($("#isActivation").val() == 1) {
			alert("이미 활성화 상태입니다");
		} else {
			if(confirm("투표활성화 하시겠습니까?")) {
				location.href = "StartVoteForThisSeason?vote_code=" + $("#voteCode").val();
			}
		}
	});
	
	// 투표현황 조회하기 버튼 클릭시 새로고침 진행
	$("#searchVoteCurrentInfoBtn").click(function() {
		location.reload(true);
	});
	
	// 투표종료 버튼 클릭시 투표 비활성화
	$("#endVoteBtn").click(function() {
		if($("#voteCode").val() == null) {
			alert("투표정보가 없습니다");	
		} else if($("#isActivation").val() == 0) {
			alert("이미 비활성화 상태입니다.");
		} else {
			if(confirm("투표비활성화 하시겠습니까?")) {
				location.href = "EndVoteForThisSeason?vote_code=" + $("#voteCode").val();
			}
		}
	});
	
	// 투표결과적용 버튼 클릭시 해당영화 상영예정작의 season 무비로 등록
	$("#registUpcomingBtn").click(function() {
		if($("#isActivation").val() == "1") {
			alert("투표결과적용을 위해선 투표를 종료하여 주세요");			
		} else if(confirm("투표결과를 적용 하시겠습니까?\n1등, 2등, 3등 영화가 시즌 상영예정작으로 등록됩니다")) {
			location.href = "RegistUpcomingSeasonMovie?vote_code=" + $("#voteCode").val();
		}
	});
	
	// 투표현황 차트
	let ctx = $('#voteCurrentChart')[0].getContext('2d');
	let voteCurrentChart = new Chart(ctx, {
	    type: 'doughnut',
	    data: {
	        labels: [$(".movieName").eq(0).text(), $(".movieName").eq(1).text(), $(".movieName").eq(2).text(), $(".movieName").eq(3).text(), $(".movieName").eq(4).text()],
	        datasets: [{
	            label: '백분율',
	            data: [$(".voteRatio").eq(0).text(), $(".voteRatio").eq(1).text(), $(".voteRatio").eq(2).text(), $(".voteRatio").eq(3).text(), $(".voteRatio").eq(4).text()],
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)'
	            ],
	            borderColor: [
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	        responsive: true,
			maintainAspectRatio: false,
	        plugins: {
	            legend: {
	                display: false
	            },
	            tooltip: {
	                enabled: false
	            }
	        }
	    },
	    plugins: [
	        {
	            id: 'doughnutLabels',
	            afterDraw(chart, args, options) {
	                const {ctx, data} = chart;
	
	                chart.getDatasetMeta(0).data.forEach((dataPoint, index) => {
	                    const {x, y} = dataPoint.tooltipPosition();
	                    const movieName = data.labels[index];
	                    const ratio = data.datasets[0].data[index];
	
	                    ctx.save();
	                    ctx.font = 'bold 12px Arial';
	                    ctx.fillStyle = 'black';
	                    ctx.textAlign = 'center';
	                    ctx.textBaseline = 'middle';
	
	                    // 영화 이름
	                    ctx.fillText(movieName, x, y - 5);
	
	                    // 비율 값
	                    ctx.font = '12px Arial';
	                    ctx.fillText(`${ratio}%`, x, y + 10);
	                    ctx.restore();
	                });
	            }
	        },
	        {
	            id: 'centerTitle',
	            afterDraw(chart, args, options) {
	                const {ctx, chartArea: {width, height}} = chart;
	
	                ctx.save();
	                ctx.font = 'bold 16px Arial';
	                ctx.fillStyle = 'black';
	                ctx.textAlign = 'center';
	                ctx.textBaseline = 'middle';
	
	                const centerX = width / 2;
	                const centerY = height / 2;
	
	                // 중앙에 제목 표시
	                ctx.fillText('투표 현황', centerX, centerY);
	                ctx.restore();
	            }
	        }
	    ]
	});


	// 체크된 영화의 코드들을 변수에 초기화하는 메서드
	function getCheckedMovieCode() {
		let checkMovieCodeStr = "";
		$(".check:checked").each(function() {
			checkMovieCodeStr += $(this).val() + " ";
		})
		return checkMovieCodeStr;
	}
	
	
});