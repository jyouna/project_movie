<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>회원목록</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_member_list.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/account_manage.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<h3>회원 정보 조회</h3>
	<div id="divTop">
		<div id="divTopLeft">
			<input type="button" value="전체조회" id="listSearch">
			<input type="button" value="ID 조회" id="idSearch">
		</div>		
	</div>
	<div id="tableDiv">
		<table id="mainTable" border="1">
			<tr align="center">
				<th>아이디</th>
<!-- 				<th>비밀번호</th> -->
				<th>이름</th>
				<th>생년월일</th>
				<th>이메일</th>
				<th>연락처</th>
				<th>성별</th>
				<th>관심장르</th>
				<th>문자수신</th>
				<th>이메일수신</th>
				<th>정보공개</th>
				<th>이메일인증</th>
				<th>연락처인증</th>
				<th>회원유형</th>
				<th>포인트</th>
				<th>쿠폰</th>
				<th>회원상태</th>
			</tr>
			<c:choose>
				<c:when test="${empty memberAllInfo}">
					<tr>
						<th colspan="17">등록된 회원이 없습니다</th>
					</tr>
				</c:when>
			<c:otherwise>
				<c:forEach var="member" items="${memberAllInfo}" varStatus="status">
					<tr>
						<td>${member.member_id}</td>
<%-- 						<th>${member.member_passwd}</th> --%>
						<td>${member.member_name}</td>
						<td>${member.birth_date}</td>
						<td>${member.email}</td>
						<td>${member.phone}</td>
						<td>
							<c:if test="${member.gender eq 'M'}">
								남
							</c:if>
							<c:if test="${member.gender eq 'F'}">
								여
							</c:if>
						</td>
						<td>${member.gerne}</td>
						<td>
							<c:if test="${member.text_receive eq false}">
								거부
							</c:if>
							<c:if test="${member.text_receive eq true}">
								동의
							</c:if>
						</td>
						<td>
							<c:if test="${member.email_receive eq false}">
								거부
							</c:if>
							<c:if test="${member.email_receive eq true}">
								동의
							</c:if>
						</td>
						<td>
							<c:if test="${member.info_open eq false}">
								거부
							</c:if>						
							<c:if test="${member.info_open eq true}">
								동의
							</c:if>						
						</td>
						<td>
							<c:if test="${member.email_auth_status eq false}">
								미완
							</c:if>						
							<c:if test="${member.email_auth_status eq true}">
								완료
							</c:if>						
						</td>
						<td>
							<c:if test="${member.phone_auth_status eq false}">
								미완
							</c:if>						
							<c:if test="${member.phone_auth_status eq true}">
								완료
							</c:if>						
						</td>
						<td>
							<c:if test="${member.member_type eq '1'}">
								일반회원
							</c:if>
							<c:if test="${member.member_type eq '2'}">
								VIP
							</c:if>
						</td>
						<td>${member.remain_point}</td>
						<td>${member.coupon_num}</td>
						<td>
							<c:if test="${member.member_status eq '1'}">
								정상
							</c:if>						
							<c:if test="${member.member_status eq '2'}">
								휴먼
							</c:if>						
							<c:if test="${member.member_status eq '3'}">
								탈퇴
							</c:if>						
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
			</c:choose>
		</table>
	</div>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
	
	<script type="text/javascript">
	$(function(){
		$("#listSearch").on("click", function(){
			alert("전체 목록을 출력했습니다.");
		});
		
		$("#idSearch").on("click", function(){
			window.open(                
				'AdminPageIdSearch', // 팝업 창에 로드할 파일
	            'ID 조회',    // 팝업 창 이름
	            'width=300,height=150,scrollbars=no,resizable=no');
		});	
	});
	
	</script>
</body>
</html>