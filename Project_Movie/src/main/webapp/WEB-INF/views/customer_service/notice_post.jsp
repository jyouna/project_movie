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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/customer_service/notice_post.css" />
		<!-- jQuery를 먼저 추가 -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/preNext.js"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/customer_service_sidebar.jsp"></jsp:include>
	
	<article id="articleForm">
		<h1>공지사항 - 글</h1>
		<section id="basicInfoArea">
			<table>
				<tr>
					<th width="60px">제목 </th>
					<td width="255px">${notice.notice_subject}</td>
					<th width="75px">등록일</th>
					<td width="160px">
						<fmt:formatDate value="${notice.regis_date}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
			</table>
		</section>
		<section id="articleContentArea">
			${notice.notice_content}
		</section>
		<hr>
		<div style="text-align: center;" >
		<input type="button" value="목록" id="btn" onclick="location.href='NoticeList?pageNum=${param.pageNum}'">
		</div>
		<div style="text-align: right;" >
			<input type="button" value="◁이전글" id="noticePrevBtn" >
	
			<input type="button" value="▷다음글" id="noticeNextBtn" >
		</div>


	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
	<script type="text/javascript">
		let columnValue = ${param.notice_code};
		let pageNum = ${param.pageNum};
	</script>
	
</body>
</html>