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
	<c:choose>
		<c:when test="${count == 0}">
			<h3>해당 건은 추첨이 취소되었습니다</h3>
		</c:when>
		<c:otherwise>
			<h3>당첨되신 ${count}분 축하 드립니다!</h3>
		</c:otherwise>
	</c:choose>
	<div id="tableDiv" class="view" style="overflow-x: auto;">
		<table id="mainTable">
			<tr align="center" id="tr01">
				<th>당첨자</th>
				<th>이벤트제목</th>
			</tr>
			<c:choose>
				<c:when test="${not empty voList}">
					<c:forEach var="vo" items="${voList}">
						<tr>
							<td>${vo.winner_id}</td>
							<td>${vo.event_subject}</td>
						</tr>
					</c:forEach>				
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="2">당첨자가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
<script type="text/javascript">
</script>
</body>
</html>