<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  
  <title>아이디찾기</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/member_find_form.css">
</head>


<body>

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	
	<div class = "gap">
		<div class="sidebar1">	
    		<jsp:include page="/WEB-INF/views/inc/page/member_sidebar.jsp"></jsp:include>
		</div>
  	



  <input type="hidden" id="member_id" value="${member_id != null ? member_id : ''}">
  <input type="hidden" id="error_msg" value="${errorMsg != null ? errorMsg : ''}">
    
  <div class="container1">
    <h1> 아이디 / 비밀번호 찾기 </h1>
    
	<div class="tabs">
	  <button id="find-id-tab" class="" onclick="location.href='${pageContext.request.contextPath}/MemberFind'">아이디 찾기</button>
	  <button id="find-pw-tab" class="" onclick="location.href='${pageContext.request.contextPath}/MemberFindPasswd'">비밀번호 찾기</button>
	</div>


<form id="MemberFindId" action="MemberFind" method="post">
    <!-- 아이디 찾기 폼 -->
    <div id="find-id-form" class="form-container">
      <h2></h2>
      <label for="member_name">이름</label>
      <input type="text" id="member_name"  name="member_name" placeholder="" autocomplete="name" required>
<!--       id-name to name -->
      
      <label for="birth_date">생년월일</label>
      <input type="date" id="birth_date" name="birth_date" autocomplete="birth_date" required> <!-- 생년월일 추가 -->

    
      <label for="email">이메일</label>
      <input type="text" id="email" name="email" placeholder="ex) xxx@gmail.com"  autocomplete="email" required>
      
      <button id="find-id-btn">아이디 찾기</button>
      
       <a href="${pageContext.request.contextPath}/MemberLogin" class="link">로그인</a>
    </div>

</form>


  </div>
 
  </div>
  
  
  <jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
  <script src="${pageContext.request.contextPath}/resources/js/member/member_find_form.js"></script>
</body>
</html>
