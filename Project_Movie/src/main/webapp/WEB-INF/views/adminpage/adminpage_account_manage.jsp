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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_account_manage.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/account_manage.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<style>
h3 {
	margin-left: 30px;
	margin-top: 20px;
	margin-bottom: 20px;
}

#divTop>div {
	display: inline-block;
	width: 44%;
}

#divTopLeft {
	margin-left: 30px;
	margin-bottom: 5px;
	text-align: left;
	border: 1px solid red;
}

#divTopRight {
	margin-left: 30px;
	margin-bottom: 5px;
	text-align: right;
	border: 1px solid red;
}
.topRight {
	margin-left: 6px;
}

#tableDiv {
	border: 2px solid red;
	hieght: 70%;
	width: 90%;
	border: 1px solid yellow;
	margin-left: 30px;
/* 	overflow-x: auto; */
}

#mainTable {
	width: 100%;
	border: 1px solid red;
}

#tr01 {
	background-color: lightgrey;
	text-align: center;
	font-size: 0.8em;
}

#mainTable tr {
	background-color: white;
    border: 1px solid #ddd; /* 격자선 표시 */
}

/* 호버 효과 */
tr:hover {
    background-color: #f9f9f9;
}

.tdtr {
    line-height: 30px;	
}

#divBottom {
	text-align: center;
}

#divBottom>a {
	padding: 0.2em;
	text-decoration: none;
}

#mainTable th, #mainTable td {
   text-align: center; /* 텍스트 가운데 정렬 */
   vertical-align: middle; /* 수직 가운데 정렬 */
   padding: 5px; /* 셀 안쪽 여백 */
}


#divBottom>a:hover {
	background-color: lightgrey;
}

input[type="button"] {
	border-radius: 20px;
	border:3px;
	padding:5px;
}

</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<h3>관리자 계정관리</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
			<input type="button" value="ID조회" id="idSearch">
		</div>	
		<div id="divTopRight">
			<input type="button" value="권한설정" class="topRight" id="setAuth">
			<input type="button" value="계정생성" class="topRight" id="createId">
			<input type="button" value="계정삭제" class="topRight" id="deleteId">
		</div>	
	</div>
	<div id="tableDiv" class="view">
		<table id="mainTable">
			<tr align="center" id="tr01">
				<th width="50">선택</th>
				<th width="90">ID</th>
				<th width="90">비밀번호</th>
				<th width="200">사용시작일</th>
				<th width="80">사용종료일</th>
				<th width="80">사용상태</th>
				<th width="80">담당자</th>
				<th width="80">이벤트관리</th>
				<th width="90">회원목록관리</th>
				<th width="80">결제관리</th>
				<th width="80">영화관리</th>
				<th width="80">상영관관리</th>
				<th width="80">투표관리</th>
				<th width="80">게시판관리</th>
			</tr>
			<tr align="center" class="tdtr">
				<td><input type="checkbox"></td>
				<td>admin01</td>
				<td>admin01#</td>
				<td>2024-12-15 09:11:11</td>
				<td>사용 중</td>
				<td>사용 중</td>
				<td>정영훈</td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
			</tr>
			<tr align="center" class="tdtr">
				<td><input type="checkbox"></td>
				<td>admin01</td>
				<td>admin01#</td>
				<td>2024-12-15 09:11:11</td>
				<td>사용 중</td>
				<td>사용 중</td>
				<td>정영훈</td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
			</tr>
			<tr align="center" class="tdtr">
				<td><input type="checkbox"></td>
				<td>admin01</td>
				<td>admin01#</td>
				<td>2024-12-15 09:11:11</td>
				<td>사용 중</td>
				<td>사용 중</td>
				<td>정영훈</td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
				<td><input type="checkbox"></td>
			</tr>
		
		</table>
	</div>
	<br>
	<div id="divBottom" class="view">
		<a href="#">1</a>
		<a href="#">2</a>
		<a href="#">3</a>
		<a href="#">4</a>
		<a href="#">5</a>
	</div>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
	
	<script type="text/javascript">
	$(function(){
		$("#idSearch").on("click", function(){
			window.open(                
				'idSearch', // 팝업 창에 로드할 파일
	            'ID 조회',    // 팝업 창 이름
	            'width=300,height=150,scrollbars=no,resizable=no');
		});	
		
		$("#setAuth").on("click", function(){
			confirm("권한을 설정하시겠습니까?");
		});

		$("#createId").on("click", function(){
			location.href="AccountRegis";
		});

		$("#deleteId").on("click", function(){
			confirm("해당 계정을 삭제하시겠습니까? 되돌릴 수 없습니다.");
		});
	});
	
	</script>
</body>
</html>