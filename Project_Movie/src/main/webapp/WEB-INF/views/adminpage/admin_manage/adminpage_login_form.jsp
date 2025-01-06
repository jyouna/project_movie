<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE HTML>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/member_login_form.css" />
</head>
<body class="left-sidebar is-preload">
	
	<article class="box post">
		<div class="container">

    <!-- 메인 콘텐츠 -->
    <main class="content">
      <h1>로그인</h1>

      <div class="split-box">

        <!-- 로그인 섹션 -->
        <div class="login-box">
          <h2 class="section-title"></h2>
          
          <!-- $$$$$ 수정: 폼 요소 name 속성 추가하여 VO 매핑 오류 수정 $$$$$ -->
           <form action="AdminLogin" method="post" id="admin_loginForm">
          
          <!-- $$$$$ 수정 1: name 속성 추가 및 쿠키 값 처리 $$$$$ -->
          <label for="admin_id">아이디 입력</label>
          <input type="text" id="admin_id" name="admin_id">

          <!-- $$$$$ 수정 1: name 속성 추가 $$$$$ -->
          <label for="admin_passwd">비밀번호 입력</label>
          <input type="password" id="admin_passwd" name="admin_passwd"/>

          <button type="submit" id="login-btn">로그인</button>
          </form>

        </div>
      </div>
    </main>
  </div>

	</article>

</body>
</html>
