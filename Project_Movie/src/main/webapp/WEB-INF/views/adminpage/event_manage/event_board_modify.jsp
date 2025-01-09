<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<title>이벤트 게시글 수정</title>
<script src="${pageContext.request.contextPath}/resources/js/adminpage/event_dateCheck.js"></script>
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
			등록일 <input type="datetime-local" name="event_file3" value="${eventVo.regis_date}" id="regis_date" readonly><br>
			시작일 <input type="date" value="${eventVo.event_start_date}" name="event_start_date" id="event_start_date" ><br>
			종료일 <input type="date" value="${eventVo.event_end_date}" name="event_end_date" id="event_end_date"><br>
			<textarea rows="10" cols="100" name="event_content">"${eventVo.event_content}"</textarea>
			<input type="file" name="event_file1" value="${eventVo.event_file1}"><br>
			<input type="file" name="event_file2" value="${eventVo.event_file2}"><br>
			<input type="file" name="event_file3" value="${eventVo.event_file3}">
		</div>
		<div id="divBottom">
			<input type="submit" value="수정" class="bottom">
			<input type="reset" value="초기화" class="bottom">
			<input type="button" value="취소" class="bottom" onclick="history.back()">
		</div>
	</form>
	<script type="text/javascript">
	$(function(){
		let regisDate = $("#regis_date").val().split("T")[0];
		let startDate = $("#event_start_date").val();
		let endDate = $("#event_end_date").val();
		
		if (regisDate != null) {
	        $("#event_start_date").attr("min", regisDate);
	        $("#event_end_date").attr("min", startDate);
	    }
		
		$("#event_start_date").on("change", function(){
			startDate = $("#event_start_date").val();
			endDate = $("#event_end_date").val();
			
			if(endDate) { // null 및 undefined가 아닌 경우
				if(startDate > endDate) {
					alert("시작일이 종료일보다 늦을 수 없습니다.");
					$(this).val(endDate);
					return;
				} else {
					$("#event_end_date").attr("min", startDate);
					return;
				}	
				$("#event_end_date").attr("min", startDate);
			}
		});
	})
	</script>
</body>
</html>