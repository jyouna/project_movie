<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> ID 조회</title>
<style>
.btn {
	padding:5px;
	border-radius: 20px;
	border: 3px;
}
</style>
</head>
<body>
	<form action="submit">
		<h3>ID 조회</h3>
		<input type="text" placeholder="id를 입력하세요.">
		<input type="submit" value="검색" class="btn">
		<input type="button" value="취소" onclick="window.close()" class="btn">
	</form>
</body>
</html>