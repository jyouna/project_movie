<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html lang="en">
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>관리자페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/movie_set/movie_schedule_info.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/movie_set/movie_schedule_info.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<section>
		<div id="body_top">
			<div id="title">상영스케줄</div>
			<div id="btnGroup">
				<select class="changeScheduleTable">
						<option value="T1" <c:if test="${param.theater_code eq 'T1'}">selected</c:if>>1관</option>
						<option value="T2" <c:if test="${param.theater_code eq 'T2'}">selected</c:if>>2관</option>
						<option value="T3" <c:if test="${param.theater_code eq 'T3'}">selected</c:if>>3관</option>
				</select>
				<!-- 처음 페이지 포워딩시 selectedMonth 파라미터가없어서 month태그에 오늘날짜의 달을 입력 -->
				<c:choose>
					<c:when test="${empty param.selectedMonth}">
						<%
					        LocalDate currentDate = LocalDate.now();
					        int year = currentDate.getYear();
					        int month = currentDate.getMonthValue();
					        String monthStr = (month < 10) ? "0" + month : String.valueOf(month);
					        String selectedMonth = year + "-" + monthStr;
						%>
						<input type="month" class="changeScheduleTable" value="<%= selectedMonth %>">
					</c:when>
					<c:otherwise>
						<input type="month" class="changeScheduleTable" value="${param.selectedMonth}">
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div id="body_main">
			<table>
				<tr>
					<th>일요일</th>
					<th>월요일</th>
					<th>화요일</th>
					<th>수요일</th>
					<th>목요일</th>
					<th>금요일</th>
					<th>토요일</th>
				</tr>
				<tr>
					<c:forEach var="day" items="${calendar}" varStatus="status">
						<td class="${day}">
							<span class="day"><c:if test="${not empty day and day < 10}">0</c:if>${day}</span>
						</td>
						<c:if test="${status.count % 7 == 0}">
							</tr><tr>
						</c:if>
					</c:forEach>
					<c:if test="${calendar.size() % 7 != 0}">
						<c:forEach begin="1" end="${7 - calendar.size() % 7}">
							<td></td>
						</c:forEach>
					</c:if>
				</tr>
				
			</table>
		</div>
	</section>
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>