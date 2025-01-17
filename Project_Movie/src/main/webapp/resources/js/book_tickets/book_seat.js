$(function () {
	let selectedSeats = "";
	let totalAmount = 0;
	
	// 인원수 변경 시 선택된 좌석 초기화 메서드 정의
	function resetSeats() {
		if($(".seat.selected").length > 0) {
			$(".seat").removeClass("selected");
		}
		selectedSeats = "";
		$(".mv_info .data").eq(3).empty();
	}
	
	// + 버튼 클릭 시 인원수 증가
	$(".plus_btn").on("click", function() {
		
		// 관람객 타입별 인원수 합
		let totalCount = 0;
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
		
		// 인원 변경 시 선택된 좌석 초기화 메서드
		resetSeats();
		ticketCount($(this).val());
		$("#totalAmount").val(totalAmount);
		eachTicketCount();
	});
	
	// - 버튼 클릭 시 인원수 감소
	$(".minus_btn").on("click", function() {
		let targetInput = $(this).siblings(".count");
		let currentCount = parseInt(targetInput.val());

		// 0명일 때 버튼 클릭 시 알림창
		if(currentCount > 0) {
			targetInput.val(currentCount - 1);
		} else {
			alert("인원을 선택해주세요");
		}

		// 인원 변경 시 선택된 좌석 초기화 메서드
		resetSeats();
		ticketCount($(this).val());
		
		eachTicketCount();
	});
	
	
	
	// 좌석 선택 & 선택된 좌석 값 가져오기
	$(".seat").on("click", function() {
		let totalCount = 0;
	
		// 관람객 타입별 인원수 합		
		$(".count").each(function() {
			totalCount += parseInt($(this).val());
		});
		
		// 인원수 만큼 좌석 선택 가능
		if(totalCount == 0) {
			$(this).removeClass("selected");
			alert("인원을 선택해주세요");
		} else if(selectedSeats.length < totalCount) {
			$(this).toggleClass("selected");
			
			// 선택된 좌석 값 가져오기
			selectedSeats = $(".seat.selected").map(function() {
				return $(this).text() + " ";
			}).get();
			
		} else if(selectedSeats.length == totalCount) {
			$(this).removeClass("selected");
			alert("좌석 선택이 완료되었습니다");

			// 선택된 좌석 값 가져오기
			selectedSeats = $(".seat.selected").map(function() {
				return $(this).text() + " ";
			}).get();
		}
		console.log("선택된 좌석 : " + selectedSeats);
		
		// 휠체어석 선택 시 알림창
		if(($(this).text() == "A8" || $(this).text() == "A9") && $(this).hasClass("selected")) {
			alert("해당 좌석은 휠체어석입니다.\n일반 고객은 다른 좌석을 선택해 주시기 바랍니다.");
		}

			
		$(".mv_info .data").eq(3).empty();
		$(".mv_info .data").eq(3).append(selectedSeats);
		$(".mv_info .data").eq(3).val(selectedSeats);
		
		$("#totalSeat").val(selectedSeats);
	});
	
	
	$(".pay_btn").click(function() {
//		event.preventDefault(); // 기본 동작 방지
		
		let totalCount = 0;
		$(".count").each(function() {
			totalCount += parseInt($(this).val());
		});
		
		console.log(selectedSeats.length);
		
		if(totalCount == 0) {
			alert("인원을 선택해주세요");
			return false;
		} else if(selectedSeats.length != totalCount) {
			alert("좌석을 모두 선택해주세요");
			return false;
		}
		
		$("#totalAmount").val(totalAmount);
		
	});		
	
	// 타입 별 인원 수 jsp value에 넘기기
	function eachTicketCount() {
		let adultCount = parseInt($(".count").eq(0).val());
		$("#adult").val(adultCount);
		let youthCount = parseInt($(".count").eq(1).val());
		$("#youth").val(youthCount);
		let seniorCount = parseInt($(".count").eq(2).val());
		$("#senior").val(seniorCount);
	}
	
	// 관객 타입 별 가격과 인원 수에 따른 총금액
	function ticketCount(showtime_type) {
		
		let adultCount = parseInt($(".count").eq(0).val());
		let youthCount = parseInt($(".count").eq(1).val());
		let seniorCount = parseInt($(".count").eq(2).val());
		
		console.log(adultCount);
		console.log(youthCount);
		console.log(seniorCount);
		console.log("showtime : " + showtime_type);
		
		let adultAmount = 10000;
		let youthAmount = 7000;
		let seniorAmount = 5000;
		
		if(showtime_type !== "일반") {
			adultAmount -= 2000; 
			youthAmount -= 2000; 
			seniorAmount -= 2000; 
		}

		totalAmount = adultCount * adultAmount + youthCount * youthAmount + seniorCount * seniorAmount;
//		console.log(totalAmount);
		
		$(".ticket_info").empty();
		$(".mv_info .row .data").eq(2).empty();
		
		// 일반 티켓 가격과 수량
		if(adultCount != 0) {
			$(".ticket_info").append(`
				<div class = "row">
					<div class="header">
						<strong>일반</strong>
		            </div>
		            <div class="data">
		            	<span class="price">` + adultAmount + `</span>
		            	<span class="exe"> 원 X</span>
		            	<span class="qty">` + adultCount + `</span>
		            </div>
	            </div>
			`)
			
			$(".mv_info .row .data").eq(2).append(`
				일반 ` + adultCount + `명
			`);
		}
		// 청소년 티켓 가격과 수량
		if(youthCount != 0) {
			$(".ticket_info").append(`
				<div class = "row">
					<div class="header">
						<strong>청소년</strong>
		            </div>
		            <div class="data">
		            	<span class="price">` + youthAmount + `</span>
		            	<span class="exe"> 원 X</span>
		            	<span class="qty">` + youthCount + `</span>
		            </div>
	            </div>
			`)
			
			$(".mv_info .row .data").eq(2).append(`
				청소년 ` + youthCount + `명
			`);
		}
		// 경로/우대 티켓 가격과 수량
		if(seniorCount != 0) {
			$(".ticket_info").append(`
				<div class = "row">
					<div class="header">
						<strong>경로/우대</strong>
		            </div>
		            <div class="data">
		            	<span class="price">` + seniorAmount + `</span>
		            	<span class="exe"> 원 X</span>
		            	<span class="qty">` + seniorCount + `</span>
		            </div>
	            </div>
			`)
			
			$(".mv_info .row .data").eq(2).append(`
				경로/우대 ` + seniorCount + `명
			`);
		}
		
		// 총금액
		$(".ticket_info").append(`
	        <div class="row">
	            <div class="header">총금액</div>
	            <div class="data">
	            	<span class="price">` + totalAmount + `</span>
	                <span class="won"> 원</span>
					<input type="hidden" name="totalAmount" value="` + totalAmount + `">
	            </div>
	        </div>
		`);
		
		
		
		
	}
	
	
});











