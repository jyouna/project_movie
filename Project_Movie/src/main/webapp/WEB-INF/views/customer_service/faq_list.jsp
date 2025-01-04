<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE HTML>
<!--
	Escape Velocity by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/customer_service/faq_list.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/customer_service_sidebar.jsp"></jsp:include>
	
	<article>
		<div id="title">
			<h1>FAQ</h1>
		</div>
		<div class="search-bar">
			<select>
				<option>제목</option>
				<option>내용</option>
			</select>
			<input type="text">
			<input type="button" value="검색" id="searchButton">
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
					<c:when test="${empty faqList}"> 
						<tr><td colspan="5">게시물이 존재하지 않습니다</td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="faq_board" items="${faqList}" varStatus="status">
							<tr>
								<td class="faq_code">${faq_board.faq_code}</td>
								<td class="faq_subject">${faq_board.faq_subject}</td>
								<td><fmt:formatDate value="${faq_board.regis_date}" pattern="yy-MM-dd "/></td>
								<td>${faq.view_count}</td>
							</tr>
						</c:forEach>
					</c:otherwise>					
				</c:choose>
			</table>
		</section>
				<section id="pageList">
			<input type="button" value="&lt" 
				onclick="location.href='BoardList?pageNum=${pageInfo.pageNum - 1}'" 
				 <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
			
			<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
				<c:choose>
					<c:when test="${i eq pageInfo.pageNum }">
						<strong>${i}</strong>
					
					</c:when>
					<c:otherwise>
						<a href="FaqList?pageNum=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			
			<input type="button" value="&gt" 
				onclick="location.href='FaqList?pageNum=${pageInfo.pageNum + 1}'" 
				 <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		</section>
	</article>
	<script type="text/javascript">
		$(function(){
			$(".faq_subject").on("click", function(event) {
				console.log(event.target);
				let faq_code = $(event.target).siblings(".faq_code").text();
				console.log("siblings " + faq_code);
				location.href = "BoardDetail?board_num=" + board_num + "&pageNum=${pageInfo.pageNum}";
			
			});
		
			$("#searchButton").on("click", function () {
				confirm("검색버튼 눌렸습니다.")
			});
		});
	</script>


	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>