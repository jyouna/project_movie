<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="ko_KR" /> <!--  숫자 자리표기법 locale KR 기준 -->
<fmt:setBundle basename="messages" />
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
	
	<h3>이벤트 당첨자 목록</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
<!-- 		<h4>이벤트 당첨자</h4> -->
			<span id="winnerCount"></span>
		</div>	
		<div id="divTopRight"> <!--  우측 상단 검색란 -->
			<form action="EventAllWinnerList" method="get">
				<input type="hidden" name="pageNum" value="${param.pageNum}">
				<select name="searchKeyword">
					<option value="winnerId" <c:if test="${param.searchKeyword eq 'winnerId'}">selected</c:if>>아이디</option>
					<option value="eventSubject" <c:if test="${param.searchKeyword eq 'eventSubject'}">selected</c:if>>이벤트</option>
				</select>
				<input type="text" placeholder="검색어를입력하세요" name="searchContent" value="${param.searchContent}"> 
				<input type="submit" value="검색">
			</form>
		</div>	
	</div>
	
	<div id="tableDiv" class="view" style="overflow-x: auto;">
		<table id="mainTable" class="mainTable">
			<tr align="center" id="tr01" class="tr01">
				<th>이벤트코드</th>
				<th>당첨자</th>
				<th>이벤트명</th>
				<th>진행기간</th>
				<th>쿠폰종류</th>
				<th>추첨일시</th>
			</tr>
			<c:forEach var="winner" items="${voList}">
				<tr>
					<td>${winner.event_code}</td>
					<td>${winner.winner_id}</td>
					<td>${winner.event_subject}</td>
					<td>${winner.event_start_date} ~ ${winner.event_end_date}</td>
					<td>
						<c:choose>
							<c:when test="${(empty winner.discount_rate || winner.discount_rate == 0) && (empty winner.discount_amount || winner.discount_amount == 0)}">
								<fmt:formatNumber value="${winner.point_amount}" pattern="#,##0" />포인트				
							</c:when>
							<c:when test="${(empty winner.discount_amount || winner.discount_amount == 0) && (empty winner.point_amount || winner.point_amount == 0)}">
								${winner.discount_rate}% 할인쿠폰						
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${winner.discount_amount}" pattern="#,##0" />원 할인쿠폰
							</c:otherwise>	
						</c:choose>
					</td>
					<td><fmt:formatDate value="${winner.prize_datetime}" pattern="yyyy-MM-dd HH:MM"/></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<c:set var="searchRecord" value="&searchKeyword=${param.searchKeyword}&searchContent=${param.searchContent}" />
	<div id="divBottom" class="view">
<%-- 이전 페이지 이동 --%>	
		<input type="button" value="처음" 
			onclick="location.href='EventAllWinnerList?pageNum=1${searchRecord}'" 
			<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
		<input type="button" value="이전" 
			onclick="location.href='EventAllWinnerList?pageNum=${pageInfo.pageNum - 1}${searchRecord}'" 
			<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
		<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			<c:choose>
				<c:when test="${i eq pageInfo.pageNum}">
<%-- 현재 페이지 표시 --%>	
					<strong>${i}</strong>
				</c:when>
<%-- 페이지 번호 클릭하여 이동 --%>	
				<c:otherwise>
					<a href="EventAllWinnerList?pageNum=${i}${searchRecord}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
<%-- 다음 페이지 이동 --%>	
		<input type="button" value="다음" onclick="location.href='EventAllWinnerList?pageNum=${pageInfo.pageNum + 1}${searchRecord}'"
		<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		<input type="button" value="끝" onclick="location.href='EventAllWinnerList?pageNum=${pageInfo.maxPage}${searchRecord}'"
		<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
	</div>	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
	<script type="text/javascript">
	$(function(){
		const urlParams = new URLSearchParams(window.location.search); // URL 파라미터 가져오기
		const searchKeyword = urlParams.get("searchKeyword");
		const searchContent = urlParams.get("searchContent");
		
		console.log("urlParams : " + urlParams);
		console.log("searchKeyword : " + searchKeyword);
		console.log("searchContent : " + searchContent);
		
		$.ajax({
			url: "GetWinnerCount",
			type: "get",
			data: {
				searchKeyword : searchKeyword,
				searchContent : searchContent
			}
		}).done(function(response){
			$("#winnerCount").text("조회 수 : " + response.toLocaleString('ko-KR') + "명").css("color", "red");
		});
	});
	</script>
</body>
</html>