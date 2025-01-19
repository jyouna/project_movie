$(function() {
	// 투표등록버튼 클릭시 투표등록 모달창 출력
	$("#registPickBtn").click(function() {
		$(".modal").css("display", "block");
		
	});
	
	// 모달창의 닫기버튼 클릭시 모달창 닫기
	$(".close_modal").click(function() {
		location.reload(true);
	});
	
	// 테이블 행 선택시 해당 행의 체크박스 체크/해제
	$("#pick_movie_list > table").on("click", "tr", function() {
		let checkBox = $(this).find(".check");
		checkBox.prop("checked", !checkBox.prop("checked"));
	});
	
	// 스케줄 보드의 헤더 체크박스 클릭시 모든 체크박스 클릭, 해제
	$("#allCheck").click(function() {
		if($(this).prop("checked")) {
			$(".check").prop("checked", true);
		} else {
			$(".check").prop("checked", false);
		}
	});
	
	// 체크된 영화의 코드들을 변수에 초기화하는 메서드
	function getCheckedMovieCode() {
		let checkMovieCodeStr = "";
		$(".check:checked").each(function() {
			checkMovieCodeStr += $(this).val() + " ";
		})
		return checkMovieCodeStr;
	}
});