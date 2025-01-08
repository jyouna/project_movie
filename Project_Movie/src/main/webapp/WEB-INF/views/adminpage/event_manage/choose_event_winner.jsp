<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	
	<title>이벤트 당첨자</title>
	
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_account_manage.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />

	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/account_manage.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<h3>이벤트 당첨자 - 임시로 회원 전체 목록 출력</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
<!-- 			<input type="button" value="전체선택" id="selectAll"> -->
			<input type="button" id="giveCoupon" value="쿠폰증정">
			<input type="button" id="givePoint" value="포인트증정">
		</div>	
		<div id="divTopRight">
			<select>
				<option>제목+내용</option>
				<option>제목</option>
				<option>내용</option>
			</select>
			<input type="text" placeholder="검색어를입력하세요"> <input type="button" value="검색" id="searchBtn">
		</div>	
	</div>
	<div id="tableDiv" class="view" style="overflow-x: auto;">
		<table id="mainTable">
			<tr align="center" id="tr01">
				<th width="50"><input type="checkbox" id="selectAll"></th>
				<th width="50">이벤트코드</th>
				<th width="100">대상자</th>
				<th width="150">이벤트제목</th>
				<th width="100">시작일자</th>
				<th width="100">종료일자</th>
			</tr>
			<c:choose>
				<c:when test="${empty eventVo}">
					<tr>
						<th colspan="6">"작성된 게시글이 없습니다."</th>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="member" items="${memberVo}" varStatus="status">
						<tr>
							<td><input type="checkbox" class="eventSetCheckbox" value="${member.member_id}"></td>
							<td>${eventVo.event_code}</td>
							<td>
								${member.member_id}	
<%-- 							<input type="hidden" id="event_code" value="${eventVo.event_code}">	 --%>
								<!--  파라미터에서도 아래 방식으로 바로 가져올 수 있음!! -->
								<input type="hidden" id="event_code" value="${param.event_code}">	
							</td>
							<td>${eventVo.event_subject}</td>	
							<td>${eventVo.event_start_date}</td>	
							<td>${eventVo.event_end_date}</td>	
						</tr>	
					</c:forEach>
				</c:otherwise>
			</c:choose> 
		</table>
	</div>
	<br>
	<div id="divBottom" class="view">
		<a href="#">1</a>
		<a href="#">2</a>
		<a href="#">3</a>
		<a href="#">4</a>
		<a href="#">5</a>
	</div>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>

</body>
</html>