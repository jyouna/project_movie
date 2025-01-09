<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>관리자 계정 정보 변경</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_account_manage.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />	
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<style type="text/css">

#mainTable {
    width: 400px; /* 설정할 크기 */
    max-width: 100%; /* 테이블이 상위 요소를 초과하지 않도록 */
    table-layout: fixed;}

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

</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<h3>관리자 계정 정보 변경</h3>
	
	<form action="AdminAccountModify" name="adminModify" method="post" id="accountModifyForm">
		<table id="mainTable">
			<tr id="tr01">
				<th>ID</th>
				<td width="300">
					<input type="text" name="admin_id" value="${voList.admin_id}" maxlength="10" readonly>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" id="name" name="user_name" value="${voList.user_name}" maxlength="6" required>
					<div id="checkNameResult"></div>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" id="passwd" name="admin_passwd" value="${voList.admin_passwd}" maxlength="10" required>
					<div id="checkPasswdResult"></div>					
				</td>
			</tr>
			<tr>
				<th>계정|<br>통계관리</th>
				<td><input type="checkbox" name="member_manage" ${voList.member_manage ? 'checked' : ''}></td>
			</tr>
			<tr>
				<th>결제관리</th>
				<td><input type="checkbox" name="payment_manage" ${voList.payment_manage ? 'checked' : ''}></td>
			</tr>
			<tr>
				<th>게시판관리</th>
				<td><input type="checkbox" name="notice_board_manage" ${voList.notice_board_manage ? 'checked' : ''}></td>
			</tr>
			<tr>
				<th>영화관리</th>
				<td><input type="checkbox" name="movie_manage" ${voList.movie_manage ? 'checked' : ''}></td>
			</tr>
			<tr>
				<th>상영관관리</th>
				<td><input type="checkbox" name="theater_manage" ${voList.theater_manage ? 'checked' : ''}></td>
			</tr>
			<tr>
				<th>이벤트|<br>투표관리</th>
				<td><input type="checkbox" name="vote_manage" ${voList.vote_manage ? 'checked' : ''}></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="변경" class="btns">
					<input type="reset" value="초기화" class="btns">
					<input type="button" value="돌아가기" onclick="history.back()" class="btns">
				</td>
			</tr>
		</table>
	</form>
	<br>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>

</body>
</html>