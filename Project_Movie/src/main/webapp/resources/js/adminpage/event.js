$(function(){
	$("#give_point").on("click", function(){
		window.open(                
			'PointBoardRegis', // 팝업 창에 로드할 파일
            '포인트 등록',    // 팝업 창 이름
            'width=800,height=300,scrollbars=no,resizable=no');
	});	

	$("#getback_point").on("click", function(){
		confirm("포인트를 회수하시겠습니까?");
	});
	
	$("#searchBtn").on("click", function(){
		alert("검색 버튼 클릭됨");
	});
	
	$("#board_regis").on("click", function(){
		window.open(                
			'EventBoardRegis', // 팝업 창에 로드할 파일
            '이벤트 등록',    // 팝업 창 이름
            'width=850,height=500,scrollbars=no,resizable=no');
	});	
	
	$("#selectAll").on("click", function(){
		alert("전체 선택 클릭됨");
	});
	
	$("#board_modify").on("click", function(){
		window.open(                
			'EventBoardModify', // 팝업 창에 로드할 파일
            '이벤트 수정',    // 팝업 창 이름
            'width=850,height=500,scrollbars=no,resizable=no');
	});

	$("#delete").on("click", function(){
		confirm("삭제하시겠습니까?");
	});
	
	
});