<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InquiryModify</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/inquiry/inquiryModify.css" />
</head>
<body>
	<h2 style="text-align: center;">1:1문의 글 수정</h2>
		<form action="InquiryModify" name="writeForm" method="post">
			<input type="hidden" name="inquiry_code" value="${param.inquiry_code }">
			<input type="hidden" name="pageNum" value="${param.pageNum }">
			<table id="ModifyForm">
		        <tr>
		            <td width="80" style="text-align: center;"><label for="inquiry_subject">제목</label></td>
		            <td colspan="3"><input type="text" name="inquiry_subject" value="${Inquiry.inquiry_subject }" required="required"></td>
		        </tr>
		        <tr>
		            <td width="80" style="text-align: center;">작성자</td>
		            <td>${sessionScope.sMemberId }</td>
		            <input type="hidden" name ="inquiry_writer" value="${sessionScope.sMemberId }" readonly="readonly"> 
		        </tr>
		        <tr>
		            <td colspan="4">
		                <textarea id="inquiry_content" name="inquiry_content" value ="${Inquiry.inquiry_content}"required="required"></textarea>
		            </td>
		        </tr>
			    </table>
			<br>
			<section id="commandCell" style="text-align: center;">
				<input type="submit" id="btnSubmit" value="등록">&nbsp;&nbsp;
				<input type="reset" value="다시쓰기">&nbsp;&nbsp;
				<input type="button" value="닫기" onclick="window.close()">
			</section>
		</form>
		<script type="text/javascript">
			let isSubmitProcessing = false;
			$("form").on("submit", function() {
				if(!isSubmitProcessing){
					isSubmitProcessing = true;
					return true;
				}
				return false;
			});
		
		
		</script>
</body>
</html>