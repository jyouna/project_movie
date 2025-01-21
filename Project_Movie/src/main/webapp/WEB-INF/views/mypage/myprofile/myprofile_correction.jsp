<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE HTML>
<html>
<head>
	<title>회원 정보 수정</title>
	<meta charset="utf-8" />
<!-- 	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" /> -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/member_join_form.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>	
<style type="text/css">
#mainDiv {
	width: 800px;
	text-align: center;
	transform: translate(150px, -100px);
}
th {
	width: 40%;
}
td {
	width: 60%;
}

h1 {
	font-size: 2em;
	font-weight: bold;
}

</style>
</head>

<body class="left-sidebar is-preload">
   <jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
<%--    <jsp:include page="/WEB-INF/views/inc/page/member_sidebar.jsp"></jsp:include> --%>
<div id="mainDiv">
	<h1>회원 정보 수정</h1>
	<article class="box post">
		<div class="container">
		<hr class="section-line"> 
			<div class="spacer"></div> 
			<form id="registerForm" action="UpdateMyInfo" method="get">
				<table class="form-table">
					<tr>
						<th>아이디 *</th>
						<td>
							<input type="text" id="id" name="member_id" value="${member.member_id}" readonly>
						</td>
					</tr>
					<tr>
						<th>기존비밀번호 *</th>
						<td>
							<input type="password" id="password" required>
							<div id="check_oldPasswd"></div> 
						</td>
					</tr>
					<tr>
						<th>새 비밀번호 *</th>
						<td>
							<input type="password" id="new_passwd" name="member_passwd" required>
							<div id="check_newPasswd"></div> <!-- 비밀번호 정규표현식 및 기존 비밀번호 중복 검사 결과 -->
						</td>	
					</tr>
					<tr>
						<th>새 비밀번호 확인 *</th>
						<td>
							<input type="password" id="new_passwd2" required>
							<div id="check_newPasswd2"></div> <!-- 비밀번호 확인 결과 -->
						</td>	
					</tr>
				</table>
				
				<table class="form-table">
					<tr>
						<th>이름 *</th>
						<td><input type="text" id="name" name="member_name" value="${member.member_name}" readonly></td>
					</tr>
					<tr>
						<th>생년월일 *</th>
						<td><input type="date" id="birthdate" name="birth_date" value="${member.birth_date}"></td>
					</tr>
					<tr>
						<th>이메일 *</th>
						<td>
							<input type="email" id="email" name="email" value="${member.email}" readonly>
						</td>
					</tr>
					<tr>
						<th>전화번호 *</th>
						<td>
							<input type="text" name="phone" value="${member.phone}">
						</td>
					</tr>
					<tr>
						<th>성별</th>
						<td>
							<c:choose>
							    <c:when test="${gender eq 'M'}">
							        <input type="text" name="gender" value="남" readonly>
							    </c:when>
							    <c:otherwise>
							        <input type="text" name="gender" value="여" readonly>
							    </c:otherwise>
							</c:choose>
						</td>
					</tr>
				</table>
						
				<table class="form-table">
					<tr>
						<th>관심장르</th>
						<td>
							<select id="genre" name="genre">
								
								<option value="" disabled selected>장르를 클릭하여 선택해주세요 </option> <!-- 기본 안내 옵션 -->
								<option value="드라마" <c:if test="${member.genre eq '드라마'}">selected</c:if>>드라마</option>
								<option value="애니메이션" <c:if test="${member.genre eq '애니메이션'}">selected</c:if>>애니메이션</option>
								<option value="액션" <c:if test="${member.genre eq '액션'}">selected</c:if>>액션</option>
								<option value="멜로/로맨스" <c:if test="${member.genre eq '멜로/로맨스'}">selected</c:if>>멜로/로맨스</option>
								<option value="코미디" <c:if test="${member.genre eq '코미디'}">selected</c:if>>코미디</option>
								<option value="스릴" <c:if test="${member.genre eq '스릴'}">selected</c:if>>스릴</option>
								<option value="다큐멘터리" <c:if test="${member.genre eq '다큐멘터리'}">selected</c:if>>다큐멘터리</option>
								<option value="기타" <c:if test="${member.genre eq '기타'}">selected</c:if>>기타</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>문자 수신 여부 (선택)</th>
						<td>
							<label><input type="checkbox" id="sms-receive" name="text_receive" value="true"
									<c:if test="${member.text_receive eq true}">checked</c:if>> 휴대폰 문자를 받겠습니다</label>
						</td>
					</tr>
					<tr>
						<th>이메일 수신 여부 (선택)</th>
						<td>
							<label><input type="checkbox" id="email-receive" name="email_receive" value="true"
									<c:if test="${member.email_receive eq true}">checked</c:if>>정보메일을 받겠습니다</label>
						</td>
					</tr>
					<tr>
						<th>정보 공개 여부 (선택)</th>
						<td>
							<label><input type="checkbox" id="info-open" name="info_open" value="true"
									<c:if test="${member.info_open eq true}">checked</c:if>> 다른분들이 나의 정보를 볼수있게 합니다.</label>
						</td>
					</tr>
				</table>
				<div class="button-group">
					<button type="submit" class="btn submit-btn">정보수정</button>
					<button type="button" id="cancel-btn" class="btn cancel-btn" onclick="history.back()">취소</button>
				</div>
			</form>
		</div>
	 </article>
</div>	 
<script type="text/javascript">
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
	
	
})
</script>

</body>
</html>

