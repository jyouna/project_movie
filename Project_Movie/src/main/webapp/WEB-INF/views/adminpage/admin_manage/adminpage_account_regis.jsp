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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_account_regis.css" rel="stylesheet" />
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<style>
.btn {
	padding:10px;
	border-radius: 20px;
	background-color: lightgrey;
	border: 3px;
}

#mainTable {
	border: 1px solid red;
}

#tr01 {
	background-color: lightgrey;
}

/* 호버 효과 */
tr:hover {
    background-color: #f9f9f9;
}

#mainTable th, #mainTable td {
   text-align: center; /* 텍스트 가운데 정렬 */
   vertical-align: middle; /* 수직 가운데 정렬 */
   padding: 5px; /* 셀 안쪽 여백 */
}
</style>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<article id="accountRegis">
	<h3>관리자 계정 생성</h3>
		<form action="accountRegis" name="joinForm" method="post">
			<table id="mainTable">
				<tr id="tr01">
					<th>ID</th>
					<td width="300">
						<input type="text" name="id" id="id" required>
						<div id="checkIdResult">중복검사 결과 출력</div>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" id="passwd" name="passwd" required>
						<div id="checkPasswdResult">비밀번호 검사 결과 출력</div>
					</td>
				</tr>
				<tr>
					<th>비밀번호확인</th>
					<td>
						<input type="password" id="passwd2" required>
						<div id="checkPasswd2Result">비밀번호 일치 여부 출력</div>
					</td>
				</tr>
				<tr>
					<th>권한설정</th>
					<td>
						<div>
							<input type="checkbox" id="event_manage" name="set_auth" value="event">
							<label for="event_manage">이벤트관리</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							
							<input type="checkbox" id="vote_manage" name="set_auth" value="vote">
							<label for="vote_manage">투표관리</label><br>
							
							<input type="checkbox" id="member_manage" name="set_auth" value="member">
							<label for="member_manage">회원목록관리</label>&nbsp;&nbsp;
							
							<input type="checkbox" id="theater_manage" name="set_auth" value="theater">
							<label for="theater_manage">상영관관리</label><br>
							
							<input type="checkbox" id="payment_manage" name="set_auth" value="payment">
							<label for="payment_manage">결제관리</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							
							<input type="checkbox" id="board_manage" name="set_auth" value="board">
							<label for="board_manage">고객지원관리</label><br>
							
							<input type="checkbox" id="movie_manage" name="set_auth" value="movie">
							<label for="movie_manage">영화관리</label>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="가입" class="btn">
						<input type="reset" value="초기화" class="btn">
						<input type="button" value="돌아가기" onclick="history.back()" class="btn">
					</td>
				</tr>
			</table>
		</form>
	</article>
		<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>














