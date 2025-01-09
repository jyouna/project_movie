<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InquiryWrite</title>
</head>
<body>
	<h2 style="text-align: center;">1:1문의 글 작성</h2>
	<article id="writeForm">
		<form action="InquiryWrite" name="writeForm" method="post">
			<table >
				<tr>
					<td class="write_td_left"><label for="inquiry_writer">글쓴이</label></td>
					<td class="write_td_right"><input type="text" name="inquiry_writer" value="${sessionScope.sId }" readonly/></td>
				</tr>
				<tr>
					<td class="write_td_left"><label for="inquiry_subject">제목</label></td>
					<td class="write_td_right"><input type="text" id="inquiry_subject" name="inquiry_subject" required="required" /></td>
				</tr>
				<tr>
					<td class="write_td_left"><label for="inquiry_content">내용</label></td>
					<td class="write_td_right">
						<textarea id="inquiry_content" name="inquiry_content" rows="15" cols="40" required="required"></textarea>
					</td>
				</tr>
			</table>
			<section id="commandCell" style="text-align: center;">
				<input type="submit" value="등록">&nbsp;&nbsp;
				<input type="reset" value="다시쓰기">&nbsp;&nbsp;
				<input type="button" value="취소" onclick="history.back()">
			</section>
		</form>
	</article>
</body>
</html>