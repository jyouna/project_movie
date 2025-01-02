<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>이벤트 당첨자 관리</title>
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
	
	<h3>이벤트 당첨자 명단</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
			<input type="button" value="전체선택" id="selectAll">
			<input type="button" id="give_prize" value="경품지급">
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
				<th width="70">번호</th>
				<th width="50">선택</th>
				<th width="150">이벤트코드</th>
				<th width="100">아이디</th>
				<th width="150">지급상태</th>
				<th width="150">지급일자</th>
				<th width="150">포인트금액</th>
				<th width="150">쿠폰종류</th>
			</tr>
		
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${empty eventVo}"> --%>
<!-- 					<tr> -->
<!-- 						<th colspan="8">"작성된 게시글이 없습니다."</th> -->
<!-- 					</tr> -->
<%-- 				</c:when> --%>
<%-- 				<c:otherwise> --%>
<%-- 					<c:forEach var="eventBoard" items="${eventVo}" varStatus="status"> --%>
<!-- 						<tr> -->
<%-- 							<td>${status.count}</td> --%>
<%-- 							<td><input type="checkbox" class="eventSetCheckbox" value="${eventBoard.event_code}"></td> --%>
<%-- 							<td>${eventBoard.event_code}</td>	 --%>
<%-- 							<td><a href="updateEventBoard?event_code=${eventBoard.event_code}">${eventBoard.event_subject}</a></td>	 --%>
<%-- 							<td>${eventBoard.regis_date}</td>	 --%>
<%-- 							<td>${eventBoard.event_start_date}</td>	 --%>
<%-- 							<td>${eventBoard.event_end_date}</td>	 --%>
<%-- 							<td>${eventBoard.event_writer}</td>	 --%>
<!-- 							<td> -->
<%-- 								<c:if test="${eventBoard.event_status == 0}"> --%>
<!-- 										미진행 -->
<%-- 								</c:if> --%>
<%-- 								<c:if test="${eventBoard.event_status == 1}"> --%>
<!-- 										진행중 -->
<%-- 								</c:if> --%>
<%-- 								<c:if test="${eventBoard.event_status == 2}"> --%>
<!-- 										종료 -->
<%-- 								</c:if> --%>
<!-- 							</td>	 -->
<!-- 						</tr>	 -->
<%-- 					</c:forEach> --%>
<%-- 				</c:otherwise> --%>
<%-- 			</c:choose>  --%>
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