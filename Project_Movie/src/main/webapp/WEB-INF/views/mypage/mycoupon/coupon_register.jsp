<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 등록 창</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mycoupon/coupon_register.css" />
</head>
<body>
	<h3>쿠폰 등록</h3>
	<hr>
	<img alt="coupon" src="${pageContext.request.contextPath}/resources/images/coupon.png">
	<div id="content">
		발급 받으신 쿠폰 번호를 아래 창에 입력해주세요.
	</div>
	<input type="text" placeholder="쿠폰번호를 입력해주세요">
	<input type="submit" value="등록하기">
</body>
</html>