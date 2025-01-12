$(function() {
	// 선택 날짜 변수저장, 스케줄 등록 폼에 입력
	let scheduleDate = $("#btnGroup01 input[type=date]").val();
	// 선택 상영관 변수저장, 스케줄 등록폼에 입력
	let selectTheater = $("#btnGroup01>select").val();
	$("input[name=theater_code]").val(selectTheater);
	// 상영예정작의 상영기간과 비교해서 스케줄 등록가능일을 판별하기 위해 변수선언
	let startScreeningDate = "";
	let endScreeningDate = "";
	 
	// 상단의 상영관선택 및 날짜 선택시 해당 상영관 및 해당 날짜의 상세페이지로 이동
	$(".changeScheduleTable").change(function() {
		location.href = "AdminMovieSetScheduleDetail?theater_code=" + $("#btnGroup01>select").val()
		+ "&select_date=" + $("#btnGroup01 input[type=date]").val();
	});
	
	// 스케줄 등록이가능한 현재상영작, 상영예정작 조회후 스케줄 등록 모달 폼의
	// 영화선택 설렉트박스에 리스트 추가
	$.ajax({
		type : "GET",
		url : "AdminMovieSetSearch",
		data : {
			columnName : "movie_status",
			in1 : "현재상영작",
			in2 : "상영예정작",
			olderColumn : "movie_status",
			howOlder : "DESC",
			olderColumn2 : "movie_type",
			howOlder2 : "ASC",
		}
	}).done(function(movieList) {
		// 현재상영작 스케줄 등록 폼의 영화선택 설렉트박스에 추가
		for(let index = 0; index <= 8; index++) {
			$("optgroup[label='현재상영작']").append(
				"<option value='" + movieList[index].movie_code + "'>" + movieList[index].movie_name + "</option>"
			);
		}
		
		// 상영예정작의 영화상영기간 미설정 여부 판단, 영화상영기간 설정이 완료된 후에 상영스케줄 설정 가능
		// 아래에 selectbox 핸들러에 change이벤트시 경고창 및 영화상영기간 설정창으로 이동 작업예정
		for(let index = 9; index <= movieList.length; index++) {
			if(movieList[index].start_screening_date == null || movieList[index].end_screening_date == null) {
				$("optgroup[label='상영예정작']").append(
					"<option value='noPeriod'>" + movieList[index].movie_name + "</option>"
				);
			} else {
				$("optgroup[label='상영예정작']").append(
					"<option value='" + movieList[index].movie_code + "'>" + movieList[index].movie_name + "</option>"
				);
			}
		}
		
	});
	
	// 스케줄 등록 모달 오픈
	$("#regist_schedule_btn").click(function() {
		$("#schedule_regist_modal").css("display", "block");
	});
	
    // 스케줄 등록 모달 닫기
	$(".close_modal").click(function() {
		location.reload();
	});
	
    // 영화선택 설렉트박스 change 이벤트시 해당영화정보 스케줄 등록 폼에 입력
	$("select[name='selected_movie']").change(function () {
		// 상영기간 미설정 영화 선택시 상영기간 설정 필수 알람창 노출
		if($("select[name='selected_movie']").val() == "noPeriod") {
			alert("영화 상영기간이 설정되지 않았습니다\n 상영기간 설정화면으로 이동합니다");
			location.href="AdminMovieSetUpcoming";
		}
		
		let movie_code = $("select[name='selected_movie']").val();
		
		$.ajax({
			type : "GET",
			url : "SelectMovieInfo",
			data : {
				movie_code : movie_code
			}
		}).done(function(movie) {
			$("input[name='movie_code']").val(movie.movie_code);
			$("input[name='movie_name']").val(movie.movie_name);
			$("input[name='running_time']").val(movie.running_time);
			
			// 스케줄등록 날짜가 선택영화의 상영기간안에 있는지 판별
			startScreeningDate = movie.start_screening_date;
			endScreeningDate = movie.end_screening_date;
			
			if(!isDateBetween(startScreeningDate, scheduleDate, endScreeningDate)) {
				alert("해당영화는 현재날짜에 스케줄을 등록할 수 없습니다\n영화의 상영기간을 확인해주세요");
				$("input[type=reset]").trigger("click");
			}
		}).fail(function(){
			alert("영화정보 불러오기 실패하였습니다");
		});
		
		
	});
	
	// 시작시간이 입력되었을때 러닝타임과 계산하여 끝시간 입력
	$("input[name='s_time']").change(function() {
		if($("select[name='selected_movie']").val() == "") {
			alert("영화를 선택해 주세요\n(종료시간 및 스케줄 등록 가능여부 판별 위해 러닝타임 필요)");
			$(this).val("");
		} else {
			let runningTime = $("input[name=running_time]").val();
			let startDateTime = scheduleDate + " " + $(this).val();
			
			$(this).val()
			
			$("input[name='str_start_time']").val(startDateTime);
			
			//String 타입을 날짜시간 계산을위해 Date 타입으로 변환
			let startDateTime2 = new Date(startDateTime);
			// 시작 시간을 기준으로 영화타입 "조조", "일반", "심야" 판별 후 폼요소에 입력
			// 아래에 상영시간을 더하는 코드보다 위에 위치 해야 시작시간을 가지고 판별 가능
			let showtimeType = "";
			if(startDateTime2.getHours() < 10) {
				showtimeType = "조조"
			} else if(startDateTime2.getHours() >= 22) {
				showtimeType = "심야"
			} else {
				showtimeType = "일반"
			}
			
			// 상영시간대타입 폼요소에 입력
			$("input[name='showtime_type']").val(showtimeType);
			
			// 변환된 Date에 러닝타임 더하기 계산
			startDateTime2.setMinutes(startDateTime2.getMinutes() + Number(runningTime));
			// yyyy-MM-dd HH:mm 형태로 포맷
			formatEndDateTime = dateFormatter(startDateTime2);
			
			// 영화 끝 시간에 청소시간을 계산하여 다음 스케줄 가능시간 계산후 포맷
			startDateTime2.setMinutes(startDateTime2.getMinutes() + 30);
			formatNextScheduleTime = dateFormatter(startDateTime2);
			
			// 변환 된 날짜 시간을 폼요소에 입력
			$("input[name='str_end_time']").val(formatEndDateTime);
			$("input[name='str_next_schedule']").val(formatNextScheduleTime);
			// 계산된 시간을 보여주기위해 상영종료 시간 input type="time"에 입력
			endTime = formatEndDateTime.split(" ")[1];
			$("input[name='e_time']").val(endTime);
			
			$.ajax({
				type : "GET",
				url : "GetScheduleInfo",
				data : {
					select_date : scheduleDate,
					theater_code : selectTheater
				},
				dataType : "json"
			}).done(function(dbScheduleList) {
				// 중복판별을 위한 변수
				let isDuplication = false;
				
				for(let dbSchedule of dbScheduleList) {
					// 등록할 스케줄의 시작, 끝(상영후 다음스케줄 가능)시간, 스케줄 시작과 끝의 중간시간
					let start = new Date(startDateTime).getTime();
					let end = new Date(formatNextScheduleTime).getTime();
					let average = (start + end) / 2;
					// DB의 스케줄의 시작, 끝(상영후 다음스케줄 가능)시간,
					let dbStart = dbSchedule.start_time;
					let dbEnd = dbSchedule.next_schedule;
					
					// 새로등록할 스케줄의 1)시작시간이 DB스케줄의 시작 끝 시간 사이에 없고,
					// 2)끝시간이 DB스케줄의 시작 끝 시간 사이에 없으면 겹치지않음
					// 단, 이때 DB스케줄의 시작시간보다 새로등록할 스케줄의 시작시간이 조금 빠르고
					// 러닝타임이 DB스케줄의 러닝타임보다 월등히 길때 새로등록할 스케줄의 끝시간이 DB스케줄의
					// 끝시간을 넘어가서 위에 조건에 충족하지만 스케줄이 겹치게됨
					// 따라서 위에 조건에 더해서 새로등록할 스케줄의 3)중간시간도 DB스케줄의 시간안에 포함되지 않는지도 판별해야됨
					// 위의 조건을 DB스케줄 각각 1), 2), 3) 다 비교하여 그중 하나라도 만족하지 않으면 스케줄 등록불가
					
					// 등록시작,등록끝,등록중간 시간이 하나라도 db스케줄의 시작과 끝의 사이에 있으면 
					// 중복, 등록불가
					if(	(start >= dbStart && start <= dbEnd) // 1)
						|| (end >= dbStart && end <= dbEnd) // 2)
						|| (average >= dbStart && average <= dbEnd) ) {  // 3)
						isDuplication = true;
						break;
					} 
				}
				
				if(!isDuplication) {
					$("#isRegistPossible").text("등록가능합니다.")
					$("#isRegistPossible").css("color", "#ADD826")
					$(".form_btnGroup input[type=submit]").prop("disabled", false);
				} else {
					$("#isRegistPossible").html("- 등록불가 -<br>이미 등록된 스케줄과 겹칩니다.<br> 시간을 확인해주세요");
					$("#isRegistPossible").css("color", "#FF86C1")
					$(".form_btnGroup input[type=submit]").prop("disabled", true);
				}
			}).fail(function() {
				alert("스케줄 등록에 실패했습니다.")
			});
		}
	});
	
	// 날짜 변환 메서드
	function dateFormatter(startDateTime2) {
		formatYear = startDateTime2.getFullYear();
		formatMonth = startDateTime2.getMonth() + 1 < 10 ? '0' + (startDateTime2.getMonth() + 1) : startDateTime2.getMonth() + 1;
		formatDate = startDateTime2.getDate() < 10 ? '0' + startDateTime2.getDate() : startDateTime2.getDate()
		formatHour = startDateTime2.getHours() < 10 ? '0' + startDateTime2.getHours() : startDateTime2.getHours()
		formatMinute = startDateTime2.getMinutes() < 10 ? '0' + startDateTime2.getMinutes() : startDateTime2.getMinutes()
		return `${formatYear}-${formatMonth}-${formatDate} ${formatHour}:${formatMinute}`;
	}
	
	// 날짜 비교 메서드
	// 파라미터1 <= 파라미터2 <= 파라미터3 이면 true 리턴
	// 현재 스케줄 등록날짜가 해당 영화의 상영기간안에 들어가는 영화인지 판별
	function isDateBetween(startScreeningDate, scheduleDate,  endScreeningDate) {
		let isBetween = false;
		
		start = new Date(startScreeningDate);
		schedule = new Date(scheduleDate);
		end = new Date(endScreeningDate);
		
		if(start <= schedule && schedule <= end) {
			isBetween = true;
		} 
		return isBetween;
	}
	
}); // document ready 끝
	
