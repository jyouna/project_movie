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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
<style type="text/css">
.number {
	text-align: right !important;
	padding-right: 4em;
	width: 20%;
}
.alignLeft {
	text-align: center !important;
	padding-left : 4em !important;
}

#idWidth {
	width: 20%;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<h3>포인트 내역</h3>
	<div id="divTop">
		<div id="divTopLeft"></div>
		<div id="divTopRight">
			<form action="PointBoardManage" method="get" id="pointForm">
				<input type="hidden" name="pageNum" value="${param.pageNum}">
				<select name="searchKeyword">
					<option value="pointHolder" <c:if test="${param.searchKeyword eq 'pointHolder'}">selected</c:if>>아이디</option>
					<option value="eventCode" <c:if test="${param.searchKeyword eq 'eventCode'}">selected</c:if>>이벤트번호</option>
				</select>
				<input type="text" placeholder="검색어를입력하세요" name="searchContent" value="${param.searchContent}"> 
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
	<div id="tableDiv" class="view" style="overflow-x: auto;">
		<table id="mainTable">
			<tr align="center" id="tr01">
				<th class="alignLeft">코드</th>
				<th id="idWidth" class="alignLeft">ID</th>
				<th class="number">포인트적립</th>
				<th class="number">포인트차감</th>
				<th class="alignLeft">변동사유</th>
				<th class="alignLeft">변동일시</th>
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
							<td class="alignLeft">${point.point_code}</td>	
							<td class="alignLeft">${point.point_holder}</td>	
							<td class="number">
								<c:choose>
									<c:when test="${point.point_credited eq '0'}}">
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${point.point_credited}" type="number" />
									</c:otherwise>
								</c:choose>							
							</td>	
							<td class="number">
								<c:choose>
									<c:when test="${point.point_debited eq '0'}">
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${point.point_debited}" type="number" />
									</c:otherwise>
								</c:choose>							
							</td>
							<td class="alignLeft">
								<c:choose>
									<c:when test="${point.event_code == '0'}">
										관리자 발급
									</c:when>
									<c:when test="${point.event_code != '0'}">
										이벤트당첨(코드 : ${point.event_code})
									</c:when>
									<c:when test="${point.refund_code != '0'}">
										결제취소(코드 : ${point.refund_code})
									</c:when>									
									<c:when test="${not empty point.payment_code}">
										결제(코드 : ${point.payment_code})
									</c:when>									
								</c:choose>
							</td>
							<td class="alignLeft"><fmt:formatDate value="${point.regis_date}" pattern="yyyy-MM-dd hh:mm"/> </td>	
						</tr>	
					</c:forEach>
				</c:otherwise>
			</c:choose> 	
		</table>
	</div>
	<c:set var="searchRecord" value="&searchKeyword=${param.searchKeyword}&searchContent=${param.searchContent}" />
	<div id="divBottom" class="view">
		<input type="button" value="처음" 
			onclick="location.href='PointBoardManage?pageNum=1'"<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>> 	
<%-- 이전 페이지 이동	 --%>
		<input type="button" value="이전" 
			onclick="location.href='PointBoardManage?pageNum=${pageInfo.pageNum - 1}${searchRecord}'" 
			<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
		<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			<c:choose>
				<c:when test="${i eq pagInfo.pageNum}">
<%-- 현재 페이지 표시	 --%>
					<strong>${i}</strong>
				</c:when>
<%-- 페이지 번호 클릭하여 이동	 --%>
				<c:otherwise>
					<a href="PointBoardManage?pageNum=${i}${searchRecord}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
<%-- 다음 페이지 이동	 --%>
		<input type="button" value="다음" onclick="location.href='PointBoardManage?pageNum=${pageInfo.pageNum + 1}${searchRecord}'"
			<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		<input type="button" value="마지막" onclick="location.href='PointBoardManage?pageNum=${pageInfo.maxPage}'"
			<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>		
	</div>	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	<script type="text/javascript">
	</script>
</body>
</html>