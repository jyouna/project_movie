<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InquiryModify</title>
</head>
<body>
	<h2 style="text-align: center;">1:1문의 글 수정</h2>
		<form action="InquiryModify" name="writeForm" method="post">
		 <table id="ModifyForm">
		        <tr>
		            <td width="80" style="text-align: center;">제목</td>
		<!-- 		            원래 가져온 제목써야해 -->
		            <td colspan="3"><input type="text" required></td>
		        </tr>
		        <tr>
		           <td width="80" style="text-align: center;">작성일자</td>
		            <td><input type="date" required></td>
		            <td width="80" style="text-align: center;">작성자</td>
		            <td>${session.sId}</td>
		        </tr>
		        <tr>
		            <td colspan="4">
<!-- 		            원래 가져온 내용 -->
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