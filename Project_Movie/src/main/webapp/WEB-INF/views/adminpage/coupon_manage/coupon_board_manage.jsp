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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/account_manage.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<h3>쿠폰 관리</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
			<input type="button" value="쿠폰발급" id="board_regis">
			<input type="button" value="쿠폰삭제" id="delete">
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
				<th width="150">선택</th>
				<th width="150">쿠폰번호</th>
				<th width="150">쿠폰타입</th>
				<th width="150">할인금액</th>
				<th width="150">할인율</th>
				<th width="200">등록일자</th>
				<th width="200">만료일자</th>
				<th width="200">사용일자</th>
				<th width="150">보유계정</th>
			</tr>
			<tr>
				<td><input type="checkbox"></td>
				<td>1</td>
				<td>할인권</td>
				<td>5000</td>
				<td></td>
				<td>2024.12.11</td>
				<td>2025.12.10</td>
				<td>미사용</td>
				<td>hoon1</td>
			</tr>
			<tr>
				<td><input type="checkbox"></td>
				<td>2</td>
				<td>할인권</td>
				<td></td>
				<td>20%</td>
				<td>2024.12.11</td>
				<td>2025.12.10</td>
				<td>미사용</td>
				<td>hoon2</td>
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
</body>
</html>