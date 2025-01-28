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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/customer_service/faq_post.css" />
		<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
	<article id="articleForm">
		<h1>1:1문의 - 글 수정하기</h1>
		<form action="InquiryModify" method="post">
			<input type="hidden" name = "inquiry_code" value="${param.inquiry_code}">
			<input type="hidden" name = "pageNum" value="${param.pageNum }">
			<section id="basicInfoArea">
				<table>
					<tr>
						<th width="110px"> <label for="inquiry_subject"> </label>제목</th>
						<td width="220px"><input type ="text"  name ="inquiry_subject" value ="${inquiry.inquiry_subject}" required></td>
						<th width="90px">등록일</th>
						<td width="160px">
							<fmt:formatDate value="${inquiry.inquriy_date}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
				</table>
		</section>
		<section id="articleContentArea">
				<textarea rows="15" cols="70" name="notice_content" required="required">${notice.notice_content}</textarea>
		</section>
		<hr>
			<input type="submit" value ="등록">
			<input type="button" value ="취소" onclick="location.href='InquiryList'" style="text-align: right;">
		</form>
	</article>
</body>
</html>