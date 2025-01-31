$(function() {
	// 쿠폰 버튼
	$(".checkCouponRadio").click(function() {
		let coupon_code = $(this).val();
		$.ajax({
			type : "GET",
			url : "GetMyCouponDetailInfo",
			data : {
				coupon_code
			}
		}).done(function(coupon) {
			if(coupon.coupon_type == 0) {
				let calAmount = $(".div01 .price").text() - coupon.discount_amount;
				if(calAmount < 0) {
					if(confirm("할인 금액이 결제 금액보다 큽니다.\n사용하시겠습니까?")) {
						calAmount = 0;
						$(".div02 .price").text($(".div01 .price").text()); 
					} else {
						location.reload();
					}
				} else {
					$(".div02 .price").text(coupon.discount_amount);
				}

				$(".div03 .price").text(calAmount);
				$("input[name='total_discount']").val($(".div02 .price").text());

				
				// 결제금액과 할인금액이 동일할 시 결제수단 비활성화
				discountEqualPrice();
			} else {
				let discountAmount = $(".div01 .price").text() * coupon.discount_rate / 100;
				$(".div02 .price").text(discountAmount);
				$(".div03 .price").text($(".div01 .price").text() - discountAmount);
				$("input[name='total_discount']").val($(".div02 .price").text());
				
				console.log($(".div01 .price").text().trim());
				console.log($(".div02 .price").text());
				
				// 결제금액과 할인금액이 동일할 시 결제수단 비활성화
				discountEqualPrice();
			}
			
			
			
		}).fail(function() {
			alert("쿠폰 적용에 실패하였습니다");
		});
		
		
	});
	
	// 포인트 칸
	$(".point_form").keyup(function() {
		// 첫글자 1부터, 숫자만 4자리 입력 가능
		let regex = /^[1-9][0-9]{0,3}$/;
		let thisVal =$(this).val();
		let myPoint = parseInt($(".point02").text().replace(" p", ""));
		if(thisVal == "") {
			thisVal = 0
		}
		let regexPoint = parseInt(thisVal, 10);
		
		console.log(thisVal);
		if (!regex.exec(thisVal) && thisVal != "") {
	        alert("숫자만 입력 가능합니다");
	        $(this).val("");
	        $(".div02 .price").text(0);
	        $(".div03 .price").text($(".div01 .price").text());
        	return;
	    }  
			
		if(regexPoint > 5000) { // 입력값이 5000보다 클 때
			alert("최대 5000p 사용 가능합니다.")
			$(".div02 .price").text(0);
			$(".div03 .price").text($(".div01 .price").text());
			$(this).val("");
		} else {
			if(myPoint < regexPoint) {
				alert("보유 포인트를 초과하여 사용하실 수 없습니다");
				$(".div02 .price").text(0);
				$(".div03 .price").text($(".div01 .price").text());
				$(this).val("");
			} else {
				$(".div02 .price").text(regexPoint);
				$(".div03 .price").text($(".div01 .price").text() - $(this).val());
				$("input[name='total_discount']").val($(".div02 .price").text());
			}
		}
		// 결제금액과 할인금액이 동일할 시 결제수단 비활성화
		discountEqualPrice();
	
	    // 특정 input 요소에서 엔터키를 비활성화
	    $(".point_form").on("keypress", function(e) {
	        if (e.which === 13) {
	            e.preventDefault(); // 기본 동작을 막음 (폼 제출 방지)
	        }
	    });

	});

	
	// 결제 버튼 클릭 시 선택되어 있는 결제수단으로 결제
	$(".payment_btn").click(function() {
		
		if($(".pay").prop("disabled")) {
			if(confirm("결제하시겠습니까?")) {
				
				alert("결제가 완료되었습니다");
				
				$("#paymentMethod").val("쿠폰/포인트");
				$("#paymentStatus").val("1");
				$("#totalPayment").val(0);
				
				$("#paymentForm").submit();
			} else {
				alert("결제가 취소되었습니다");
				location.reload();
			}
			
		} else {
			if($(".pay:checked").length == 0) {
				alert("결제수단을 선택해주세요");
				return false;
			} else if($(".pay").eq(0).is(':checked')) {
				// 신용카드
				KGmobilians();
			} else if($(".pay").eq(1).is(':checked')) {
				// 카카오페이
				kakaopay();
			} else if($(".pay").eq(2).is(':checked')) {
				// 토스페이
				tosspay();
			}
			
		}
		
	});
	
	// 결제금액과 할인금액이 동일할 시 결제수단 비활성화
	function discountEqualPrice() {
		if($(".div01 .price").text().trim() === $(".div02 .price").text().trim()) {
			$(".pay").prop("disabled", true);
		} else {
			$(".pay").prop("disabled", false);
		}
	}
	
	
	// 결제 페이지에서 10분 초과 시 첫 페이지로 이동
	function sessionExpired() {
	    alert('결제 시간이 만료되었습니다. 처음부터 다시 시도해 주세요.');
		location.href="BookTickets";
	}
	
	// 10분 후에 sessionExpired 메서드를 호출합니다.
	setTimeout(sessionExpired, 120 * 1000);


});






















