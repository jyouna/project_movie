$(function() {
	let selectedDate = "";
	let selectedMovie = "";
	// 페이지 로드됐을 때 상영시간 안보이게 처리하고
	// "날짜를 선택해주세요" 출력
	let isDateSelected = false;
	
	$(".mv_list").click(function() {
		if(!isDateSelected) {
			alert("날짜를 먼저 선택해주세요");
			$(".mv_list").removeClass("selected");
			return;
		}
		
		// 영화선택시 해당영화코드 변수에 초기화
		$(".mv_list").removeClass("selected");
		$(this).addClass("selected");
		selectedMovie = $(this).find("input[type='text']").val();
		
	    console.log("선택된 영화코드 : " + selectedMovie);
		// 스케줄 조회 메서드 호출
		loadSchedule(selectedDate, selectedMovie);
	});
	
	
	// 날짜 선택 시 ajax로 해당 날짜 시간표 출력
	$(".date_item").click(function() {
		$(".sec01").css("display", "flex");
		isDateSelected = true;
		selectedDate = $(this).data("date");
	    console.log("선택된 날짜 : " + selectedDate);
		
		// 스케줄 조회 메서드
		loadSchedule(selectedDate, "");
	});
	
	
	// 예매 날짜 영화 선택시 스케줄 표시 메서드
	function loadSchedule(selectedDate, selectedMovie) {
		
		// 날짜 및 영화 선택시 조건에 해당하는 영화만 연령등급 영화명 표시
		$.ajax({
			type : "GET",
			url : "GetMovieListScheduleToBooking",
			data : {
				start_time : selectedDate,
				movie_code : selectedMovie
			}
		}).done(function(movieList) {
			$(".movie_schedule_info").empty();
			
			for(let movie of movieList) {
				let ageLimit = movie.age_limit;
				let img = "";
				if(ageLimit == "12세이상관람가") {
					img = `<img src="${contextPath}/resources/images/mv_age(12).png">`;
				} else if(ageLimit == "15세이상관람가") {
					img = `<img src="${contextPath}/resources/images/mv_age(15).png">`;
				} else if(ageLimit == "청소년관람불가") {
					img = `<img src="${contextPath}/resources/images/mv_age(19).png">`;
				} else {
					img = `<img src="${contextPath}/resources/images/mv_age(all).png">`;
				}
				
				$(".movie_schedule_info").append(`
					<section class="sec01" id='${movie.movie_name}'">
					    <div class="movie_container">
					        <div class="mv_age">
						       ${img}
							</div>
					        <div class="mv_title">${movie.movie_name}</div>
					    </div>
					    <div class="time_seat_container" id="${movie.movie_code}">
					    </div>
					</section>
				`);
			}
				
			
			// 날짜 및 영화 선택시 조건에 해당하는 스케줄 해당영화 섹션에 표시
			$.ajax({
				type : "GET",
				url : "GetScheduleListToBooking",
				data : {
					start_time : selectedDate,
					movie_code : selectedMovie
				}
			}).done(function(scheduleList) {
				console.log(scheduleList.length);
				if(scheduleList.length != 0) {
					
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
						        <span class="mv_time">${schedule.str_start_time}</span>
						        <span class="details">
						            <span class="seat">70/${schedule.avail_seat}</span>
						            <span class="hall">${hallName}</span>
						        </span>
						    </a>
						`);
					}
					
				} else if(true) {
					$(".movie_schedule_info").empty();
					$(".movie_schedule_info").append(`
						해당 영화의 스케줄이 존재하지 않습니다
					`);
				}
				$(".time_seat_btn").click(function() {
					schCode = $(this).find("input[type='hidden']").val();
					console.log(schCode);
					
					if(confirm("좌석을 선택하시겠습니까?")) {
						location.href = "BookSeat?schCode=" + schCode;
					}
				});
			}).fail(function() {
					alert("스케줄 조회 실패하였습니다.")
			});

		}).fail(function() {
			alert("영화정보 조회 실패했습니다.")
		});
	}
	
	
	
	

});







