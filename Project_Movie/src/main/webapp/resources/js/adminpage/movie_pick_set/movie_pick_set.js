$(function() {
	// 투표등록버튼 클릭시 투표등록 모달창 출력
	$("#registPickBtn").click(function() {
		if($("#voteCode").val() != null) {
			alert("이미 등록된 투표가 있습니다\n한시즌에 중복 투표등록 불가");
			return;
		}
		
		$(".modal").css("display", "block");
		
	});
	
	// 모달창의 닫기버튼 클릭시 모달창 닫기
	$(".close_modal").click(function() {
		location.reload(true);
	});
	
	// 투표영화목록 체크박스 클릭시 모든 체크박스 클릭, 해제
	$("#allCheck").click(function() {
		if($(this).prop("checked")) {
			$(".check").prop("checked", true);
		} else {
			$(".check").prop("checked", false);
		}
	});
	
	// 투표영화에서 삭제 버튼 클릭시 movie_status를 '대기'로 변경
	$("#removeFromPickBtn").click(function() {
		let checkMovieCodeStr = getCheckedMovieCode();
		// 영화 선택여부 판별
		if(checkMovieCodeStr == "") {
			alert("영화를 선택해 주세요");
		} else if($("#isActivation").text() == "활성화") {
			alert("활성화된 투표의 투표영화는 삭제할 수 없습니다");
		} else {
			location.href = "RemoveMovieFromPick?movieCodeStr=" + checkMovieCodeStr;
		}
	});
	
	// 투표시작 버튼 클릭시 투표 활성화
	$("#startVoteBtn").click(function() {
		if($("#voteCode").val() == null) {
			alert("투표정보가 없습니다(투표시작 불가)");	
		} else if($("#isActivation").val() == 1) {
			alert("이미 활성화 상태입니다");
		} else {
			if(confirm("투표활성화 하시겠습니까?")) {
				location.href = "StartVoteForThisSeason?vote_code=" + $("#voteCode").val();
			}
		}
	});
	
	// 투표종료 버튼 클릭시 투표 비활성화
	$("#endVoteBtn").click(function() {
		if($("#voteCode").val() == null) {
			alert("투표정보가 없습니다");	
		} else if($("#isActivation").val() == 0) {
			alert("이미 비활성화 상태입니다.");
		} else {
			if(confirm("투표비활성화 하시겠습니까?")) {
				location.href = "EndVoteForThisSeason?vote_code=" + $("#voteCode").val();
			}
		}
	});
	
	// 상영예정작으로 등록 버튼 클릭시 해당영화 상영예정작의 season 무비로 등록
	$("#registUpcomingBtn").click(function() {
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