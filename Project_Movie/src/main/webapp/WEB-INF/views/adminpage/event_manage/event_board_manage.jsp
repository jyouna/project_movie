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
	<title>이벤트 관리</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp" />
	<h3>이벤트 관리</h3>
		<div id="divTop" class="view">
			<div id="divTopLeft">
				<input type="button" value="이벤트 등록" id="board_regis">
				<input type="button" id="eventStart" value="이벤트 시작">
				<input type="button" id="eventEnd" value="이벤트 종료">
				<input type="button" id="chooseEventWinner" value="당첨자 추첨">
				<input type="button" id="deleteEvent" value="이벤트 삭제">
			</div>	
			
			<div id="divTopRight">
				<form action="EventBoardManage" method="get" id="searchForm">
					<input type="hidden" name="pageNum" value="${param.pageNum}">
					<input type="hidden" name="eventStatus" id="eventStatusHidden" value="">
					<input type="hidden" name="eventWinnerStatus" id="eventWinnerStatusHidden" value="">
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
						<th width="350">제목</th>
						<th width="150">등록일자</th>
						<th width="150">시작일자</th>
						<th width="150">종료일자</th>
						<th width="150">작성자</th>
						<th width="150">
							<select class="selectOption" id="eventStatus"> 
								<option value="" selected>진행상태</option>
								<option value="0">대기</option>
								<option value="1">진행중</option>
								<option value="2">종료</option>
							</select>
						</th>
						<th width="150">
							<select class="selectOption" id="eventSetWinnerStatus">
								<option value="" selected>당첨진행</option>
								<option value="0">대기</option>
								<option value="1">완료</option>
							</select>
						</th>
					</tr>
					<c:choose>
						<c:when test="${empty eventVo}">
							<tr>
								<th colspan="8">"작성된 게시글이 없습니다."</th>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="eventBoard" items="${eventVo}" varStatus="status">
								<tr>
									<td><input type="radio" name="selectedEvent" class="eventSetRadio" value="${eventBoard.event_code}"></td>
									<td>${eventBoard.event_code}</td>	
									<td><a href="#" id="event_subject_link" onclick="window.open('updateEventBoard?event_code=${eventBoard.event_code}', '이벤트수정', 
															'width=1000,height=800,top=460,left=140,scrollbars=yes,resizable=yes'); return false;">${eventBoard.event_subject}</a></td>	
									<td><fmt:formatDate value="${eventBoard.regis_date}" pattern="yyyy-MM-dd"/></td>	
									<td>${eventBoard.event_start_date}</td>	
									<td>${eventBoard.event_end_date}</td>	
									<td>${eventBoard.event_writer}</td>	
									<td><c:if test="${eventBoard.event_status == 0}">대기</c:if>
										<c:if test="${eventBoard.event_status == 1}">진행중</c:if>
										<c:if test="${eventBoard.event_status == 2}">종료</c:if>
									</td>
									<td><c:if test="${eventBoard.set_winner_status == true}">완료</c:if>
										<c:if test="${eventBoard.set_winner_status == false}">대기</c:if>
									</td>
								</tr>	
							</c:forEach>
						</c:otherwise>
					</c:choose> 
				</table>
			</div> <!--  테이블 div  -->
			<c:set var="searchRecord" value="&searchKeyword=${param.searchKeyword}&searchContent=${param.searchContent}&searchContent=${param.eventStatus}&eventWinnerStatus=${param.eventWinnerStatus}" />
			
			<div id="divBottom" class="view"> <!-- 바텀디브 -->
				<input type="button" value="이전" onclick="location.href='EventBoardManage?pageNum=${pageInfo.pageNum - 1}${searchRecord}'" 
				<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
				<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
					<c:choose>
						<c:when test="${i eq pagInfo.pageNum}">
							<strong>${i}</strong>
						</c:when>
						<c:otherwise>
							<a href="EventBoardManage?pageNum=${i}${searchRecord}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<input type="button" value="다음" onclick="location.href='EventBoardManage?pageNum=${pageInfo.pageNum + 1}${searchRecord}'"
				<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
			</div>
		<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp" />
	<%--==================================================================== 페이지 구분선 ===================================================================== --%>

<script type="text/javascript">

</script>
</body>
</html>