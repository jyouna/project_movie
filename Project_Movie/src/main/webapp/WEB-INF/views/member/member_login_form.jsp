<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Escape Velocity by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
<%-- 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/member_join_form.css" /> --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/member_login_form.css" />
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	
	<jsp:include page="/WEB-INF/views/inc/page/member_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		
		<div class="container">

    <!-- 사이드바 메뉴 -->
<%--     <jsp:include page="/WEB-INF/views/inc/page/member_sidebar.jsp"></jsp:include> --%>

    <!-- 메인 콘텐츠 -->
    <main class="content">
      <h1>로그인</h1>

      <!-- ★ 추가된 부분: 로그인과 안내사항을 반반 나누는 div 추가 -->
      <div class="split-box">

        <!-- 로그인 섹션 -->
        <div class="login-box">
          <h2 class="section-title"></h2>
          <label for="username">아이디 입력</label>
          <input type="text" id="username" placeholder="ID" />

          <label for="password">비밀번호 입력</label>
          <input type="password" id="password" placeholder="PASSWORD" />

         <!-- 아이디 저장 체크박스 -->
			<div class="save-id">
			  <input type="checkbox" id="save-id">
			  <label for="save-id">아이디 저장</label>
			  <a href="${pageContext.request.contextPath}/MemberFindForm" class="link">ID/PW찾기</a> |
			  <a href="${pageContext.request.contextPath}/MemberAgree" class="link">회원가입</a>
			</div>



          <!-- 로그인 버튼 -->
          <button id="login-btn">로그인</button>

          <!-- ★ 추가된 부분: 소셜 로그인 섹션 -->
          <div class="social-login">
            <img src="${pageContext.request.contextPath}/resources/images/naver_icon.png" alt="Naver Login" class="social-btn" />
            <img src="${pageContext.request.contextPath}/resources/images/kakao_icon.jpg" alt="Kakao Login" class="social-btn" />
          </div>
        </div>

        <!-- 안내사항 섹션 -->
        <div class="info-box">
          <h2 class="section-title">Movie</h2>

          <!-- ★ 수정된 부분: 안내 이미지 추가 -->
			<img src="${pageContext.request.contextPath}/resources/images/movielogo.png" 
			  alt="안내 이미지" >
 <!-- 			  style="width: 80%; height: auto; border-radius: 5px;"> -->
        </div>
      </div>
      <!-- ★ 추가 끝 -->
    </main>
  </div>
	
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	<script src="${pageContext.request.contextPath}/resources/js/member/member_login_form.js"></script>
</body>
</html>

