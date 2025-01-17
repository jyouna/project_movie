<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InquiryWrite</title>
<link href="${pageContext.request.contextPath }/resources/css/mypage/inquiry/inquiryWrite.css" rel="stylesheet">
</head>
<body>
	<h2 style="text-align: center;">1:1문의 글 작성</h2>
		<form action="InquiryWrite" name="writeForm" method="post">
		 <table id="writeForm">
		        <tr>
		            <td width="80" style="text-align: center;">제목</td>
		            <td colspan="3"><input type="text" name="inquiry_subject" required></td>
		        </tr>
		        <tr>
		            <td width="80" style="text-align: center;">작성자</td>
		            <td>${sessionScope. sMemberId }</td>
		            <input type="hidden" name="inquiry_writer" value="${sessionScope. sMemberId }">
		        </tr>
		        <tr>
		            <td colspan="4">
		                <textarea id="inquiry_content" name="inquiry_content" required="required"></textarea>
		            </td>
		        </tr>
		    </table>
			<br>
			<section id="commandCell" style="text-align: center;">
				<input type="submit" value="등록">&nbsp;&nbsp;
				<input type="reset" value="다시쓰기">&nbsp;&nbsp;
				<input type="button" value="닫기" onclick="window.close()">
			</section>
		</form>
</body>
</html>