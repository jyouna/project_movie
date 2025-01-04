<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html lang="en">
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>마이페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/mypage/inquery/inquery_list.css" rel="stylesheet"/>
		<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>

	<article>
		<div id="title">
			<h1>1:1 문의 목록</h1>
		</div>
	    <div class="search-bar">
	      <select >
	        <option>제목▼</option>
	        <option>내용</option>
	      </select>
	      <input type="text">
   		  <input type="button" value="검색" id="searchButton">
	    </div>
		<section id="listForm">
			<table>
				<tr id="tr_top">
					<td width="50px">상태</td>
					<td width="150px" >제목</td>
					<td width="100px">당첨자 발표일</td>
				</tr>
					
				<c:choose>
					<c:when test="${empty eventList}"> 
						<tr><td colspan="5">게시물이 존재하지 않습니다</td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="event" items="${eventList}" varStatus="status">
							<tr>
								<td class="event_num">${event.event_num}</td>
								<td class="event_subject">${event.event_subject}</td>
								<td>${event.event_name}</td>
								<td>
									<fmt:formatDate value="${event.event_date}" pattern="yy-MM-dd - yy-MM-dd"/>
								</td>
								<td>${event.event_readcount}</td>
							</tr>
						</c:forEach>
					</c:otherwise>					
				</c:choose>
			</table>
		</section>
				<section id="pageList">
			<input type="button" value="&lt" 
				onclick="location.href='EventList?pageNum=${pageInfo.pageNum - 1}'" 
				 <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
			
			<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
				<c:choose>
					<c:when test="${i eq pageInfo.pageNum }">
						<strong>${i}</strong>
					
					</c:when>
					<c:otherwise>
						<a href="EventList?pageNum=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			
			<input type="button" value="&gt" 
				onclick="location.href='EventList?pageNum=${pageInfo.pageNum + 1}'" 
				 <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		</section>
	
	<script type="text/javascript">
		$(function() {
			$(".event_subject").on("click", function(event) {
				console.log(event.target);
				let event_num = $(event.target).siblings(".event_num").text();
				console.log("siblings " + event_num);
				location.href = "EventDetail?event_num=" + event_num + "&pageNum=${pageInfo.pageNum}";
			
			});

			$("#searchButton").on("click", function () {
				confirm("검색버튼 눌렸습니다.")
			});
			
		});
	</script>
	</article>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>