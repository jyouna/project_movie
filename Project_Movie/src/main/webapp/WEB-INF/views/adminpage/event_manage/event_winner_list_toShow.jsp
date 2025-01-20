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
	<title>이벤트 당첨자</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
</head>
<body>
	<h3 id="titleMent">축하드립니다 ! </h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
		</div>	
	</div>
	
	<div id="tableDiv" class="view" style="overflow-x: auto;">
		<table id="mainTable" class="mainTable">
			<tr align="center" id="tr01" class="tr01">
				<th>이벤트명</th>
				<th>당첨자</th>
				<th>쿠폰종류</th>
			</tr>
			<c:forEach var="winner" items="${voList}">
				<tr>
					<td>${winner.event_subject}</td>
					<td>${winner.winner_id}</td>
					<td>
						<c:choose>
							<c:when test="${(empty winner.discount_rate || winner.discount_rate == 0) && (empty winner.discount_amount || winner.discount_amount == 0)}">
								${winner.point_amount}포인트						
							</c:when>
							<c:when test="${(empty winner.discount_amount || winner.discount_amount == 0) && (empty winner.point_amount || winner.point_amount == 0)}">
								${winner.discount_rate}% 할인쿠폰						
							</c:when>
							<c:otherwise>
								${winner.discount_amount}원 할인쿠폰
							</c:otherwise>	
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<script type="text/javascript">
	$(function(){
		const urlParams = new URLSearchParams(window.location.search); // URL 파라미터 가져오기
	    const event_code = urlParams.get("event_code");
	
		console.log("urlParams : " + urlParams);
		console.log("이벤트코드 : " + event_code);
		
		
		$.ajax({
			url: "GetWinnerCountForShow",
			type: "get",
			data: {event_code : event_code}
		}).done(function(response){			
			$("#titleMent").prepend("당첨되신 " + response + "분 ");
		});
	});
	</script>
	
</body>
</html>