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
	<link href="${pageContext.request.contextPath}/resources/css/mypage/inquiry/inquiry_list.css" rel="stylesheet"/>
		<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>

	<article class="box">
		<div id="title">
			<h1>1:1 문의 목록</h1>
		</div>
	    <div class="search-bar" style="text-align: right;">
    		<form action="InquiryList" method="get" name="searchForm">
			    <select name="searchType">
			        <option value="subject"
			            <c:choose>
			                <c:when test="${empty param.searchType or param.searchType eq 'subject'}">selected</c:when>
			            </c:choose>>제목
			        </option>
			        <option value="content"
			            <c:if test="${param.searchType eq 'content'}">selected</c:if>>내용
			        </option>
			    </select>
			    <input type="text" name="searchKeyWord" value="${param.searchKeyWord}" placeholder="검색어를 입력하세요.">
			    <input type="submit" value="검색" id="searchButton">
			</form>

	    </div>
	    <input type="button" value="글쓰기" onclick="location.href='InquiryWrite'" style="text-align: right;">
		<section id="listForm">
			<table id="inquiryForm" border="1">
				<tr id="tr_top" align="center">
					<td width="25px">번호</td>
					<td width="45px">상태</td>
					<td width="280px">제목</td>
					<td width="80px">등록일</td>
				</tr>
					
				<c:choose>
					<c:when test="${empty inquiryList}"> 
						<tr><td colspan="4">게시글이 존재하지 않습니다.</td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="inquiry" items="${inquiryList}" varStatus="status">
							<tr>
								<td class="inquiry_code">${inquiry.inquiry_code}</td>
								<td>
									<c:if test="${inquiry.response_status eq 0}">
										답변 전
									</c:if>
									<c:if test="${inquiry.response_status eq 1}">
										답변 완료
									</c:if>
									<c:if test="${inquiry.response_status eq 2}">
										답변
									</c:if>
								</td>
								<td class="inquiry_subject">
									<c:if test="${inquiry.inquiry_re_lev > 0}">
										<c:forEach begin="1" end="${inquiry.inquiry_re_lev}">
											&nbsp;&nbsp; ↳ &nbsp;
										</c:forEach>
									</c:if>
									${inquiry.inquiry_subject}
								</td>
								<td>
									<fmt:formatDate value="${inquiry.inquriy_date}" pattern="yyyy-MM-dd"/>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>					
				</c:choose>
			</table>
		</section>
				<section id="pageList">
			<input type="button" value="&lt" 
				onclick="location.href='InquiryList?pageNum=${pageInfo.pageNum - 1}'" 
				 <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
			
			<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
				<c:choose>
					<c:when test="${i eq pageInfo.pageNum }">
						<strong>${i}</strong>
					</c:when>
					<c:otherwise>
						<a href="InquiryList?pageNum=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			
			<input type="button" value="&gt" 
				onclick="location.href='InquiryList?pageNum=${pageInfo.pageNum + 1}'" 
				 <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		</section>
	
	<script type="text/javascript">
		$(function() {
			$(".inquiry_subject").on("click", function(event) {
				let inquiry_code = $(event.target).siblings(".inquiry_code").text();
				location.href = "InquiryPost?inquiry_code=" + inquiry_code + "&pageNum=${pageInfo.pageNum}";
			
			});

		});
	</script>
	</article>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>