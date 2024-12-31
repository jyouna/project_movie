<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>아이디/비밀번호 찾기</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/member_find_form.css">
</head>
<body>
  <div class="container">
    <h1>아이디/비밀번호 찾기</h1>
    <div class="tabs">
      <button id="find-id-tab" class="active">아이디 찾기</button>
      <button id="find-pw-tab">비밀번호 찾기</button>
    </div>

    <!-- 아이디 찾기 폼 -->
    <div id="find-id-form" class="form-container">
      <h2>아이디 찾기</h2>
      <label for="id-name">이름</label>
      <input type="text" id="id-name" placeholder="이름 입력" required>
      
      <label for="id-birthdate">생년월일</label>
      <input type="date" id="id-birthdate" required> <!-- 생년월일 추가 -->

    
      <label for="id-phone">휴대폰 번호</label>
      <input type="text" id="id-phone" placeholder="숫자만 입력" required>
      
      <button id="find-id-btn">아이디 찾기</button>
    </div>

    <!-- 비밀번호 찾기 폼 -->
    <div id="find-pw-form" class="form-container hidden">
      <h2>비밀번호 찾기</h2>
      <label for="pw-name">이름</label>
      <input type="text" id="pw-name" placeholder="이름 입력" required>

    <label for="pw-birthdate">생년월일</label>
     <input type="date" id="pw-birthdate" required> <!-- 생년월일 추가 -->
      
     <label for="pw-phone">휴대폰 번호</label>
     <input type="text" id="pw-phone" placeholder="숫자만 입력" required>
     <button id="send-code-btn">인증번호 발송</button>
      
      <label for="pw-code">인증번호 입력</label>
      <input type="text" id="pw-code" placeholder="인증번호 입력">
      
      
      <button id="find-pw-btn">비밀번호 찾기</button>
    </div>
  </div>
  <script src="${pageContext.request.contextPath}/resources/js/member/member_find_form.js"></script>
</body>
</html>
