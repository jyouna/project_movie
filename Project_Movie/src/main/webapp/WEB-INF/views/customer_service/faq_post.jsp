<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>faq post</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/customer_service/faq_post.css" />
		<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/customer_service_sidebar.jsp"></jsp:include>
	
	<article id="articleForm">
		<h4>FAQ - 글</h4><br>
		<section id="basicInfoArea">
			<table>
				<tr>
					<th width="60px">제목</th>
					<td width="225px">${faq.faq_subject}</td>
					<th width="75px">등록일</th>
					<td width="160px">
						<fmt:formatDate value="${faq.regis_date}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
			</table>
		</section>
		<section id="articleContentArea">
			${faq.faq_content}
		</section>
		<hr>
		<div style="text-align: center;">
			<input type="button" value="목록" id="btn"onclick="location.href='FaqList?pageNum=${param.pageNum}'">
		</div>
		<div style="text-align: right;">
			<input type="button" value="◁이전글" id="btn" onclick="location.href='FaqPost?faq_code=${faq.faq_code+1}&pageNum=${PageInfo.pageNum }'"
			<c:if test="${param.notice_code+1 eq null}">alert("해당 게시글이 존재하지 않습니다.")</c:if>>
			<input type="button" value="▷다음글"id="btn"  onclick="location.href='FaqPost?faq_code=${faq.faq_code-1}&pageNum=${PageInfo.pageNum }'"
			<c:if test="${param.notice_code-1 eq 0}">alert("해당 게시글이 존재하지 않습니다.")</c:if>>
		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>