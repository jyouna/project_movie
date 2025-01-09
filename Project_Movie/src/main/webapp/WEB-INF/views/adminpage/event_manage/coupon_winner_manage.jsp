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
	
	<h3>이벤트 당첨자 목록</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
		<h4>쿠폰 당첨자</h4>
		</div>	
		<div id="divTopRight"> <!--  우측 상단 검색란 -->
			<select>
				<option>제목+내용</option>
				<option>제목</option>
				<option>내용</option>
			</select>
			<input type="text" placeholder="검색어를입력하세요"> <input type="button" value="검색" id="searchBtn">
		</div>	
	</div>
	<div id="tableDiv" class="view" style="overflow-x: auto;">
		<table id="mainTable" class="mainTable">
			<tr align="center" id="tr01" class="tr01">
				<th width="50">코드</th>
				<th width="250">이벤트제목</th>
				<th width="150">당첨일시</th>
				<th width="100">시작일자</th>
				<th width="100">종료일자</th>
				<th width="100">당첨자</th>
				<th width="100">쿠폰종류</th>
				<th width="100">쿠폰상세</th>
			</tr>
			<c:choose>
				<c:when test="${empty coupon_winner}">
					<tr>
						<th colspan="8">"작성된 게시글이 없습니다."</th>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="coupon" items="${coupon_winner}" varStatus="status">
						<tr>
							<td>${coupon.event_code}</td>	
							<td>${coupon.event_subject}</td>	
							<td><fmt:formatDate value="${coupon.prize_datetime}" pattern="yyyy-MM-dd hh:mm"/> </td>	
							<td>${coupon.event_start_date}</td>	
							<td>${coupon.event_end_date}</td>	
							<td>${coupon.winner_id}</td>	
							<c:choose>
								<c:when test="${coupon.coupon_type eq false}">
									<td>금액할인</td>
									<td>${coupon.discount_amount}원</td>
								</c:when>
								<c:otherwise>
									<td>할인율</td>
									<td>${coupon.discount_rate}%</td>
								</c:otherwise>
							</c:choose>
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