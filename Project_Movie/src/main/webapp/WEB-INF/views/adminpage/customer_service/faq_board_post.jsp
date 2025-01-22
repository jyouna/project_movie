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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/customer_service/faq_post.css" />
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<section>
<article id="articleForm">
		<h4>FAQ - 글</h4><br>
		<section id="basicInfoArea">
			<table style="text-align: center;">
				<tr>
					<th width="60px">제목</th>
					<td width="240px">${faq.faq_subject}</td>
					<th width="80px">등록일</th>
					<td width="160px">
						<fmt:formatDate value="${faq.regis_date}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
			</table>
		</section>
		<section id="articleContentArea">
			${faq.faq_content}
		</section>
		<div style="text-align: right;">
			<input type="button" value="목록" onclick="location.href='AdminFaq?pageNum=${param.pageNum}'">
			<input type="button" value="수정하기" onclick="location.href='AdminFaqModify?faq_code=${param.faq_code}&pageNum=${param.pageNum}'">
			<input type="button" value="삭제하기" onclick="location.href='AdminFaqDelete?faq_code=${param.faq_code}&pageNum=${param.pageNum }'">
		</div>
		<hr>
		<div style="text-align:right;">
			<input type="button" value="◁이전글"  onclick="location.href='AdminFaqPost?faq_code=${param.faq_code+1}&pageNum=${param.pageNum}'"
			<c:if test="${param.faq_code+1 eq null}">alert("해당 게시글이 존재하지 않습니다.")</c:if>>
	
			<input type="button" value="▷다음글" onclick="location.href='AdminFaqPost?faq_code=${param.faq_code-1}&pageNum=${param.pageNum}'"
			<c:if test="${param.faq_code-1 eq 0}">alert("해당 게시글이 존재하지 않습니다.")</c:if>>
		</div>

	</article>
	</section>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>