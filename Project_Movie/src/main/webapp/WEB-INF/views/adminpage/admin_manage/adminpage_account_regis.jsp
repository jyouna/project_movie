<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>관리자페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<style type="text/css">

#mainArticle {
/* 	border: 1px solid; */
	text-align: center;
}

h3 {
	margin-top: 1em;
}

#mainTable {
    width: 600px;
    max-width: 100%;
    table-layout: fixed;
    transform: translate(530px, 20px);
    height: 700px;
   	position: absolute;
    }

#mainTable th, 
#mainTable td {
    border: 1px solid lightgrey !important;
    text-align: center !important;
    padding: 5px !important;
	vertical-align: middle !important; /* 수직 가운데 정렬 */
	padding: 5px !important;}

tr:hover {
    background-color: #f9f9f9 !important;}

#tr01 {
	background-color: l#f9f9f9 !important;}
   
.btns {
	padding:5px !important;
	border-radius: 20px !important;
	border: 3px !important;
	background-color: lightgrey;}
	
input[type="checkbox"] {
    transform: scale(1.5); /* 1.5배 확대 */
    margin: 5px; /* 크기가 커지면서 생기는 여백을 조정 */
}
</style>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<article id="mainArticle">
	<h3>관리자 계정 생성</h3>
		<form action="AdminAccountRegis" name="joinForm" ID="accountRegisForm" method="post">
			<table id="mainTable">
				<tr id="tr01">
					<th>ID</th>
					<td>
						<input type="text" name="admin_id" id="id" maxlength="10" required>
						<div id="checkIdResult"></div>
						<div id="checkIdResult2"></div>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td width="300">
						<input type="text" name="user_name" id="name" maxlength="6" required>
						<div id="checkNameResult"></div>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" id="passwd" name="admin_passwd" maxlength="10" required>
						<div id="checkPasswdResult"></div>
					</td>
				</tr>
				<tr>
					<th>비밀번호확인</th>
					<td>
						<input type="password" id="passwd2" maxlength="10" required>
						<div id="checkPasswd2Result"></div>
					</td>
				</tr>
				<tr>
					<th>회원목록관리</th>
					<td><input type="checkbox" name="member_manage"></td>
				</tr>
				<tr>
					<th>결제관리</th>
					<td><input type="checkbox" name="payment_manage"></td>
				</tr>
				<tr>
					<th>게시판관리</th>
					<td><input type="checkbox" name="notice_board_manage"></td>
				</tr>
				<tr>
					<th>영화관리</th>
					<td><input type="checkbox" name="movie_manage"></td>
				</tr>
				<tr>
					<th>상영관관리</th>
					<td><input type="checkbox" name="theater_manage"></td>
				</tr>
				<tr>
					<th>투표관리</th>
					<td><input type="checkbox" name="vote_manage" ></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="가입" class="btns">
						<input type="reset" value="초기화" class="btns">
						<input type="button" value="돌아가기" onclick="history.back()" class="btns">
					</td>
				</tr>
			</table>
		</form>
	</article>
		<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
	<!-- 중복 아이디 체크 --> 
	<script type="text/javascript">
		$(function(){
			let check_id1 = false;
			let check_id2 = false;
			let check_name = false;
			let check_passwd = false;
			let check_passwd2 = false;
			
			$("#id").on("blur", function(){
				let regexId = /^admin\d{0,5}$/;
				let ids = $("#id").val();
	
				if(regexId.exec(ids)) {
					check_id1 = true;
					$("#checkIdResult2").text("아이디 양식 일치").css("color", "blue");
				} else {
					check_id1 = false;
					$("#checkIdResult2").text("ID 양식 : admin + 0~99999").css("color", "red");
				}
				
				$.ajax({
					type:"GET",
					url:"AdminIdCheck",
					data : {
						id : $("#id").val()
					},
					dataType : "json",
					success : function(response){
						if(response.checkIdResult=="사용 가능한 아이디") {
							check_id2 = true;
						} else {
							check_id2 = false;
						}
						$("#checkIdResult").text(response.checkIdResult);
					}
				});
			});
			
			$("#passwd").on("blur", function(){
				let regexPasswd = /^[a-z0-9]{8,10}$/;
				let passwds = $("#passwd").val();
				
				if(regexPasswd.exec(passwds)) {
					check_passwd = true;
					$("#checkPasswdResult").text("비밀번호 양식 일치").css("color", "blue");
				} else {
					check_passwd = false;
					$("#checkPasswdResult").text("p/w: 소문자와 숫자만 사용 8~10자리").css("color", "red");
				}
				$("#passwd2").trigger("blur");
			});
			
			$("#passwd2").on("blur", function(){
				let passwd = $("#passwd").val();
				let passwd2 = $("#passwd2").val();
				
				if(passwd==passwd2) {
					check_passwd2 = true;
					$("#checkPasswd2Result").text("비밀번호가 일치합니다.").css("color","green");
				} else {
					check_passwd2 = false;
					$("#checkPasswd2Result").text("비밀번호가 일치하지 않습니다.").css("color","red");
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
					$("#checkNameResult").text("이름 : 관리자 + 1~999 형태").css("color", "red");
				}
			});
			
			
			$("#accountRegisForm").on("submit", function(event){
				event.preventDefault();
				
				 if (check_id1 && check_id2 && check_name && check_passwd && check_passwd2) {
				        this.submit();
			    } else {
			        // 조건이 충족되지 않으면 경고창 표시
			        alert("제출된 양식을 다시 확인하세요.");
			    }
			});
		});
	</script>
</body>
</html>














