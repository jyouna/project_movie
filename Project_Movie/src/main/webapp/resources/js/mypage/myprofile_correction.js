$(function(){
	let checkOldPasswdResult = false // 기존 비밀번호 검사
	let checkPasswdResult = false; // 신규 비밀번호 검사
	let checkPasswd2Result = false; // 비빌번호 다시 입력 검사
	
	// 기존 비밀번호 일치 여부 검사
	$("#password").on("blur", function(){
		let member_id = $("#id").val();
		let passwd = $(this).val();
		console.log("패스워드 : " + passwd);
		console.log("아이디 : " + id);
		
		$.ajax({
			url: "checkOldPasswd",
			type: "get",
			data: {
				passwd : passwd,
				member_id : member_id
			}		
		}).done(function(response){
			if(response) {
				checkOldPasswdResult = true;
				$("#check_oldPasswd").text("기존 비밀번호 일치").css("color", "blue");
				return;
			} else {
				checkOldPasswdResult = false;
				$("#check_oldPasswd").text("기존 비밀번호 불일치").css("color", "red");
				return;
			}
		});
	});
	
	// 신규 비밀번호 기존 비밀번호와 같거나 정규표현식에 맞지 않으면 경고 표시
	$("#new_passwd").on("blur", function(){
		let newPasswd = $(this).val();
		let member_id = $("#id").val();		
		let lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;
		let msg;
		let color;
		
		// 기존 비밀번호와 일치할 경우
		$.ajax({
			url: "checkOldPasswd",
			type: "get",
			data: {
				passwd : newPasswd,
				member_id : member_id
			}		
		}).done(function(result){
			if(result == true) {
				checkPasswdResult = false;
				$("#check_newPasswd").text("기존 비밀번호와 다른 비밀번호를 설정해주세요.").css("color", "red");
				return;
			}
		})
		
		// 신규 비밀번호 정규표현식 검사
		if(lengthRegex.exec(newPasswd)) {
			let count = 0; 
			let engUpperRegex = /[A-Z]/;
			let engLowerRegex = /[a-z]/;
			let numRegex = /[\d]/;
			let specRegex = /[!@#$%]/;
			
			if(engUpperRegex.exec(newPasswd)) { count++; } 
			if(engLowerRegex.exec(newPasswd)) { count++; }
			if(numRegex.exec(newPasswd)) { count++; }
			if(specRegex.exec(newPasswd)) { count++; }
			
			switch(count) {
				case 4 : 
					msg = "안전";
					color = "GREEN";
					checkPasswdResult = true;
					break;
				case 3 : 
					msg = "보통";
					color = "BLACK";
					checkPasswdResult = true;
					break;
				case 2 : 
					msg = "위험";
					color = "ORANGE";
					checkPasswdResult = true;
					break;
				case 1 : 
					msg = "사용 불가";
					color = "RED";
					checkPasswdResult = false;
			}
		} else {
			msg = "영문자, 숫자, 특수문자(!@#$%) 8~16 필수!";
			color = "RED";
			checkPasswdResult = false;
		}
		
		$("#check_newPasswd").text(msg).css("color", color);
		$("#new_passwd2").trigger("blur");
	});
	
	$("#new_passwd2").blur(function() {
		let new_passwd = $("#new_passwd").val();
		let new_passwd2 = $("#new_passwd2").val();
		
		if(new_passwd == new_passwd2) {
			$("#check_newPasswd2").text("비밀번호 일치").css("color", "BLUE");
			checkPasswd2Result = true;
		} else {
			$("#check_newPasswd2").text("비밀번호 불일치").css("color", "RED");
			checkPasswd2Result = false;
		}
	});
	// 회원정보 변경 폼 제출
	$("form").on("submit", function() {
		
		if(!checkOldPasswdResult){
			alert("기존 비밀번호를 다시 확인하세요.");
			$("#check_oldPasswd").focus();
			return false;
		}
		
		if(!checkPasswdResult) {
			alert("새 비밀번호를 다시 확인하세요.");
			$("#check_newPasswd").focus();
			return false;
		}
		
		if(!checkPasswd2Result) {
			alert("비밀번호 재입력 칸을 다시 확인하세요.");
			$("#check_newPasswd2").focus();
			return false;
		}
			
	});
	// 	회원 탈퇴 
	$("#MemberWithDraw").on("click", function() {
		if(confirm("정말 탈퇴 하시겠습니까?")){
			location.href = 'MemberWithDraw';
		}
	});
	
	
});