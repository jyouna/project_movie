<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>포인트 지급</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<%-- 	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script> --%>
</head>
<body>
	<form id="givePointForm">
		<div id="tableDiv" class="view" style="overflow-x: auto;">
		<h3>포인트 지급</h3>
			<fieldset>
				<table class="mainTable"> 
					<tr class="tr01">
						<th>포인트 금액</th>
					</tr>
					<tr>
						<td><input type="text" maxlength="5" name="point_amount" id="point" value="0" placeholder="금액 입력" ></td>
					</tr>
				</table>			
			</fieldset>
			<div id="couponSet">
				<input type="submit" value="지급하기">
				<input type="button" value="돌아가기" id="closeForm">
			</div>
			<br>
			<h3>포인트 지급 대상자</h3>
			<fieldset> <!--  지급 대상자 출력 항목 -->
				<table id="mainTable" class="mainTable">
					<tr align="center" id="tr01" class="tr01">
						<th width="150">순서</th>
						<th>아이디</th>
					</tr>
					<c:choose>
						<c:when test="${empty member_id}">
							<tr>
								<th colspan="3">"선택된 대상자가 없습니다"</th>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="id" items="${member_id}" varStatus="status">
								<tr>
									<td>${status.count}</td>
									<td class="getIdList">${id}</td>
								</tr>	
							</c:forEach>
						</c:otherwise>
					</c:choose> 
				</table>
			</fieldset>
		</div>
	</form>
<script type="text/javascript">
$(function(){
	$("#givePointForm").on("submit", function(event){
		event.preventDefault();
		
		if(!confirm("포인트를 지급하시겠습니까?")) {
			return;
		}
		
		const member_id = $(".getIdList").map(function() {
			return $(this).text();
	    }).get();
		
		let point = $("#point").val();
		
		$.ajax({
			url: "CreditPoint",
			type: "post",
			traditional: true, // 배열 데이터를 단순 키-값 형태로 전송. 없으면 전달 안됨 
			data: {
				member_id : member_id,
				point_amount : point
			}
		}).done(function(response){
			if(response){
				alert("포인트가 지급되었습니다");
				window.opener.location.replace("MemberList");
				window.close();
			} else {
				alert("포인트 지급 실패");
			}
		});
	});
	
	$("#closeForm").on("click", function(){
		window.close();
	})
})
</script>
</body>
</html>