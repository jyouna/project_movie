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
	<title>쿠폰 관리</title>
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
	width: 45%;
	border: 1px solid red;
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
	border: 2;
	hieght: 70%;
	width: 92%;
	margin-left: 30px;
/* 	overflow-x: auto; */
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

#divBottom>a:hover {
	background-color: lightgrey;
}

#mainTable th, #mainTable td {
   text-align: center; /* 텍스트 가운데 정렬 */
   vertical-align: middle; /* 수직 가운데 정렬 */
   padding: 5px; /* 셀 안쪽 여백 */
}

#mainTable {
	border: 1px solid red;
	width: 100%; /* 테이블이 화면의 100% 너비에 맞게 조정 */
	max-width: 1600px; /* 테이블 최대 너비 제한 */
	border-collapse: collapse; /* 경계선 겹침 제거 */
}

/* 호버 효과 */
tr:hover {
    background-color: #f9f9f9;
}

input[type="button"] {
	border-radius: 20px;
	border: 3px;
}

</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<h3>포인트 관리</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
			<input type="button" value="포인트발급" id="give_point">
			<input type="button" value="포인트회수" id="getback_point">
		</div>	
		<div id="divTopRight">
			<select>
				<option>제목+내용</option>
				<option>제목</option>
				<option>내용</option>
			</select>
			<input type="text" placeholder="검색어를입력하세요"> <input type="button" value="검색" id="searchBtn">
		</div>	
	</div>
	<div id="tableDiv" class="view" style="overflow-x: auto;">
		<table id="mainTable">
			<tr align="center" id="tr01">
				<th width="100">선택</th>
				<th width="350">ID</th>
				<th width="350">잔여포인트</th>
			</tr>
			<tr align="center" id="tr02">
				<td><input type="checkbox"></td>
				<td>hoon1</td>
				<td>25632</td>
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
		$("#give_point").on("click", function(){
			window.open(                
				'point_board_regis', // 팝업 창에 로드할 파일
	            '쿠폰 등록',    // 팝업 창 이름
	            'width=800,height=300,scrollbars=no,resizable=no');
		});	

		$("#getback_point").on("click", function(){
			confirm("포인트를 회수하시겠습니까?");
		});
		
		$("#searchBtn").on("click", function(){
			alert("검색 버튼 클릭됨");
		});
	});
	</script>
</body>
</html>