$(function() {
	
	// 페이지 로드됐을 때 상영시간 안보이게 처리하고
	// "날짜를 선택해주세요" 출력
	$(".movie_schedule_info h4").css("display", "flex");
	$(".movie_schedule_info :not(h4)").css("display", "none");
	
	
	
	
	let isDateSelected = false;
	$(".mv_list").click(function() {

		if(!isDateSelected) {
			alert("날짜를 먼저 선택해주세요");
			$(".mv_list").removeClass("selected");
			return;
		}
		
		$(".mv_list").removeClass("selected");
		$(this).addClass("selected");
		
		let selectedMovie = $(this).text().trim();
	    console.log("선택된 영화 : " + selectedMovie);

//		$.ajax({
//			type : "POST",
//			url : "BookTickets",
//			data : {
//				movie_name : selectedMovie
//			},
//			dataType : "JSON"
//		}).done(function(scheduleList) {
//			console.log("ajax 성공");
//			$(".movie_schedule_info").empty();
//			
//			for(let schedule of scheduleList) {
//				let ageLimit = schedule.age_limit;
//				let img = new Image();
//				if(ageLimit == "12세이상관람가") {
//					img.src = `${pageContext.request.contextPath}/resources/images/mv_age(12).png`;
//				} else if(ageLimit == "15세이상관람가") {
//					img.src = `${pageContext.request.contextPath}/resources/images/mv_age(15).png`;
//				} else if(ageLimit == "청소년관람불가") {
//					img.src = `${pageContext.request.contextPath}/resources/images/mv_age(19).png`;
//				} else {
//					img.src = `${pageContext.request.contextPath}/resources/images/mv_age(all).png`;
//				}
//			}
//			
//			
//			for(let schedule of scheduleList) {
//				let hallName = schedule.theater_code;
//				if(hallName == "T1") {
//					hallName = "1관";
//				} else if(hallName == "T2") {
//					hallName = "2관";
//				} else {
//					hallName = "3관";
//				}
//			}
//			
//		}).fail(function() {
//			$(".movie_schedule_info").text("실패");
//		});




	});
	
	
	// 날짜 선택 시 ajax로 해당 날짜 시간표 출력
	$(".date_item").click(function() {
		
		isDateSelected = true;
		
		// 다시 상영시간 보이게 처리	
		$(".movie_schedule_info :not(h4)").css("display", "flex");
		$(".movie_schedule_info h4").css("display", "none");
		
	
		let selectedDate = $(this).data("date");
	    console.log("선택된 날짜 : " + selectedDate);

		$.ajax({
			type : "post",
			url : "BookTickets",
			data : {
				start_time : selectedDate
			},
			dataType : "JSON"
		}).done(function(scheduleList) {
			$(".time_seat_container").empty();
			
			for(let schedule of scheduleList) {
				let hallName = schedule.theater_code;
				if(hallName == "T1") {
					hallName = "1관";
				} else if(hallName == "T2") {
					hallName = "2관";
				} else {
					hallName = "3관";
				}

				// 시간 버튼 출력
				$("#" + schedule.movie_code).append(`
				    <a class="time_seat_btn">
				        <input type="hidden" value="${schedule.movie_code}">
				        <span class="mv_time">${schedule.start_time}</span>
				        <span class="details">
				            <span class="seat">70/${schedule.avail_seat}</span>
				            <span class="hall">${hallName}</span>
				        </span>
				    </a>
				`);
			}
			
			let schCode = "";
			$(".time_seat_btn").click(function() {
				schCode = $(this).find("input[type='hidden']").val();
				console.log(schCode);
				
				if(confirm("좌석을 선택하시겠습니까?")) {
					location.href = "BookSeat?schCode=" + schCode;
				}
			});
			
		}).fail(function() {
			$(".movie_schedule_info").html(
				"<h3>페이지를 로드할 수 없습니다. 관리자에게 문의 바랍니다.</h3>"
			);
		});
	});
	
	
	
	
	// ===============================================
//	function loadSchedule(start_time, movie_name = "") {
//		$.ajax({
//			type : "POST",
//			url : "BookTickets",
//			data : {
//				start_time : start_time,
//				movie_name : movie_name
//			},
//			dateType : "JSON"
//		}).done(function(scheduleList) {
//			$(".movie_schedule_info").empty();
//			
//			for(let schedule of scheduleList) {
//				let ageLimit = schedule.age_limit;
//				let img = "";
//				if(ageLimit == "12세이상관람가") {
//					img = `<img src="${contextPath}/resources/images/mv_age(12).png">`;
//				} else if(ageLimit == "15세이상관람가") {
//					img = `<img src="${contextPath}/resources/images/mv_age(15).png">`;
//				} else if(ageLimit == "청소년관람불가") {
//					img = `<img src="${contextPath}/resources/images/mv_age(19).png">`;
//				} else {
//					img = `<img src="${contextPath}/resources/images/mv_age(all).png">`;
//				}
//				
//				$(".mv_container").append(`
//					<div class="mv_age">
//						$(".mv_age").append(img);
//						
//					</div>
//				`);
//				
//				$(".mv_title").append(schedule.movie_name);
//			}
//			
//			
//			for(let schedule of scheduleList) {
//				let hallName = schedule.theater_code;
//				if(hallName == "T1") {
//					hallName = "1관";
//				} else if(hallName == "T2") {
//					hallName = "2관";
//				} else {
//					hallName = "3관";
//				}
//				
//				// 시간 버튼 출력
//				$("#" + schedule.movie_code).append(`
//				    <a class="time_seat_btn">
//				        <input type="hidden" value="${schedule.movie_code}">
//				        <span class="mv_time">${schedule.start_time}</span>
//				        <span class="details">
//				            <span class="seat">70/${schedule.avail_seat}</span>
//				            <span class="hall">${hallName}</span>
//				        </span>
//				    </a>
//				`);
//			}
//			
//			let schCode = "";
//			$(".time_seat_btn").click(function() {
//				schCode = $(this).find("input[type='hidden']").val();
//				console.log(schCode);
//				
//				if(confirm("좌석을 선택하시겠습니까?")) {
//					location.href = "BookSeat?schCode=" + schCode;
//				}
//			});
//			
//		}).fail(function() {
//			if(start_time == "") {
//				$(".movie_schedule_info").html(
//            		"<h3>페이지를 로드할 수 없습니다. 관리자에게 문의 바랍니다.</h3>"
//        		);
//			}
//		});
//	}
	
	
	
	
	
	
	
	
	
	
});







