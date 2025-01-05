$(function() {
	// 테이블의 값을 저장하기위한변수
	let movie_code = "";
	let movie_name = "";
	let screening_date = "";
	
	// 테이블 행 클릭시 해당행 라디오버튼 클릭 및 변수에 값 저장
	$("table").on("click", "tr", function() {
		$(this).find("input[type='radio']").prop("checked", true);
		movie_code = $(this).find("td:eq(0)").text();
		movie_name = $(this).find("td:eq(1)").text();
		screening_date = $(this).find("td:eq(2)").text()
		start_screening_date = $("#start_date").val()
		end_screening_date = $("#end_date").val()
	});
	
    // 상영기간설정 모달 오픈
    $("#set_date_btn").on("click", function() {
		if(movie_code == "") {
			alert("영화를 선택해 주세요");
		} else if(screening_date != "상영예정기간을 입력해주세요.") {
			alert("상영예정기간을 이미 입력하셨습니다")
		} else {
	        $("#screening_date_modal").css("display", "block");
			$(".modal_content").prepend("<h4><" + movie_name + "></h4>")
		}
    });

    // 상영기간설정 모달 닫기
    $(".close_modal").on("click", function() {
        $("#screening_date_modal").css("display", "none");
		location.reload();
    });
	
	// 상영기간설정 입력 버튼 클릭시 해당 기간으로 영화db정보 업데이트
	// 및 모달창닫고 reload
	$("#set_btn").click(function() {
		// ajax를 통해 movie테이블의 상영시작일, 상영종요일 업데이트
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
}); // document ready 끝
	
	
	
	
	
	