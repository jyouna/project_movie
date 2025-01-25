$(function() {
	let selectedSeat = ""
	
	// 상단 영화관선택 설렉트박스 선택시 해당 상영관 좌석 정보 출력
	$("#theaterSelect").change(function() {
		location.href = "AdminSeatSet?theater_code=" + $(this).val();
	});
	
	// 좌석선택시 해당좌석 토글
	$(".seat").click(function() {
		$(this).toggleClass("selected");
	});
	
	// 활성화 버튼 클릭시 좌석 활성화
	$("#ableBtn").click(function() {
		// 선택된 좌석 변수에 초기화
		$(".seat.selected").each(function() {
			selectedSeat += $(this).text().trim() + " ";
		})
		
		if(confirm(selectedSeat + " 좌석 활성화 하시겠습니까?")) {
			updateSeatStatus(selectedSeat, 1);
		}
	});
	
	// 비활성화 버튼 클릭시 좌석 비활성화
	$("#disableBtn").click(function() {
		// 선택된 좌석 변수에 초기화
		$(".seat.selected").each(function() {
			selectedSeat += $(this).text().trim() + " ";
		})
		
		if(confirm(selectedSeat + " 좌석 활성화 하시겠습니까?")) {
			updateSeatStatus(selectedSeat, 0);
		}
	});
	
	// 좌석상태변경 메서드
	function updateSeatStatus(selectedSeat, seat_avail) {
		$.ajax({
			type : "post",
			url : "ChangeSeatStatus",
			data : {
				theater_code : $("#theaterSelect").val(),
				selectedSeat,
				seat_avail
			}
		}).done(function(result) {
			console.log(result);
			if(result) {
				if(seat_avail == 0) {
					alert(selectedSeat + " 좌석 비활성화 되었습니다");
				} else {
					alert(selectedSeat + " 좌석 활성화 되었습니다");
				}
				
				location.reload(true);
			} else {
				alert("좌석 상태 변경에 실패하였습니다.");
			}
		}).fail(function() {
			alert("좌석 상태 변경에 실패하였습니다.");
		});
	}
	
});