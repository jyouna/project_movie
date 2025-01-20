<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>당첨자 발표</title>
<link href="${pageContext.request.contextPath}/resources/css/adminpage/eventForm.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body>
	<div id="LayoutDiv1">
		<form action="WinnerNoticeBoard" method="get">
		<h1>당첨자 발표</h1>
			<input type="hidden" name="event_status" value="0">
			<table>
				<tr>
					<th>제목</th>
					<td colspan="4">
						<input type="text" placeholder="제목을 입력하세요" name="winner_notice_subject" required>
					</td>
				</tr>	
				<tr>
					<th>내용</th>
					<td colspan="4">
						<textarea rows="20" cols="100" name="winner_notice_content" required>내용을 입력하세요</textarea>
					</td>
				</tr>	
				<tr>
					<th>파일1</th>
					<td colspan="4">
						<input type="file" name="winner_notice_file1">
					</td>
				</tr>	
				<tr>
					<th>파일2</th>
					<td colspan="4">
						<input type="file" name="winner_notice_file2">
					</td>
				</tr>	
				<tr>
					<th>파일3</th>
					<td colspan="4">
						<input type="file" name="winner_notice_file3">
					</td>
				</tr>	
				<tr>
					<td colspan="5" align="center">
						<input type="submit" value="등록" class="bottom">
						<input type="reset" value="초기화" class="bottom">
						<input type="button" value="취소" class="bottom" onclick="window.close()">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>