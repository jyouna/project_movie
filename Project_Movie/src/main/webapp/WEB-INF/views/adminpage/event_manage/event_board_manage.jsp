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
	<title>이벤트관리</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_account_manage.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/account_manage.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<h3>이벤트 관리</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
			<input type="button" value="전체선택" id="selectAll">
			<input type="button" value="등록하기" id="board_regis">
			<input type="button" value="수정하기" id="board_modify">
			<input type="button" value="삭제하기" id="delete">
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
				<th width="50">선택</th>
				<th width="50">번호</th>
				<th width="350">제목</th>
				<th width="150">등록일자</th>
				<th width="150">시작일자</th>
				<th width="150">종료일자</th>
				<th width="150">등록계정</th>
			</tr>
			<tr>
				<td><input type="checkbox"></td>
				<td>1</td>
				<td>6월 진행 이벤트 공지</td>
				<td>2024.05.11</td>
				<td>2024.06.01</td>
				<td>2024.06.31</td>
				<td>admin</td>
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
// 	$(function(){
// 		$("#board_regis").on("click", function(){
// 			window.open(                
// 				'EventBoardRegis', // 팝업 창에 로드할 파일
// 	            '이벤트 등록',    // 팝업 창 이름
// 	            'width=850,height=500,scrollbars=no,resizable=no');
// 		});	
		
// 		$("#selectAll").on("click", function(){
// 			alert("전체 선택 클릭됨");
// 		});
		
// 		$("#searchBtn").on("click", function(){
// 			alert("검색 버튼 클릭됨");
// 		});

// 		$("#board_modify").on("click", function(){
// 			window.open(                
// 				'EventBoardModify', // 팝업 창에 로드할 파일
// 	            '이벤트 수정',    // 팝업 창 이름
// 	            'width=850,height=500,scrollbars=no,resizable=no');
// 		});

// 		$("#delete").on("click", function(){
// 			confirm("삭제하시겠습니까?");
// 		});
// 	});
	</script>
</body>
</html>