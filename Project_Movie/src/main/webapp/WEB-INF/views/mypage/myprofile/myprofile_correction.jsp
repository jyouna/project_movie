<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html lang="en">
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>마이페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/mypage/myprofile_correction.css" rel="stylesheet" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/mypage/myprofile_correction.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
	<div id="mainDiv">
		<article class="box post">
			<div class="container">
				<hr class="section-line"> 
				<div class="spacer"></div> 
					<h1>회원 정보 수정</h1>
					<form id="registerForm" action="UpdateMyInfo" method="get">
						<table class="form-table">
							<tr>
								<th>아이디 *</th>
								<td>
									<input type="text" id="id" name="member_id" value="${member.member_id}" readonly>
								</td>
							</tr>
							<tr>
								<th>기존비밀번호 *</th>
								<td>
									<input type="password" id="password" required>
									<div id="check_oldPasswd"></div> 
								</td>
							</tr>
							<tr>
								<th>새 비밀번호 *</th>
								<td>
									<input type="password" id="new_passwd" name="member_passwd" required>
									<div id="check_newPasswd"></div> <!-- 비밀번호 정규표현식 및 기존 비밀번호 중복 검사 결과 -->
								</td>	
							</tr>
							<tr>
								<th>새 비밀번호 확인 *</th>
								<td>
									<input type="password" id="new_passwd2" required>
									<div id="check_newPasswd2"></div> <!-- 비밀번호 확인 결과 -->
								</td>	
							</tr>
						</table>
						
						<table class="form-table">
							<tr>
								<th>이름 *</th>
								<td><input type="text" id="name" name="member_name" value="${member.member_name}" readonly></td>
							</tr>
							<tr>
								<th>생년월일 *</th>
								<td><input type="date" id="birthdate" name="birth_date" value="${member.birth_date}"></td>
							</tr>
							<tr>
								<th>이메일 *</th>
								<td>
									<input type="email" id="email" name="email" value="${member.email}" readonly>
								</td>
							</tr>
							<tr>
								<th>전화번호 *</th>
								<td>
									<input type="text" name="phone" value="${member.phone}" readonly="readonly">
								</td>
							</tr>
							<tr>
								<th>성별</th>
								<td>
									<c:choose>
									    <c:when test="${gender eq 'M'}">
									        <input type="text" name="gender" value="남" readonly>
									    </c:when>
									    <c:otherwise>
									        <input type="text" name="gender" value="여" readonly>
									    </c:otherwise>
									</c:choose>
								</td>
							</tr>
						</table>
								
						<table class="form-table">
							<tr>
								<th>관심장르</th>
								<td>
									<select id="genre" name="genre">
										
										<option value="" disabled selected>장르를 클릭하여 선택해주세요 </option> <!-- 기본 안내 옵션 -->
										<option value="드라마" <c:if test="${member.genre eq '드라마'}">selected</c:if>>드라마</option>
										<option value="애니메이션" <c:if test="${member.genre eq '애니메이션'}">selected</c:if>>애니메이션</option>
										<option value="액션" <c:if test="${member.genre eq '액션'}">selected</c:if>>액션</option>
										<option value="멜로/로맨스" <c:if test="${member.genre eq '멜로/로맨스'}">selected</c:if>>멜로/로맨스</option>
										<option value="코미디" <c:if test="${member.genre eq '코미디'}">selected</c:if>>코미디</option>
										<option value="스릴" <c:if test="${member.genre eq '스릴'}">selected</c:if>>스릴</option>
										<option value="다큐멘터리" <c:if test="${member.genre eq '다큐멘터리'}">selected</c:if>>다큐멘터리</option>
										<option value="기타" <c:if test="${member.genre eq '기타'}">selected</c:if>>기타</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>문자 수신 여부 (선택)</th>
								<td>
									<label><input type="checkbox" id="sms-receive" name="text_receive" value="true"
											<c:if test="${member.text_receive eq true}">checked</c:if>> 휴대폰 문자를 받겠습니다</label>
								</td>
							</tr>
							<tr>
								<th>이메일 수신 여부 (선택)</th>
								<td>
									<label><input type="checkbox" id="email-receive" name="email_receive" value="true"
											<c:if test="${member.email_receive eq true}">checked</c:if>>정보메일을 받겠습니다</label>
								</td>
							</tr>
							<tr>
								<th>정보 공개 여부 (선택)</th>
								<td>
									<label><input type="checkbox" id="info-open" name="info_open" value="true"
											<c:if test="${member.info_open eq true}">checked</c:if>> 다른분들이 나의 정보를 볼수있게 합니다.</label>
								</td>
							</tr>
						</table>
						<div class="button-group">
							<button type="button" id="MemberWithDraw" onclick="withDraw()">회원탈퇴</button>
							<button type="submit" class="btn submit-btn">정보수정</button>
							<button type="button" id="cancel-btn" class="btn cancel-btn" onclick="history.back()">취소</button>
						</div>
					</form>
			</div>
	 </article>
</div>	 
	<script type="text/javascript">
		// 	회원 탈퇴 
		function withDraw() {
			if(confirm("정말 탈퇴 하시겠습니까?")){
				location.href = 'MemberWithDraw?member_id=${member.member_id}';
			}
		}
	</script>

</body>
</html>

