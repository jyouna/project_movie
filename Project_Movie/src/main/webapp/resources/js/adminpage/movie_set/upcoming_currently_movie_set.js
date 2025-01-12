$(function() {
	// 테이블의 값을 저장하기위한변수
	let movie_code = "";
	let movie_name = "";
	let screening_date = "";
	let start_screening_date = "";
	let end_screening_date = "";
	let movie_type = "";
	
	// 테이블 행 클릭시 해당행 라디오버튼 클릭 및 변수에 값 저장
	$("table").on("click", "tr", function() {
		$(this).find("input[type='radio']").prop("checked", true);
		movie_code = $(this).find("td:eq(0)").text();
		movie_name = $(this).find("td:eq(1)").text();
		screening_date = $(this).find("td:eq(2)").text();
		movie_type = $(this).find("td:eq(5)").text();
		
		// 상영기간 설정이 되어있는지 판별 후 변수에 저장
		if(screening_date != "상영예정기간을 입력해주세요.") {
			screening_date_Arr = screening_date.split(" ~ ");
			start_screening_date = screening_date_Arr[0];
			end_screening_date = screening_date_Arr[1];
		// 테이블의 행 선택후 다른행 선택시 상영예정기간이 입력안되어있으면 기존행의
		// 상영시작날짜와 상영끝날짜가 변수에 초기화되어있음, 이를 해결하기 위해 ""으로 초기화
		} else {
			start_screening_date = ""
			end_screening_date = ""
		}
	});
	
    // 상영기간설정 모달 오픈
    $("#set_date_btn").on("click", function() {
		if(movie_code == "") {
			alert("영화를 선택해 주세요");
		} else if(screening_date != "상영예정기간을 입력해주세요.") {
			if(confirm("상영예정기간을 이미 입력하셨습니다\n상영기간을 변경 하시겠습니까?")) {
		        $("#screening_date_modal").css("display", "block");
				$(".modal_content").prepend("<h4><" + movie_name + "></h4>")
			}		
		} else {
	        $("#screening_date_modal").css("display", "block");
			$(".modal_content").prepend("<h4><" + movie_name + "></h4>")
		}
    });

    // 모든 모달 닫기
    $(".close_modal").on("click", function() {
		location.reload();
    });

	// 상영끝날짜 선택시 상영시작날짜와 비교하여 시작날짜보다 뒤에 날짜가 아니면 얼럿창 출력
	$(".end_date").change(function() {
		if($(".start_date").val() > $(this).val()) {
			alert("선택하신 날짜는 시작날 이전의 날짜입니다.\n다시 입력해주세요");
			$(this).val("");
		}
	});
	
	// 상영기간설정 입력 버튼 클릭시 해당 기간으로 영화db정보 업데이트
	// 및 모달창닫고 reload
	$("#set_btn").click(function() {
		// 영화선택 여부 판별
		if(!isClicked()) {
			return;
		}
		
		// ajax를 통해 movie테이블의 상영시작일, 상영종료일 업데이트
		$.ajax({
			type : "post",
			url : "UpdateScreeningDate",
			data : {
				movie_code : movie_code,
				start_screening_date : $(".start_date").val(),
				end_screening_date : $(".end_date").val()
			}
		}).done(function(result) {
			$("#screening_date_modal").css("display", "none");
			location.reload();
			alert(result.msg);
		}).fail(function() {
			alert("상영일자설정 실패")
		});

	});
	
	// 영화정보 버튼 클릭시 ajax를 통해 DB영화정보 모달창에 출력
	$("#btnGroup02 input[type=button]").click(function() {
		
		if(!isClicked()) {
			return;
		}
		
		$("#movie_info_modal").css("display", "block");
		
		$.ajax({
			type : "GET",
			url : "SelectMovieInfo",
			data : {
				movie_code : movie_code
			}
		}).done(function(movie) {
			$("input[name='movie_code']").val(movie.movie_code);
			$("input[name='movie_name']").val(movie.movie_name);
			$("input[name='movie_genre']").val(movie.movie_genre);
			$("input[name='movie_director']").val(movie.movie_director);
			$("input[name='movie_actor']").val(movie.movie_actor);
			$("input[name='release_date']").val(movie.str_release_date);
			$("input[name='running_time']").val(movie.running_time);
			$("input[name='age_limit']").val(movie.age_limit);
			$("input[name='movie_rating']").val(movie.movie_rating);
			$("textarea[name='movie_synopsis']").val(movie.movie_synopsis);
			$("input[name='movie_img1']").val(movie.movie_img1);
			$("input[name='movie_img2']").val(movie.movie_img2);
			$("input[name='movie_img3']").val(movie.movie_img3);
			$("input[name='movie_img4']").val(movie.movie_img4);
			$("input[name='movie_img5']").val(movie.movie_img5);
			$("input[name='movie_trailer']").val(movie.movie_trailer);
			$("select[name='movie_status']").val(movie.movie_status);
		}).fail(function() {
			alert("영화정보를 가져오는데 실패하였습니다.");
		});
		
	});
	
	$("#remove_from_upcoming_btn").click(function() {
		
	});
	
	// 상영스케줄 설정버튼 클릭시 해당영화의 상영시작날짜의 1관 스케줄 상세 페이지로 포워딩
	$("#to_schedule_regist").click(function() {
		// 영화 선택여부 판별
		if(!isClicked()) {return};
		// 영화 상영기간 설정 여부 판별
		if(start_screening_date == "" || end_screening_date == "") {
			alert("상영기간을 설정해 주세요");
		} else {
			location.href = "AdminMovieSetScheduleDetail?theater_code=T1&select_date=" + start_screening_date;
		}
	});
	
	// 현재상영작으로 등록 버튼 클릭시 영화 상태 변경
	$("#to_currently_movie").click(function() {
		// 영화 선택 여부 판별
		if(!isClicked()) {
			return;
		}
		
		if(confirm("<" + movie_name + ">을 현재상영작으로 등록 하시겠습니까?")){
			// 현재상영작 등록 가능 여부 판별
			$.ajax({
				type : "GET",
				url : "IsExistSchedule",
				data : {
					movie_code : movie_code	
				},
				dataType : "json"
			}).done(function(result) {
				// 스케줄 존재시 현재상영작으로 등록가능
				if(result) {
					$.ajax({
						type : "POST",
						url : "UpdateMovieStatusToCurrently",
						data : {
							movie_code : movie_code,
							movie_status : "현재상영작",
							movie_type : movie_type
						},
					}).done(function(result) {
						alert(result.msg);
						location.reload();
					}).fail(function() {
						alert("현재상영작으로 등록 실패");
					});
				} else {
					alert("해당영화는 현재상영작으로 등록할 수 없습니다\n(해당 영화로 등록된 스케줄이 없습니다."
						+ " 스케줄을 등록해 주세요)");
				}
			}).fail(function() {
				alert("현재상영작으로 등록 실패");
			});
		}
	});
	
	// 지난상영작으로 등록 버튼 클릭시 영화 상태 변경
	$("#to_past_movie").click(function() {
		// 영화 선택 여부 판별
		if(!isClicked()) {
			return;
		}
		
		if(confirm("<" + movie_name + ">을 지난상영작으로 등록 하시겠습니까?")){
			// 지난상영작으로 등록 가능 여부 판별
			// 해당영화의 상영종료날짜가 오늘보다 이후의 날짜면 지난상영작으로 등록 불가
			// (상영기간이 끝난후에 지난상영작으로 등록 가능)
			let today = new Date();
			let endDay = new Date(end_screening_date);
			if(today < endDay) {
				alert("지난상영작으로 등록불가. 상영이 종료되지 않았습니다.")
				return;
			}
			
			// 스케줄 존재시 현재상영작으로 등록가능
			$.ajax({
				type : "POST",
				url : "UpdateMovieStatusToPast",
				data : {
					movie_code : movie_code,
					movie_status : "지난상영작",
				},
			}).done(function(result) {
				alert(result.msg);
				location.reload();
			}).fail(function() {
				alert("지난상영작으로 등록 실패");
			});
		}
	});
	
	// 테이블 선택여부 판별 메서드
	function isClicked() {
		if(movie_code == "") {
			alert("영화를 선택해 주세요");
			return false;
		}
		return true;
	}
}); // document ready 끝
	
	
	
	
	
	