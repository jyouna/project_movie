<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>회원 정보</title> <!-- ***** 수정전: Insert title here ***** 수정후: 회원 정보 ***** -->
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/member_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<h2>회원 정보</h2> <!-- ***** 수정전: 없음 ***** 수정후: 제목 추가 ***** -->
		<p>아이디: ${member.member_id}</p> <!-- ***** 수정전: member.id ***** 수정후: member.member_id ***** -->
		<p>이름: ${member.member_name}</p> <!-- ***** 수정전: member.name ***** 수정후: member.member_name ***** -->
		<p>이메일: ${member.email}</p>
		<p>성별: ${member.gender}</p>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>
