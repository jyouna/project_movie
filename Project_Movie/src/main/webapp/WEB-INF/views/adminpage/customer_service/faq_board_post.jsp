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
		<h1>FAQ - 글</h1>
		<section id="basicInfoArea">
			<table>
				<tr>
					<th width="110px">제목</th>
					<td width="220px">${faq.faq_subject}</td>
					<th width="90px">등록일</th>
					<td width="160px">
						<fmt:formatDate value="${faq.regis_date}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
				<tr>
					<th width="110px">첨부파일</th>
					<td colspan="3" id="faq_file1"></td>
				</tr>
			</table>
		</section>
		<section id="articleContentArea">
			${faq.faq_content}
		</section>
		<input type="button" value="목록" onclick="location.href='AdminFaq?pageNum=${param.pageNum}'">
		<hr>
		<table id="postList">
			<tr>
				<th><input type="button" value="△이전글" id="tableButton" onclick="location.href='AdminFaq?faq_code=${faq.faq_code-1}&pageNum=${PageInfo.pageNum }'"></th>
				<th>이거는 이전 글 </th>
			</tr>
			<tr>
				<th><input type="button" value="▽다음글" id="tableButton" onclick="location.href='AdminFaq?faq_code=${faq.faq_code+1}&pageNum=${PageInfo.pageNum }'"></th>
				<th>여기는 다음글</th>
			</tr>
		</table>
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