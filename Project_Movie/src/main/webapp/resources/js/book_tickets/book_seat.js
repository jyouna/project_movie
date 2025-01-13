$(function () {
	
	// 인원수 변경 시 선택된 좌석 초기화 메서드 정의
	function resetSeats() {
		if($(".seat.selected").length > 0) {
			$(".seat").removeClass("selected");
		}
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
	});
	
	
	let selectedSeats = "";
	// 좌석 선택 & 선택된 좌석 값 가져오기
	$(".seat").on("click", function() {
		// 현재 클릭된 요소만 가리킴
		$(this).toggleClass("selected");
		
		// 선택된 좌석 값 가져오기
		selectedSeats = $(".seat.selected").map(function() {
			return $(this).text();
		}).get();
		
		console.log("선택된 좌석 : " + selectedSeats);
		
		
		// 휠체어석 선택 시 알림창
		if(($(this).text() == "A8" || $(this).text() == "A9") && $(this).hasClass("selected")) {
			alert("해당 좌석은 휠체어석입니다.\n일반 고객은 다른 좌석을 선택해 주시기 바랍니다.");
		}
			
		// -------------------------------------------------
		// 관람객 타입별 인원수 합		
		let totalCount = 0;
		$(".count").each(function() {
			totalCount += parseInt($(this).val());
		});
		
		// 인원수 만큼 좌석 선택 가능
		if(totalCount == 0) {
			$(this).removeClass("selected");
			alert("인원을 선택해주세요");
			location.reload();
		} else if(selectedSeats.length > totalCount) {
			$(this).removeClass("selected");
			alert("좌석이 선택이 완료되었습니다");
		} 
		
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
	
	function seats() {
		$.ajax({
			type : "POST",
			url : "BookSeat",
			data : {
				ticket_type : ticket_type,
				ticket_amount : ticket_amount
			}
		}).done(function(data) {
			let ticketType = "";
			for(let ticket of data) {
				if(ticket.ticket_type == 0) {
					ticketType = "성인";
				} else if(ticket.ticket_type == 1) {
					ticketType = "청소년";
				} else {
					ticketType = "경로/우대";
				}
				
				$(".ticket_info").append(`
				<div class="header">${ticketType}</div>
	            <div class="data">
	            	<span class="price">${ticket.ticket_amount}</span>
	            	<span class="exe"> 원 X</span>
	            	<span class="qty"> 2</span>
	            </div>
			`);
			}
			
			
		}).fail(function(){
			
		});
	}
	
	
	
	
	
	
	
	
		
	
});











