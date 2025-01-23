<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 등록 창</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/movie_log/review_register.css"/>
</head>
<body>
	<form>
		<h3>리뷰 등록</h3>
		<table>
			<tr>
				<td>영화 제목</td>
			</tr>
			<tr>
				<td><input type="radio" name="radio">추천</td>
				<td><input type="radio" name="radio">비추천</td>
			</tr>
			<tr>
				<td>한줄평 </td>
			</tr>
			<tr>
				<td><input type="text" ></td>
			</tr>
		</table>
		<div id="button_div">
			<input type="submit" value="등록" >
			<input type="button" value="취소" onclick="window.close();">
		</div>
	</form>
</body>
</html>