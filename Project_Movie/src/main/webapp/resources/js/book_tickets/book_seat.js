$(function () {
	let selectedSeats = "";
	
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
		seats();
		

		
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
		
		seats();
	});
	
	
	
	// 좌석 선택 & 선택된 좌석 값 가져오기
	$(".seat").on("click", function() {
		let totalCount = 0;
	
		// 관람객 타입별 인원수 합		
		$(".count").each(function() {
			totalCount += parseInt($(this).val());
			console.log(totalCount);
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
			alert("좌석이 선택이 완료되었습니다");
		}
		
		// 휠체어석 선택 시 알림창
		if(($(this).text() == "A8" || $(this).text() == "A9") && $(this).hasClass("selected")) {
			alert("해당 좌석은 휠체어석입니다.\n일반 고객은 다른 좌석을 선택해 주시기 바랍니다.");
		}
			
		$(".mv_info .data").eq(3).empty();
		$(".mv_info .data").eq(3).append(selectedSeats);
		
	});
	
	
	// 수정 필요
	$(".pay_btn").click(function(event) {
		event.preventDefault(); // 기본 동작 방지
		
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
		
		location.href = 'BookPay';
		
	});		
	
	let ticket_type = "";
	$("ul li strong").each(function() {
		ticket_type = $(this).text();
			if(ticket_type == '성인') {
				ticket_type = 0;
			} else if(ticket_type == '청소년') {
				ticket_type = 1;
			} else if(ticket_type == '경로/우대'){
				ticket_type = 2;
			}
			
//		console.log("관객 : " + ticket_type);
	});
	
	
	
	
	function seats() {
		
		let adultCount = parseInt($(".count").eq(0).val());
		let youthCount = parseInt($(".count").eq(1).val());
		let seniorCount = parseInt($(".count").eq(2).val());
		
		let adultAmount = 10000;
		let youthAmount = 7000;
		let seniorAmount = 5000;
		
		let totalAmount = adultCount * adultAmount + youthCount * youthAmount + seniorCount * seniorAmount;
		console.log(totalAmount);
		
		$(".ticket_info").empty();
		if(adultCount != 0) {
//				<div class="header">
//					<strong>일반</strong>
//	            </div>
//	            <div class="data">
//	            	<span class="price">${ticket.ticket_amount}</span>
//	            	<span class="exe"> 원 X</span>
//	            	<span class="qty"></span>
//	            </div>
			$(".ticket_info").prepend(`
			
			
				<div class = "row">
					<strong>성인</strong> ` + adultAmount + ` 원 X `+ adultCount +`
				</div> 
			`)
		}
		if(youthCount != 0) {
			$(".ticket_info").prepend(`
				<div class = "row">
					<strong>청소년</strong> ` + youthAmount + ` 원 X `+ youthCount +`
				</div> 
			`)
		}
		if(seniorCount != 0) {
			$(".ticket_info").prepend(`
				<div class = "row">
					<strong>경로/우대</strong> ` + seniorAmount + ` 원 X `+ seniorCount +`
				</div> 
			`)
		}
		$(".ticket_info").append(`
	        <div class="row">
	            <div class="header">총금액</div>
	            <div class="data">
	            	<span class="price"></span>
	                <span class="won">`+  totalAmount + `원</span>
	            </div>
	        </div>
		`);
		
	}
	
//			$(".ticket_info").empty();
//			
//			let ticketType = "";
//			for(let ticket of data) {
//				if(ticket.ticket_type == 0) {
//					ticketType = "성인";
//				} else if(ticket.ticket_type == 1) {
//					ticketType = "청소년";
//				} else {
//					ticketType = "경로/우대";
//				}
//				
//				$(".ticket_info").append(`
//				<div class="header">${ticketType}</div>
//	            <div class="data">
//	            	<span class="price">${ticket.ticket_amount}</span>
//	            	<span class="exe"> 원 X</span>
//	            	<span class="qty"> 2</span>
//	            </div>
//			`);
	
	
	
	
	
});











