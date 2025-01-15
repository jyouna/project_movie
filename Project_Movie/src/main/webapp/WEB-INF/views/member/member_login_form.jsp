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

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/member_sidebar.jsp"></jsp:include>
	
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
           <form action="MemberLogin" method="post" id="loginForm">
          
          <!-- $$$$$ 수정 1: name 속성 추가 및 쿠키 값 처리 $$$$$ -->
          <label for="member_id">아이디 입력</label>
          <input type="text" id="member_id" name="member_id" 
                 value="<c:out value='${cookie.rememberId.value}' default=''/>" placeholder="ID" />

          <!-- $$$$$ 수정 1: name 속성 추가 $$$$$ -->
          <label for="member_passwd">비밀번호 입력</label>
          <input type="password" id="member_passwd" name="member_passwd" placeholder="PASSWORD" />

         <!-- 아이디 저장 체크박스 -->
         <!-- $$$$$ 수정 1: 체크박스 checked 속성 수정 $$$$$ -->
			<div class="save-id">
			  <input type="checkbox" id="rememberId" name="rememberId"
			  <c:if test="${not empty cookie.rememberId.value}">checked="checked"</c:if>>
			  <label for="rememberId">아이디 저장</label>
			  <a href="${pageContext.request.contextPath}/MemberFind" class="link">ID/PW찾기</a> |
			  <a href="${pageContext.request.contextPath}/MemberAgree" class="link">회원가입</a>
			</div>

          <!-- $$$$$ 수정 2: 로그인 버튼 타입 명시 $$$$$ -->
          <button type="submit" id="login-btn">로그인</button>
           </form>

          <!-- 소셜 로그인 섹션 -->
          <div class="social-login">
            <img src="${pageContext.request.contextPath}/resources/images/naver_icon.png" alt="Naver Login" class="social-btn" />
            <img src="${pageContext.request.contextPath}/resources/images/kakao_icon.jpg" alt="Kakao Login" class="social-btn" />
          </div>
        </div>

        <!-- 안내사항 섹션 -->
        <div class="info-box">
          <h2 class="section-title">Movie</h2>

          <!-- 안내 이미지 -->
			<img src="${pageContext.request.contextPath}/resources/images/movielogo.png" 
			  alt="안내 이미지">
        </div>
      </div>
    </main>
  </div>

	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	<script src="${pageContext.request.contextPath}/resources/js/member/member_login_form.js"></script>
</body>
</html>
