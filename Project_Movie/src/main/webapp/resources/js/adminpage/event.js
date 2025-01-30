$(function(){
	$("input[type='checkbox']").prop("checked", false); 
	// 전체 선택 후 history.back()을 해도 기존에 선택했던 체크박스 모두 초기화 됨
	
	$("#give_point").on("click", function(){
		location.href="PointBoardRegis";
	});	

	$("#getback_point").on("click", function(){
		confirm("포인트를 회수하시겠습니까?");
	});
	
	$("#searchBtn").on("click", function(){
		alert("검색 버튼 클릭됨");
	});
	
	$("#board_regis").on("click", function(){
		console.log("클릭클릭");
		window.open("EventBoardRegis", "이벤트등록", "width=1000, height=800, left=460, top=140");
	});	
	
	$("#coupon_regis").on("click", function(){
		location.href="CouponBoardRegis";
	});
	
	$("#selectAll").on("click", function(){
	    let checkboxes = $(".eventSetCheckbox"); // 체크박스 전체 선택자
	    let isChecked = $(this).data("checked") || false; // 현재 체크 상태값 저장. 없는 경우 false 값으로 설정
		console.log("체크 속성값 : " + isChecked);
	    $(this).data("checked", !isChecked);
	    checkboxes.prop("checked", !isChecked);
	});
	
	$("#board_modify").on("click", function(){
		location.href="EventBoardModify";
	});

	$("#delete").on("click", function(){
		confirm("삭제하시겠습니까?");
	});
	
	$("#eventStart").on("click", function(){
		// 이미 종료되었거나 진행중인 경우에는 alert 창 띄워서 사용 못한다고 알려주기
		// 대기 상태인 경우에만 진행으로 변경하기
		let eventCode = $(".eventSetRadio:checked").val();
		if(eventCode == null) {
	        alert("이벤트를 선택하세요.");
	        return;
		} else {
			console.log("이벤트 코드 : " + eventCode);
		}
		if(confirm("해당 이벤트를 진행 상태로 변경하시겠습니까?")) {
			
			$.ajax({
				url : "checkStatusBeforeStart",
				type : "post",
				data : {
					event_code : eventCode
				},
				success : function(result){
					if(result){
						location.href="StartEvent?event_code=" + eventCode;
					} else {
						alert("대기 상태인 이벤트만 가능합니다");
					}
				}
			});
		}
	});
	
	$("#eventEnd").on("click", function(){
		// 진행 중인 경우에만 사용 가능하다고 alert 작성
		let eventCode = $(".eventSetRadio:checked").val();
		if(eventCode == null) {
	        alert("이벤트를 선택하세요.");
	        return;
		} else {
			console.log("이벤트 코드 : " + eventCode);
		}
		
		if(confirm("해당 이벤트를 진행 상태로 변경하시겠습니까?")) {
			$.ajax({
				url : "checkStatusBeforeEnd",
				type : "post",
				data : {
					event_code : eventCode
				},
				success : function(result){
					if(result){
						location.href="EndEvent?event_code=" + eventCode;
					} else {
						alert("진행 상태인 이벤트만 가능합니다");
					}
				}
			});
		}
	});

	$("#giveCoupon").on("click", function(){
		let eventSetCheckbox = $(".eventSetCheckbox:checked");
		let event_code = $("#event_code").val();

		if(eventSetCheckbox.length > 0) {
			let eventStartList = [];
			eventSetCheckbox.each(function (){
				if($(this).val() != "on") {
					eventStartList.push($(this).val());
				}	
			});
			if(confirm("쿠폰을 지급하시겠습니까?")) {
				location.href="GiveCoupon?member_id=" + eventStartList.join(",") + "&event_code=" + event_code;
			}
		} else {
			alert("대상자를 선택하세요");
		}
	});
	
	$("#givePoint").on("click", function(){
		let eventSetCheckbox = $(".eventSetCheckbox:checked"); // 체크된 체크박스들의 값을 eventSetCheckbox(jquery 객체 형태로 저장)
		let event_code = $("#event_code").val();
		
		if(eventSetCheckbox.length > 0) { // jquery 객체배열 형태에 저장된 값이 1개 이상일 경우 해당 값을 eventEndList라는 배열에 차례로 저장한다.
			let eventEndList = [];
			eventSetCheckbox.each(function (){
				if($(this).val() != "on") {
					eventEndList.push($(this).val());
				}
			});
			if(confirm("포인트를 지급하시겠습니까?")) {
				location.href="GivePoint?member_id=" + eventEndList.join(",") +"&event_code=" + event_code;
			}
		} else {
			alert("대상자를 선택하세요");
		}
	});
		
	$("#chooseEventWinner").on("click", function(){  
		let eventCode = $(".eventSetRadio:checked").val();
		console.log("당첨자 선택 버튼 클릭 됨");
		console.log("eventCode : " + eventCode);
		
		if(!eventCode) {
			alert("대상자를 선택하세요");
			return;
		} 
		
		if(confirm("당첨자 추첨을 진행하시겠습니까?")) {
			$.ajax({
				url : "checkEventStatus",
				type : "post",
				data : {event_code : eventCode},
				success : function(result){
					if(result) {
						location.href="ChooseEventWinner?event_code=" + eventCode;
					} else {
						alert("종료 및 당첨 미진행 이벤트만 추첨 가능합니다.");
					}
				}
			});
		} 
	});
	
	// 쿠폰타입 선택
	$("#coupon_type").on("change", function(){
		let coupon_type = $("#coupon_type").val();
		console.log("쿠폰 타입 : " + coupon_type);
		
	    if (coupon_type === "금액할인") {
	        $("#thForDiscount").text("할인금액");
	        $("#discount_amount").removeAttr("hidden"); // hidden 속성 제거
	        $("#discount_rate").attr("hidden", true); // 다른 항목 숨기기
	        $("#discount_rate").val("0"); // 다른 항목 숨기기
	    
	    } else if (coupon_type === "할인율") {
	        $("#thForDiscount").text("할인율");
	        $("#discount_rate").removeAttr("hidden");
	        $("#discount_amount").attr("hidden", true);
	        $("#discount_amount").val("0");
	    	
	    } else {
	        $("#thForDiscount").text(""); // 기본값 초기화
	        $("#discount_amount").attr("hidden", true);
	        $("#discount_rate").attr("hidden", true);
	    }
	});

	// 쿠폰 지급 폼 취소
	$("#cancel").on("click", function(){
		if(confirm("이전 페이지로 돌아가시겠습니까?")) {
			history.back();
		}
	});
	
	// 쿠폰 지급 폼 제출
	$("#couponSubmit").on("click", function(){
		if(confirm("해당 내용으로 쿠폰을 지급하시겠습니까?")) {
			$("#giveCouponForm").submit();
		}	
	});
	
	$("#deleteEvent").on("click", function(){
		let event_code = $(".eventSetRadio:checked").val();
		console.log("ajax 이벤트 코드 : " + event_code);
						
		if(event_code == null) {
			alert("삭제할 이벤트를 선택하세요.");
		} else {	
			if(confirm("해당 계정을 삭제하시겠습니까?")){
				$.ajax({
					url: "DeleteEventBoard",
					type: "get",
					data: {event_code : event_code},
				}).done(function(response){
					if(response){
						alert("해당 게시글이 삭제되었습니다.")
						location.replace("EventBoardManage");
					} else {
						alert("종료된 이벤트는 삭제 불가합니다.");
					}
				});
			}
		}
	});
	
	$("#eventStatus, #eventSetWinnerStatus").on("change", function(){
		$("#eventStatusHidden").val($("#eventStatus").val());
		$("#eventWinnerStatusHidden").val($("#eventSetWinnerStatus").val());
		$("#searchForm").submit();
	});
	
});