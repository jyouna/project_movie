function adminLogout() {
	if(confirm("로그아웃 하시겠습니까?")) {
		$.ajax({
			type : "GET",
			url : "AdminLogout",
			success : function(response){
				if(response) {
					window.close();
				}  else {
                    alert("로그아웃 오류");
                }
			} 
		});
	}
}

$(function(){ // 관리자 정보 변경시 사용
	let check_name = true; // false로 되어있으면 변경된 내용이 없는 경우에도 각 입력창을 focus하여 값을 true로 변경 시켜야만 submit 가능함!! 
	let check_passwd = true;
	
	$("#passwd").on("blur", function(){
		let regexPasswd = /^[a-z0-9]{8,10}$/;
		let passwds = $("#passwd").val();
		
		if(regexPasswd.exec(passwds)) {
			check_passwd = true;
			$("#checkPasswdResult").text("비밀번호 양식 일치").css("color", "blue");
		} else {
			check_passwd = false;
			$("#checkPasswdResult").text("비밀번호 양식 불일치").css("color", "red");
		}
	});
	
	$("#name").on("blur", function(){
		let name = $("#name").val();
		let regexName = /^관리자\d{1,3}$/;
		
		if(regexName.exec(name)) {
			check_name = true;
			$("#checkNameResult").text("사용 가능").css("color", "blue");
		} else {
			check_name = false;
			$("#checkNameResult").text("사용 불가능").css("color", "red");
		}
	});
	
	$("#accountModifyForm").on("submit", function(event){
		event.preventDefault();
		 if (check_name && check_passwd) {
		        this.submit();
	    } else {
	        // 조건이 충족되지 않으면 경고창 표시
	        alert("제출된 양식을 다시 확인하세요.");
	    }
	});
	
	$("#accountModifyForm").on("reset", function () {
	    setTimeout(function () {
	        $("#name").trigger("blur");
	        $("#passwd").trigger("blur");
	    }, 0); // 초기화된 값을 반영한 뒤 실행
	});
});