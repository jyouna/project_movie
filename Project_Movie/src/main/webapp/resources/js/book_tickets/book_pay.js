$(function() {
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
					} else {
						location.reload();
					}
				}
				$(".div02 .price").text(coupon.discount_amount);
				$(".div03 .price").text(calAmount);
			} else {
				let discountAmount = $(".div01 .price").text() * coupon.discount_rate / 100;
				$(".div02 .price").text(discountAmount);
				$(".div03 .price").text($(".div01 .price").text() - discountAmount);
			}
		}).fail(function() {
			alert("쿠폰 적용에 실패하였습니다");
		});
	});
	
	$(".point_form").keyup(function() {
		if($(this).val() > 2000) {
			alert("최대 2000p 사용 가능합니다.")
			$(".div02 .price").text(0);
			$(this).val("");
		} else {
			$(".div02 .price").text($(this).val());
			$(".div03 .price").text($(".div01 .price").text() - $(this).val());
		}
	});
	
	// 결제 버튼 클릭 시 선택되어 있는 결제수단으로 결제
	$(".payment_btn").click(function() {
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
	});
	
});






















