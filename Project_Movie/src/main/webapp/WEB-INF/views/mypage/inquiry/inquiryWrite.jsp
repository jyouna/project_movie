<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>InquiryWrite</title>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage_styles.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/resources/css/mypage/inquiry/inquiryWrite.css" rel="stylesheet">
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
	
	<article id="articleForm">
		<h4>1:1문의 - 글 작성</h4>
		<form action="InquiryWrite" method="post">
			<section id="basicInfoArea">
				<table id="writeForm">
					<tr>
						<th width="15.46%">제목</th>
						<td width="40.46%"><input type="text" name="inquiry_subject" required="required"></td>
						<th width="23.31%">작성자</th>
						<td width="20.77%"><input type="text" name="inquiry_writer" value="${sessionScope.sMemberId }" readonly="readonly"></td>
<!-- 						<th width="17.31%">등록일</th> -->
<!-- 						<td width="30.77%"> -->
<%-- 							<fmt:formatDate value="${inquiry.inquiry_date}" pattern="yyyy-MM-dd"/> --%>
<!-- 						</td> -->
					</tr>
					<tr>
						<td colspan="4">
							<textarea rows="15" cols="70" name="inquiry_content" required="required"></textarea>
						</td>
					</tr>
				</table>
			</section>
			<hr>
			<div>
				<input type="submit" value="등록하기" style="text-align: right;">&nbsp;&nbsp;
				<input type="reset" value="다시쓰기">&nbsp;&nbsp;
				<input type="button" value="뒤로가기" onclick="location.href='InquiryList'">
			</div>
		</form>
	</article>

</body>
</html>