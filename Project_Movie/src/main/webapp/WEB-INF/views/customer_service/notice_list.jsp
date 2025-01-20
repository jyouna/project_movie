<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/customer_service/notice_list.css" />
		<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/customer_service/notice_list.js"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/customer_service_sidebar.jsp"></jsp:include>
	<article>
		<div id="title">
			<h1>공지사항</h1>
		</div>
		<div id="search-bar" style="text-align:	right;">
<!-- 		여기서 선택하고 검색한 값을 넘겨줘야하니까 form 태그로 감싸고 action = NoticeList , 전달방식 - get -->
			<form action="NoticeList" method="get" name="searchForm">
				<select id="searchType">
	<!-- 			옵션에 각각 값을 넣어준다 -->
					<option value="subject">제목</option>
					<option value="content">내용</option>
				</select>
	<!-- 			검색어에는 name값을 searchKeyword로 준다 -->
				<input type="text" name ="searchKeyword" value="${param.searchKeyword}" placeholder="검색어를 입력하세요.">
				<input type="submit" value="검색">
			</form>
		</div>
		<section id="listForm">
			<table>
				<tr id="tr_top">
					<td width="100px">번호</td>
					<td>제목</td>
					<td width="150px">등록일</td>
					<td width="100px">조회수</td>
				</tr>
					
				<c:choose>
					<c:when test="${empty noticeList}"> 
						<tr><td colspan="5">게시물이 존재하지 않습니다</td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="notice_board" items="${noticeList}" varStatus="status">
							<tr>
								<td class="notice_code">${notice_board.notice_code}</td>
								<td class="notice_subject">${notice_board.notice_subject}</td>
								<td><fmt:formatDate value="${notice_board.regis_date}" pattern="yy-MM-dd"/></td>
								<td>${notice_board.view_count}</td>
							</tr>
						</c:forEach>
					</c:otherwise>					
				</c:choose>
			</table>
		</section>
		<section id="pageList">
			<input type="button" value="&lt" 
				onclick="location.href='NoticeList?pageNum=${pageInfo.pageNum - 1}'" 
				 <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
			
			<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
				<c:choose>
					<c:when test="${i eq pageInfo.pageNum }">
						<strong>${i}</strong>
					
					</c:when>
					<c:otherwise>
						<a href="NoticeList?pageNum=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			
			<input type="button" value="&gt" 
				onclick="location.href='NoticeList?pageNum=${pageInfo.pageNum + 1}'" 
				 <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		</section>
	</article>
	<script type="text/javascript">
	$(function () {
	    // 제목 클릭 이벤트
	    $(".notice_subject").on("click", function (event) {
	        let notice_code = $(event.target).siblings(".notice_code").text();
	        console.log("siblings " + notice_code);
	        location.href = "NoticePost?notice_code=" + notice_code + "&pageNum=${pageInfo.pageNum}";
	    });
    });
	
	
	
	
	</script>
	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>