<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InquiryModify</title>
</head>
<body>
	<article id="articleForm">
		<h1>1:1문의 - 글 수정하기</h1>
		<section id="basicInfoArea">
		<form action="InquiryModify" method="post">
			<input type="hidden" name = "inquiry_code" value="${param.inquiry_code}">
			<input type="hidden" name = "pageNum" value="${param.pageNum }">
			<table>
				<tr>
					<th width="110px"> <label for="inquiry_subject"> </label>제목</th>
					<td width="220px"><input type ="text"  name ="inquiry_subject" value ="${inquiry.inquiry_subject}" required></td>
					<th width="90px">등록일</th>
					<td width="160px">
						<fmt:formatDate value="${inquiry.inquiry_date}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
				<tr>
					<th rowspan="4"><textarea id="inquiry_content" name="inquiry_content" rows="15" cols="40" required>${inquiry.inquiry_content}</textarea></th>
				</tr>		
			</table>
			<input type="submit" value ="등록">
		</form>
		</section>
	</article>
</body>
</html>