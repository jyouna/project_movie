$(function(){
	$("#totalPeriodSearch").on("click",function(){
		alert("전체 기간 조회");
	});

	$("#monthlySearch").on("click",function(){
		alert("월 단위 조회");
	});
	
	$("#specificPeriodSearch").on("click",function(){
		window.open(
			'SpecificPeriodSearch', // 팝업 창에 로드할 파일
	        '상세기간 조회',    // 팝업 창 이름
    	    'width=300,height=200,scrollbars=no,resizable=no');
	});
});