<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트 발급</title>
<style type="text/css">
form>div {
	background-color: lightgrey;
	padding: 30px;
	width: 800px;
	border: 1px solid red;
}

input[type="text"] {
	width: 200px;
	margin-bottom: 5px;
}

.bottom {
	padding: 10px;
	width: 100px;
	border-radius: 20px;
	border: 3px;
}

textarea {
     width: 100%; /* 너비 */
     height: 200px; /* 높이 */
     padding: 5px; /* 내부 여백 */
     box-sizing: border-box; /* 패딩과 보더를 포함한 크기 계산 */
     font-size: 16px; /* 폰트 크기 */
     line-height: 1.5; /* 줄 간격 */
     vertical-align: top; /* 상단 정렬 */
}

#divBottom {
	text-align: center;
	border: 1px solid red;
}

.date {
	border-radius: 20px;
	border: 3px;
	margin-left: 2px;
	margin-bottom: 5px;
}

#tableDiv {
	border: 1px solid red;
/* 	overflow-x: auto; */
}

#mainTable tr {
	background-color: white;
    border: 1px solid #ddd; /* 격자선 표시 */
}

#mainTable th, #mainTable td {
   text-align: center; /* 텍스트 가운데 정렬 */
   vertical-align: middle; /* 수직 가운데 정렬 */
   padding: 5px; /* 셀 안쪽 여백 */
}

#mainTable {
	border: 1px;
	width: 90%; /* 테이블이 화면의 100% 너비에 맞게 조정 */
	border-collapse: collapse; /* 경계선 겹침 제거 */
}

/* 호버 효과 */
tr:hover {
    background-color: #f9f9f9;
}

.btn {
	padding: 15px;
}

</style>
</head>
<body>
	<h3>포인트 발급</h3>
	<form action="submit">
		<div id="tableDiv">
			<table id="mainTable">
				<tr>
					<th>선택</th>
					<th>ID</th>
					<th>포인트 금액</th>
				</tr>
				<tr>
					<td><input type="checkbox"></td>				
					<td>hoon1</td>				
					<td><input type="text" placeholder="금액을 입력하세요."></td>				
				</tr>
				<tr>
					<td><input type="checkbox"></td>				
					<td>hoon2</td>				
					<td><input type="text" placeholder="금액을 입력하세요."></td>				
				</tr>
				<tr>
					<td><input type="checkbox"></td>				
					<td>hoon3</td>				
					<td><input type="text" placeholder="금액을 입력하세요."></td>				
				</tr>
			</table>
		</div>
		<div id="divBottom">
	 		<input type="submit" value="발급" class="btn">
	 		<input type="reset" value="초기화" class="btn">
	 		<input type="button" value="닫기" onclick="history.back()" class="btn">
		</div>
	</form>

</body>
</html>