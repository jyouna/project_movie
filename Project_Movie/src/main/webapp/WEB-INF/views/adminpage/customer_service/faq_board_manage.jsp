<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html lang="en">
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>관리자페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/customer_service/faq_list.css" rel="stylesheet" />
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<section>
		<article>
		<div id="title">
			<h1>FAQ</h1>
		</div>
		<div>
			<input type="button" value="전체선택">
			<input type="button" value="수정하기">
			<input type="button" value="삭제하기">
		</div>
		<section id="listForm">
			<table>
				<tr id="tr_top">
					<td width="100px"><input type="checkbox" disabled="disabled"></td>
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
						<c:forEach var="faq_board" items="${faqList}" >
							<tr>
								<td><input type="checkbox" ></td>
								<td class="faq_code">${faq_board.faq_code}</td>
								<td class="faq_subject">${faq_board.faq_subject}</td>
								<td><fmt:formatDate value="${faq_board.regis_date}" pattern="yy-MM-dd"/></td>
								<td>${faq_board.view_count}</td>
							</tr>
						</c:forEach>
					</c:otherwise>					
				</c:choose>
			</table>
		</section>
		<section id="pageList">
			<input type="button" value="&lt" 
				onclick="location.href='AdminFaq?pageNum=${pageInfo.pageNum - 1}'" 
				 <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
			
			<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
				<c:choose>
					<c:when test="${i eq pageInfo.pageNum }">
						<strong>${i}</strong>
					
					</c:when>
					<c:otherwise>
						<a href="AdminFaq?pageNum=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			
			<input type="button" value="&gt" 
				onclick="location.href='AdminFaq?pageNum=${pageInfo.pageNum + 1}'" 
				 <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		</section>
	</article>
	<script type="text/javascript">
		$(function(){
			$(".faq_subject").on("click", function(event) {
				console.log(event.target);
				let faq_code = $(event.target).siblings(".faq_code").text();
				console.log("siblings " + faq_code);
				location.href = "AdminFaqPost?faq_code=" + faq_code + "&pageNum=${pageInfo.pageNum}";
			});
		
		});
	</script>
	</section>
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>