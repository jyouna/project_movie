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
			<h1>FAQ - 글 수정하기</h1>
			<section id="basicInfoArea">
				<form action="AdminFaqModify" method="post">
		<!-- 			hidden으로 해당 번호의 글을 가져온다 -->
					<input type="hidden" name = "faq_code" value="${param.faq_code }">
					<input type="hidden" name = "pageNum" value="${param.pageNum }">
					<table>
						<tr>
							<th width="110px"> <label for="faq_subject"> </label>제목</th>
							<td width="220px"><input type ="text"  name ="faq_subject" value ="${faq.faq_subject}" required></td>
							<th width="90px">등록일</th>
							<td width="160px">
								<fmt:formatDate value="${faq.regis_date}" pattern="yyyy-MM-dd"/>
							</td>
						</tr>
						<tr>
							<th rowspan="4"><textarea id="faq_content" name="faq_content" rows="15" cols="40" required>${faq.faq_content}</textarea></th>
						</tr>		
					</table>
					<input type="submit" value ="등록">
				</form>
			</section>
		</article>
	</section>
		

	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>