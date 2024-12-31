<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>회원 정보 수정</title> <!-- ***** 수정전: Insert title here ***** 수정후: 회원 정보 수정 ***** -->
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/member_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<h2>회원 정보 수정</h2>
		<form action="MemberModify" method="post">
			<p>아이디: <input type="text" name="member_id" value="${member.member_id}" readonly></p> <!-- ***** 수정전: id ***** 수정후: member_id ***** -->
			<p>이름: <input type="text" name="member_name" value="${member.member_name}"></p> <!-- ***** 수정전: name ***** 수정후: member_name ***** -->
			<p>전화번호: <input type="text" name="phone" value="${member.phone}"></p>
			<p>비밀번호: <input type="password" name="new_passwd"></p>
			<input type="submit" value="수정">
		</form>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>
