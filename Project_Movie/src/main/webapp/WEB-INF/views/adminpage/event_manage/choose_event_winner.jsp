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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<h3>이벤트 당첨자</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
			<input type="button" id="giveCoupon" value="쿠폰증정">
			<input type="button" id="givePoint" value="포인트증정">
		</div>	
		<div id="divTopRight">
		</div>	
	</div>
	<div id="tableDiv" class="view" style="overflow-x: auto;">
		<table id="mainTable">
			<tr align="center" id="tr01">
				<th>
					<input type="checkbox" class="eventSetCheckbox" id="selectAll">
				</th>
				<th>코드</th>
				<th>대상자</th>
				<th>이벤트제목</th>
				<th>시작일</th>
				<th>종료일</th>
			</tr>
			<c:choose>
				<c:when test="${not empty winnerList}">
					<c:forEach var="winner" items="${winnerList}">
						<tr>
							<td>
								<input type="checkbox" class="eventSetCheckbox" value="${winner}">
							</td>
							<td>
								<input type="hidden" name="event_code" id="event_code" value="${eventVo.event_code}">
								${eventVo.event_code}
							</td>
							<td>${winner}</td>
							<td>${eventVo.event_subject}</td>
							<td>${eventVo.event_start_date}</td>
							<td>${eventVo.event_end_date}</td>
						</tr>
					</c:forEach>				
				</c:when>
			</c:choose>
		</table>
	</div>
	<div id="divBottom" class="view">
		<input type="button" value="돌아가기" onclick="history.back()">
	</div>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
<script type="text/javascript">
</script>
</body>
</html>