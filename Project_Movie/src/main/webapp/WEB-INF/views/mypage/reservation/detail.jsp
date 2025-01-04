<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매정보 상세조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/reservation/detail.css"/>
</head>
<body>
	<form>
		<h3>예매정보 상세조회</h3>
		<table>
			<tr>
				<td>예매번호:</td>
				<td>1111-2128</td>
			</tr>
			<tr>
				<td>영화명:</td>
				<td>소방관</td>
			</tr>
			<tr>
				<td>관람일:</td>
				<td>2024-12-25 15:30-17:26</td>
			</tr>
			<tr>
				<td>상영관:</td>
				<td>1관</td>
			</tr>
			<tr>
				<td>관람인원:</td>
				<td>일반 1매</td>
			</tr>
			<tr>
				<td>좌석:</td>
				<td>F 05</td>
			</tr>
		</table>
		<hr>
		<h3>취소환불규정안내</h3>
		
		<div id= "content">
			취소 마감시간은 전일17시(월~토 관람 시)/전일 11시(일요일 관람 시)입니다.
			관람일 전일 오후 5시 이후(일요일은 오전 11시) 또는 관람일 당일 예매하신 건에 대해서는 예매 후 취소∙변경∙환불이 불가합니다.
			토요일이 공휴일인 경우 토요일 오전 11시 기준으로 적용됩니다.
		</div>
		<br>
		<div style="text-align: right;">
			<button onclick="window.close();">닫기</button>
		</div>
	</form>

</body>
</html>