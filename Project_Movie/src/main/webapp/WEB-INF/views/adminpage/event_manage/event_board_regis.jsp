<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 이벤트 등록</title>
<link href="${pageContext.request.contextPath}/resources/css/adminpage/eventForm.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body>
	<div id="LayoutDiv1">
		<form action="EventBoardRegisSubmit" method="get">
		<h1>신규 이벤트 등록</h1>
			<input type="hidden" name="event_status" value="0">
			<table>
				<tr>
					<th>이벤트제목</th>
					<td colspan="4">
						<input type="text" placeholder="제목을 입력하세요" name="event_subject" required>
					</td>
				</tr>	
				<tr>
					<th>시작일</th>
					<td colspan="4">
						<input type="date" name="event_start_date" class="checkDate" id="event_start_date" required>
					</td>
				</tr>	
				<tr>
					<th>종료일</th>
					<td colspan="4">
						<input type="date" name="event_end_date" class="checkDate" id="event_end_date"required>
					</td>
				</tr>	
				<tr>
					<th>내용</th>
					<td colspan="4">
						<textarea rows="20" cols="100" name="event_content" id="event_content" required>내용을 입력하세요</textarea>
					</td>
				</tr>	
				<tr>
					<th>파일1</th>
					<td colspan="4">
						<input type="file" name="event_file1">
					</td>
				</tr>	
				<tr>
					<th>파일2</th>
					<td colspan="4">
						<input type="file" name="event_file2">
					</td>
				</tr>	
				<tr>
					<th>파일3</th>
					<td colspan="4">
						<input type="file" name="event_file3">
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
<script type="text/javascript">
$(function(){
	let time = new Date();
	time.setHours(time.getHours() + 9); // UTC+9 적용
	let today = time.toISOString().split('T')[0];
	
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