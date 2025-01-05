$(function () {
	
	// + 버튼 클릭 시 인원수 증가
	$(".plus_btn").on("click", function() {
		let totalCount = 0;
		// 관람객 타입별 인원수 합
		$(".count").each(function () {
			totalCount += parseInt($(this).val());
		});
		
		// 8명 이상 선택 불가
		if(totalCount >= 8) {
			alert("인원수는 최대 8명까지 가능합니다");
			return;
		}
		
		// 클릭한 버튼의 대상 숫자 증가
		let targetInput = $(this).siblings(".count");
		let currentCount = parseInt(targetInput.val());
		
		targetInput.val(currentCount + 1);
		
		console.log("선택된 인원 수 : " + (totalCount + 1));
		
	});
	
	// - 버튼 클릭 시 인원수 증가
	$(".minus_btn").on("click", function() {
		let targetInput = $(this).siblings(".count");
		let currentCount = parseInt(targetInput.val());

		// 0명일 때 버튼 클릭 시 알림창
		if(currentCount > 0) {
			targetInput.val(currentCount - 1);
		} else {
			alert("인원을 선택해주세요");
		}
	});

	
	// 좌석 선택 & 선택된 좌석 값 가져오기
	$(".seat").on("click", function() {
		// 현재 클릭된 요소만 가리킴
		$(this).toggleClass("selected");
		
		// 선택된 좌석 값 가져오기
		let selectedSeats = $(".seat.selected").map(function() {
			return $(this).text();
		}).get();
		
		console.log("선택된 좌석 : " + selectedSeats);
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
});











