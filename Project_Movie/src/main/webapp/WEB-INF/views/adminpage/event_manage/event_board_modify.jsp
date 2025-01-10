<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 게시글 수정</title>
<link href="${pageContext.request.contextPath}/resources/css/adminpage/eventForm.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body>
	<div id="LayoutDiv1">
		<form action="updateEventBoard" method="post">
		<h1>이벤트 게시글 수정</h1>
			<table>
				<tr>
					<th>이벤트제목</th>
					<td colspan="4">
						<input type="text" value="${eventVo.event_subject}" name="event_subject" required>
					</td>
				</tr>	
				<tr>
					<th>등록일</th>
					<td colspan="4">
						<input type="datetime-local" name="event_file3" value="${eventVo.regis_date}" id="regis_date" class="checkDate" readonly>
					</td>
				</tr>	
				<tr>
					<th>시작일</th>
					<td colspan="4">
						<input type="date" value="${eventVo.event_start_date}" name="event_start_date" id="event_start_date" class="checkDate" required>
					</td>
				</tr>
				<tr>
					<th>종료일</th>
					<td>
						<input type="date" value="${eventVo.event_end_date}" name="event_end_date" id="event_end_date" class="checkDate" required>
					</td>
				</tr>	
				<tr>
					<th>내용</th>
					<td colspan="4">
						<textarea rows="10" cols="100" name="event_content" required>"${eventVo.event_content}"</textarea>
					</td>
				</tr>	
				<tr>
					<th>파일1</th>
					<td colspan="4">
						<input type="file" name="event_file1" value="${eventVo.event_file1}">
					</td>
				</tr>	
				<tr>
					<th>파일2</th>
					<td colspan="4">
						<input type="file" name="event_file2" value="${eventVo.event_file2}">
					</td>
				</tr>	
				<tr>
					<th>파일3</th>
					<td colspan="4">
						<input type="file" name="event_file3" value="${eventVo.event_file3}">
					</td>
				</tr>	
				<tr>
					<td colspan="5" align="center">
						<input type="submit" value="등록" class="bottom">
						<input type="reset" value="초기화" class="bottom">
						<input type="button" value="취소" class="bottom" onclick="history.back()">
					</td>
				</tr>
			</table>
		</form>
	</div>




<!-- 	<div id="LayoutDiv1"> -->
<!-- 		<form action="updateEventBoard" method="post"> -->
<!-- 			<h3>이벤트 게시글 수정</h3> -->
<!-- 			<div> -->
<%-- 				제목 <input type="text" value="${eventVo.event_subject}" name="event_subject"><br> --%>
<%-- 				등록일 <input type="datetime-local" name="event_file3" value="${eventVo.regis_date}" id="regis_date" readonly><br> --%>
<%-- 				시작일 <input type="date" value="${eventVo.event_start_date}" name="event_start_date" id="event_start_date" ><br> --%>
<%-- 				종료일 <input type="date" value="${eventVo.event_end_date}" name="event_end_date" id="event_end_date"><br> --%>
<%-- 				<textarea rows="10" cols="100" name="event_content">"${eventVo.event_content}"</textarea> --%>
<%-- 				<input type="file" name="event_file1" value="${eventVo.event_file1}"><br> --%>
<%-- 				<input type="file" name="event_file2" value="${eventVo.event_file2}"><br> --%>
<%-- 				<input type="file" name="event_file3" value="${eventVo.event_file3}"> --%>
<!-- 			</div> -->
<!-- 			<div id="divBottom"> -->
<!-- 				<input type="submit" value="수정" class="bottom"> -->
<!-- 				<input type="reset" value="초기화" class="bottom"> -->
<!-- 				<input type="button" value="취소" class="bottom" onclick="history.back()"> -->
<!-- 			</div> -->
<!-- 		</form> -->
<!-- 	</div> -->
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