$(function() {
	// 현재 진행중인 투표의 투표코드
	let vote_code = $("#voteCode").val();
	
	// 페이지 로드시 투표현황 차트 출력
	$.ajax({
		type : "get",
		url : "GetVoteStatusInfo",
		data : {
			vote_code
		}
	}).done(function(voteCurrentInfoList) {
		let totalCount = 0;
		let totalMovieName = [];
		let totalRatioStr = [];
		for(let voteCurrentInfo of voteCurrentInfoList) {
			// 총 투표수 계산
			totalCount += voteCurrentInfo.count;
			// 차트에 넣을 영화이름 배열
			totalMovieName.push(voteCurrentInfo.movie_name);
		}
		
		// 차트에 넣을 백분율 계산
		for(let voteCurrentInfo of voteCurrentInfoList) {
				totalRatioStr.push((voteCurrentInfo.count / totalCount * 100).toFixed(1))
		}
		
		// 투표현황 차트
        let ctx = $('#voteCurrentChart')[0].getContext('2d');
        let voteCurrentChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: totalMovieName,
                datasets: [{
                    label: '백분율',
                    data: totalRatioStr,
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

                            ctx.fillText(movieName, x, y - 5);

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

                        ctx.fillText('투표 현황', centerX, centerY);
                        ctx.restore();
                    }
                }
            ]
        });
	}).fail(function() {
		alert("투표현황 불러오기 실패하였습니다");
	});
	
	// 투표하기 버튼 클릭시 투표 정보 insert
	$(".joinVoteBtn").click(function() {
		// 로그인된 id
		let id = $("#loginId").val();
		
		// 로그인 유무 판별
		if(id == "") {
			if(confirm("로그인 후 투표 가능합니다\n로그인창으로 이동하시겠습니까?")) {
				location.href = "MemberLogin";
			}
		} else {
			let movie_name = $(this).siblings("label").text();
			let movie_code = $(this).siblings("input[type='hidden']").val();
			if(confirm("<" + movie_name + ">에 투표 하시겠습니까?")) {
				location.href = "JoinMovieVote?vote_code=" + vote_code + "&movie_code=" + movie_code + "&member_id=" + id;
			}
		}
		
	});
});