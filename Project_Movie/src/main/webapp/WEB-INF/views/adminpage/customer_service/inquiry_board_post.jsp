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
	<link href="${pageContext.request.contextPath}/resources/css/mypage/inquiry/inquiry_post.css" rel="stylesheet"/>
		<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<article id="articleForm">
			<h4>1:1문의 - 글 </h4><br>
			<section id="basicInfoArea">
				<table>
					<tr>
						<th width="100">제목</th>
						<td colspan="3">${inquiry.inquiry_subject}</td>
						<th width="120">등록일</th>
						<td width="180">
							<fmt:formatDate value="${inquiry.inquriy_date}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
				</table>
		</section>
		<section id="articleContentArea">
				${inquiry.inquiry_content}
		</section>
		<hr>
		<section style="text-align: center;">
			<input type="button" value="답변" onclick="location.href='AdminInquiryReply?inquiry_code=${inquiry.inquiry_code}&pageNum=${param.pageNum}'">
			<input type="button" value="삭제" onclick="deleteInquiry()">
			<input type="button" value="목록" onclick="location.href='AdminInquiry?pageNum=${param.pageNum}'">
		</section>
		<hr>
		<div style="text-align:right;">
			<input type="button" value="◁이전글" onclick="location.href='AdminInquiryPost?inquiry_code=${param.inquiry_code+1}&pageNum=${param.pageNum}'"
			<c:if test="${param.inquiry_code+1 eq null}">alert("해당 게시글이 존재하지 않습니다.")</c:if>>
	
			<input type="button" value="▷다음글" onclick="location.href='AdminInquiryPost?inquiry_code=${param.inquiry_code-1}&pageNum=${param.pageNum}'"
			<c:if test="${param.inquiry_code-1 eq 0}">alert("해당 게시글이 존재하지 않습니다.")</c:if>>
		</div>
	<script type="text/javascript">
		
		function deleteInquiry() { 
			if (confirm("삭제 하시겠습니까?")) { 
				location.href = "AdminInquiryDelete?inquiry_code=${inquiry.inquiry_code}&pageNum=${param.pageNum}"; 
				} 
			}
	</script>
	</article>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>