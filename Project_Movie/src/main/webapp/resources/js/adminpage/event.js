$(function(){
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
		location.href="EventBoardRegis";
	});	
	
	$("#selectAll").on("click", function(){
	    let checkboxes = $(".eventSetCheckbox");
	    let isChecked = $(this).data("checked") || false; // 현재 버튼 상태를 확인 (기본값은 false)
	    
	    // 체크 상태를 반전시킴
	    checkboxes.prop("checked", !isChecked);

	    // 버튼 상태를 업데이트
	    $(this).data("checked", !isChecked);

	    // 버튼 텍스트 변경
	    if (!isChecked) {
	        $(this).val("전체해제");
	    } else {
	        $(this).val("전체선택");
	    }
	});
	
	$("#board_modify").on("click", function(){
		location.href="EventBoardModify";
	});

	$("#delete").on("click", function(){
		confirm("삭제하시겠습니까?");
	});
	
	$("#eventStart").on("click", function(){
	let eventSetCheckbox = $(".eventSetCheckbox:checked");
	
	if(eventSetCheckbox.length > 0) {
		let eventStartList = [];
		eventSetCheckbox.each(function (){
			eventStartList.push($(this).val());	
		});
		if(confirm("해당 이벤트를 진행 상태로 변경하시겠습니까?")) {
			location.href="StartEvent?event_code=" + eventStartList.join(",");
		}
		} else {
			alert("삭제할 계정을 선택하세요.");
		}
	});
	
	$("#eventEnd").on("click", function(){
		let eventSetCheckbox = $(".eventSetCheckbox:checked"); // 체크된 체크박스들의 값을 eventSetCheckbox(jquery 객체 형태로 저장)
		
		if(eventSetCheckbox.length > 0) { // jquery 객체배열 형태에 저장된 값이 1개 이상일 경우 해당 값을 eventEndList라는 배열에 차례로 저장한다.
			let eventEndList = [];
			eventSetCheckbox.each(function (){
				eventEndList.push($(this).val());	
			});
			if(confirm("해당 이벤트를 진행 상태로 변경하시겠습니까?")) {
				location.href="EndEvent?event_code=" + eventEndList.join(",");
			}
		} else {
			alert("삭제할 계정을 선택하세요.");
		}
	});
	
	$("#give_prize").on("click", function(){
		location.href="GivePrizeForm";
	});
	
	
});