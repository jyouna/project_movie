<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 이벤트 등록</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/adminpage/event_dateCheck.js"></script>
<style type="text/css">

form>div {
	background-color: lightgrey;
	padding: 30px;
	width: 800px;
	border: 1px solid red;}

input[type="text"] {
	width: 600px;
	height: 30px;
	margin-bottom: 5px;}

.bottom {
	padding: 10px;
	width: 100px;
	border-radius: 20px;
	border: 3px;}

textarea {
     width: 100%; /* 너비 */
     height: 200px; /* 높이 */
     padding: 5px; /* 내부 여백 */
     box-sizing: border-box; /* 패딩과 보더를 포함한 크기 계산 */
     font-size: 16px; /* 폰트 크기 */
     line-height: 1.5; /* 줄 간격 */
     vertical-align: top; /* 상단 정렬 */}

#divBottom {
	text-align: center;
	border: 1px solid red;}

</style>
</head>
<body>
	<form action="EventBoardRegisSubmit" method="get">
		<h3>신규 이벤트 등록</h3>
		<div>
			제목 <input type="text" placeholder="제목을 입력하세요" name="event_subject" required><br>
			시작일 <input type="date" name="event_start_date" class="checkDate" id="event_start_date" required><br>
			종료일 <input type="date" name="event_end_date" class="checkDate" id="event_end_date"required><br>
			<input type="hidden" name="event_status" value="0">
			<textarea rows="10" cols="100" name="event_content" required>내용을 입력하세요</textarea>
			<input type="file" name="event_file1"><br>
			<input type="file" name="event_file2"><br>
			<input type="file" name="event_file3">
		</div>
		<div id="divBottom">
			<input type="submit" value="등록" class="bottom">
			<input type="reset" value="초기화" class="bottom">
			<input type="button" value="취소" class="bottom" onclick="history.back()">
		</div>
	</form>
<script type="text/javascript">
$(function(){
	let today = new Date().toISOString().split('T')[0];
	$("#event_start_date").attr("min", today);
	$("#event_end_date").attr("min", today);
	
	$("#event_start_date").on("change", function(){
		let startDate = $(this).val();
		let endDate = $("#event_end_date").val();
		console.log("시작일 : " + startDate);
		console.log("종료일" + endDate);
		
		if(endDate) { // null 및 undefined가 아닌 경우
			if(startDate > endDate) {
				alert("시작일이 종료일보다 늦을 수 없습니다.");
				$(this).val(endDate);
				return;
			}	
		}
		$("#event_end_date").attr("min", startDate);
	});
})
</script>
</body>
</html>