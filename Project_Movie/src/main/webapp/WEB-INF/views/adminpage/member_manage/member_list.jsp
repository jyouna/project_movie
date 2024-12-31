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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_member_list.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/account_manage.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<h3>회원 정보 조회</h3>
	<div id="divTop">
		<div id="divTopLeft">
			<input type="button" value="전체조회" id="listSearch">
			<input type="button" value="ID 조회" id="idSearch">
		</div>		
	</div>
	<div id="tableDiv">
		<table id="mainTable" border="1">
			<tr align="center">
				<th width="80">ID</th>
				<th width="120">이름</th>
				<th width="150">생년월일</th>
				<th width="150">이메일</th>
				<th width="150">연락처</th>
				<th width="80">성별</th>
				<th width="200">관심장르</th>
				<th width="150">가입일자</th>
				<th width="150">탈퇴일자</th>
			</tr>
			<tr>
				<td>hoon1</td>
				<td>정영훈</td>
				<td>2024.12.15</td>
				<td>itwill@gmail.com</td>
				<td>01012345678</td>
				<td>남</td>
				<td>코미디, 액션</td>
				<td>2024.12.24</td>
				<td>사용중</td>
			</tr>	
			<tr>
				<td>hoon1</td>
				<td>정영훈</td>
				<td>2024.12.15</td>
				<td>itwill@gmail.com</td>
				<td>01012345678</td>
				<td>남</td>
				<td>코미디, 액션</td>
				<td>2024.12.24</td>
				<td>사용중</td>
			</tr>	
			<tr>
				<td>hoon1</td>
				<td>정영훈</td>
				<td>2024.12.15</td>
				<td>itwill@gmail.com</td>
				<td>01012345678</td>
				<td>남</td>
				<td>코미디, 액션</td>
				<td>2024.12.24</td>
				<td>사용중</td>
			</tr>	
		</table>
	</div>
	<br>
	<div id="divBottom">
		<a href="#">1</a>
		<a href="#">2</a>
		<a href="#">3</a>
		<a href="#">4</a>
		<a href="#">5</a>
	</div>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
	
	<script type="text/javascript">
	$(function(){
		$("#listSearch").on("click", function(){
			alert("전체 목록을 출력했습니다.");
		});
		
		$("#idSearch").on("click", function(){
			window.open(                
				'IdSearch', // 팝업 창에 로드할 파일
	            'ID 조회',    // 팝업 창 이름
	            'width=300,height=150,scrollbars=no,resizable=no');
		});	
	});
	
	</script>
</body>
</html>