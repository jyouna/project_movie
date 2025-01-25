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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/seat_set.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/seat_set.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<section id="seatSetBody">
		<div id="sec01">
			<div id="title">좌석관리</div>
			<div>
				<select id="theaterSelect">
					<option value="T1" <c:if test="${param.theater_code eq 'T1'}">selected</c:if>>상영관1</option>
					<option value="T2" <c:if test="${param.theater_code eq 'T2'}">selected</c:if>>상영관2</option>
					<option value="T3" <c:if test="${param.theater_code eq 'T3'}">selected</c:if>>상영관3</option>
				</select>
			</div>
		</div>
		
		<div id="sec02">
			<div id="seatStatus">
				총 좌석수 : ${seatList.size()}개
				| 활성화 : ${seatList.size() - disabledCount}개
				<input type="text" style="background-color:#444451;" readonly>
				| 비활성화 : ${disabledCount}개
				<input type="text" style="background-color:#8B0000;" readonly>
			 </div>
			<div class="seatContainer">
				<div class="screen">SCREEN</div>
				<c:forEach var="j" begin="0" end="${rowCount-1}">
					<div class="seatRow">
						<c:forEach var="i" begin="0" end="${colCount-1}">
							<button type="button" class="seat <c:if test="${seatList[i + j*10].seat_avail eq 0}">disabled</c:if>"
								<c:if test="${(i eq 7 and j eq 0) or (i eq 8 and j eq 0)}">name="wheelChairSeat"</c:if>>
								${seatList[i + j*10].seat_code}
							</button>
						</c:forEach>
					</div>
				</c:forEach>
			</div>
			<div id="btnGroup">
				<input type="button" id="ableBtn" value="활성화">
				<input type="button" id="disableBtn" value="비활성화">
			</div>
		</div>
    </section>
    
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>