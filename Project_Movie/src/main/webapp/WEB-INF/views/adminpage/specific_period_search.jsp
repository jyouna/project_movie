<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 기간 조회</title>
<style>
form {
	width:300px;
	height:200px;
	text-align: center;
}
</style>
</head>
<body>
	<form action="submit" method="get">
	<h3> 상세 기간 조회 </h3>
 		시작일 <input type="date"><input type="button" value="입력">
 		<br>
 		종료일 <input type="date"><input type="button" value="입력">
 		<br>
 		<input type="submit" value="제출">
 		<input type="reset" value="초기화">
 		<input type="button" value="닫기" onclick="window.close()">
	</form>	
</body>
</html>