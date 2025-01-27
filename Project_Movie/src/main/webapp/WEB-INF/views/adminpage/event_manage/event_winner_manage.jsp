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
	<title>당첨자 발표</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp" />
	<h3>당첨자 발표</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
<!-- 				<input type="button" onclick="location.href='EventAllWinnerList'" value="이벤트 당첨자 리스트"> -->
			<input type="button" value="등록하기" id="winner_board_regis">
			<input type="button" id="deleteWinnerNotice" value="게시글삭제">
		</div>	
		
		<div id="divTopRight">
			<form action="EventWinnerManage" method="get">
				<input type="hidden" name="pageNum" value="${param.pageNum}">
				<select name="searchKeyword">
					<option value="eventSubject" <c:if test="${param.searchKeyword eq 'eventSubject'}">selected</c:if>>제목</option>
					<option value="eventContent" <c:if test="${param.searchKeyword eq 'eventContent'}">selected</c:if>>내용</option>
					<option value="eventWriter" <c:if test="${param.searchKeyword eq 'eventWriter'}">selected</c:if>>작성자</option>
				</select>
				<input type="text" placeholder="검색어를입력하세요" name="searchContent"
					<c:if test="${!param.searchContent}">value = ${param.searchContent}</c:if>>
					<input type="submit" value="검색">
			</form>
			</div>	
		</div> <!--  탑디브 끝 -->		
		
		<div id="tableDiv" class="view" style="overflow-x: auto;">
			<table id="mainTable">
				<tr align="center" id="tr01">
					<th width="100">선택</th>
					<th width="100">이벤트코드</th>
					<th width="350">이벤트제목</th>
					<th width="150">당첨일자</th>
					<th width="150">작성자</th>
				</tr>
				<c:choose>
					<c:when test="${empty eventVo}">
						<tr><th colspan="8">"작성된 게시글이 없습니다."</th></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="eventBoard" items="${eventVo}" varStatus="status">
							<tr>
								<td><input type="radio" name="selectedEvent" class="eventSetRadio" value="${eventBoard.event_code}"></td>
								<td>${eventBoard.event_code}</td>	
								<td><a href="updateEventBoard?event_code=${eventBoard.event_code}">${eventBoard.event_subject}</a></td>	
								<td><fmt:formatDate value="${eventBoard.regis_date}" pattern="yyyy-MM-dd"/></td>	
								<td>${eventBoard.event_writer}</td>	
							</tr>	
						</c:forEach>
					</c:otherwise>
				</c:choose> 
			</table>
		</div> <!--  테이블 div  -->
		<br>
		<c:set var="searchRecord" value="&searchKeyword=${param.searchKeyword}&searchContent=${param.searchContent}" />
		
		<div id="divBottom" class="view"> <!-- 바텀디브 -->
			<input type="button" value="이전" onclick="location.href='EventWinnerManage?pageNum=${pageInfo.pageNum - 1}${searchRecord}'" 
			<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
			<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
				<c:choose>
					<c:when test="${i eq pageInfo.pageNum}">
						<strong>${i}</strong>
					</c:when>
					<c:otherwise>
						<a href="EventWinnerManage?pageNum=${i}${searchRecord}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<input type="button" value="다음" onclick="location.href='EventWinnerManage?pageNum=${pageInfo.pageNum + 1}${searchRecord}'"
			<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		</div> <!--  바텀 디브 --> 
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp" />
	
	<%--==================================================================== 페이지 구분선 ===================================================================== --%>
	<%--==================================================================== 페이지 구분선 ===================================================================== --%>

<script type="text/javascript">
$(function(){
	$("#winner_board_regis").on("click", function(){
		window.open("winnerNoticeBoard", "당첨자 발표", "width=1000, height=800, left=460, top=140");
	})
})
</script>
</body>
</html>