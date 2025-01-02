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
		alert("전체 선택 클릭됨");
	});
	
	$("#board_modify").on("click", function(){
		location.href="EventBoardModify";
	});

	$("#delete").on("click", function(){
		confirm("삭제하시겠습니까?");
	});
	
	
});