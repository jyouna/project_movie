<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>관리자페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/statics.css" rel="stylesheet" />	
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/statics.js"></script>
	
<style>
/* h3 { */
/* 	padding: 10px; */
/* 	background-color: lightgrey; */
/* } */

/* #tableDiv { */
/* 	border: 1px solid red; */
/* 	width: 800px; */
/* 	margin: 20px; */
/* } */

/* #mainTable { */
/* 	border: 2px solid black; */
/* 	border-collapse: collapse; */
/* 	height: 20px; */
/* 	width: 800px; */
/* 	text-align: center; */
/* 	padding: 10px; */
/* } */

/* #mainTable th, #mainTable td { */
/* 	width: 50%; */
/* 	border: 1px solid black; /* 각 셀에 경계선 추가 */ */
/* 	padding: 8px; /* 셀 내부 여백 */ */
/* } */

/* #showStatics { */
/* 	margin: 20px; */
/* 	border: 1px solid red; */
/* 	width: 800px; */
/* 	height: 400px; */
/* } */

/* input { */
/* 	margin-bottom: 5px; */
/* } */
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	
	<div id="tableDiv">
	<h3>매출 통계</h3>
		<input type="button" value="전체 기간" id="totalPeriodSearch">
		<input type="button" value="월 단위 조회" id="monthlySearch">
		<input type="button" value="상세 기간 조회" id="specificPeriodSearch">
		<table id="mainTable">
			<tr>
				<th>기간</th>
				<th>매출 통계</th>
			</tr>
			<tr>
				<th>2024.01.01 ~ 2024.12.31</th>
				<th>5555</th>
			</tr>
		</table>
	</div>
	
	<div id="showStatics">
	<h3>연간 매출 통계</h3>
	</div>
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
</body>
</html>