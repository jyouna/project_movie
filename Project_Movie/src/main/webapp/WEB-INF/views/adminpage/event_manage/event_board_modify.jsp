<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 게시글 수정</title>
<style type="text/css">
form>div {
	background-color: lightgrey;
	padding: 30px;
	width: 800px;
	border: 1px solid red;
}

input[type="text"] {
	width: 600px;
	height: 30px;
	margin-bottom: 5px;
}

.bottom {
	padding: 10px;
	width: 100px;
	border-radius: 20px;
	border: 3px;
}

textarea {
     width: 100%; /* 너비 */
     height: 200px; /* 높이 */
     padding: 5px; /* 내부 여백 */
     box-sizing: border-box; /* 패딩과 보더를 포함한 크기 계산 */
     font-size: 16px; /* 폰트 크기 */
     line-height: 1.5; /* 줄 간격 */
     vertical-align: top; /* 상단 정렬 */
}

#divBottom {
	text-align: center;
	border: 1px solid red;
}

.date {
	border-radius: 20px;
	border: 3px;
	margin-left: 2px;
	margin-bottom: 5px;
}
</style>
</head>
<body>
	<form action="updateEventBoard" method="post">
		<h3>이벤트 게시글 수정</h3>
		<div>
			제목 <input type="text" value="${eventVo.event_subject}" name="event_subject"><br>
			시작일 <input type="date" value="${eventVo.event_start_date}" name="event_start_date"><br>
			종료일 <input type="date" value="${eventVo.event_end_date}" name="event_end_date"><br>
			<textarea rows="10" cols="100" name="event_content">"${eventVo.event_content}"</textarea>
			<input type="file" name="event_file1" value="${eventVo.event_file1}"><br>
			<input type="file" name="event_file2" value="${eventVo.event_file2}"><br>
			<input type="file" name="event_file3" value="${eventVo.event_file3}">
		</div>
		<div id="divBottom">
			<input type="submit" value="수정" class="bottom">
			<input type="reset" value="초기화" class="bottom">
			<input type="button" value="취소" class="bottom" onclick="window.close()">
		</div>
	</form>
</body>
</html>