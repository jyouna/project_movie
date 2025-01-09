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
	<title>포인트 관리</title>
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
	<h3>포인트 변동 내역</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
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
				<th width="100">코드</th>
				<th width="350">ID</th>
				<th width="350">포인트적립</th>
				<th width="350">포인트차감</th>
				<th width="350">이벤트코드</th>
				<th width="350">취소코드</th>
				<th width="350">예매코드</th>
				<th width="350">변동일시</th>
			</tr>
			<c:choose>
				<c:when test="${empty pointVo}">
					<tr>
						<th colspan="7">"작성된 게시글이 없습니다."</th>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="point" items="${pointVo}" varStatus="status">
						<tr>
							<td>${point.point_code}</td>	
							<td>${point.point_holder}</td>	
							<td>
								<c:choose>
									<c:when test="${point.point_credited eq '0'}}">
									</c:when>
									<c:otherwise>
										${point.point_credited}
									</c:otherwise>
								</c:choose>							
							</td>	
							<td>
								<c:choose>
									<c:when test="${point.point_debited eq '0'}">
									</c:when>
									<c:otherwise>
										${point.point_debited}
									</c:otherwise>
								</c:choose>							
							</td>
							<td>
								<c:choose>
									<c:when test="${point.event_code eq '0'}">
									</c:when>
									<c:otherwise>
										${point.event_code}
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${point.refund_code eq '0'}">
									</c:when>
									<c:otherwise>
										${point.refund_code}
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${point.booking_code}">
									</c:when>
									<c:otherwise>
										${point.booking_code}
									</c:otherwise>
								</c:choose>							
							</td>	
							<td><fmt:formatDate value="${point.regis_date}" pattern="yyyy-MM-dd hh:mm"/> </td>	
						</tr>	
					</c:forEach>
				</c:otherwise>
			</c:choose> 	
		</table>
	</div>
	<br>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>

</body>
</html>