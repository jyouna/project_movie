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
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/account_manage.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<style>
h3 {
	padding: 10px;
	background-color: lightgrey;
}


#mainTable {
	border: 2px solid black;
	border-collapse: collapse;
/* 	width: 800px; */
	text-align: center;
	padding: 10px;
}

input {
	margin-bottom: 2px;
}

#mainTable th, #mainTable td {
	width: 30%;
	border: 1px solid black; /* 각 셀에 경계선 추가 */
	padding: 8px; /* 셀 내부 여백 */
}

#mainTable tr {
	height: 50px;
}

#tableDiv {
	float:left;
	width: 45%;
	border: 1px solid red;
	height: 800px;
	margin: 20px;
}

#showStatics {
	float: right;
	width: 45%;
	margin: 20px;
	border: 1px solid red;
	height: 800px;
}

.layout {
	overflow: hidden;
    border: 1px solid red; /* 전체 컨테이너 테두리 */
}

.textBar {
	width: 130px;
	margin-bottom: 5px;
	margin-top: 5px;
}

</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<div class="layout">
		<div id="tableDiv">
		 	<h3>선호 영화 통계</h3>
			<input type="button" value="전체 기간" id="totalPeriodSearch">
			<input type="button" value="월 단위 조회" id="monthlySearch">
			<input type="button" value="상세 기간 조회" id="specificPeriodSearch">
			<br>
			<div> 기간 : <input type="text" class="textBar"> ~ <input type="text"  class="textBar"></div>
			<table id="mainTable">
				<tr>
					<th>장르명</th>
					<th>득표수</th>
					<th>비율</th>
				</tr>
				<tr>
					<td>액션스릴러</td>
					<td>55,555</td>
					<td>10%</td>
				</tr>
				<tr>
					<td>애니메이션</td>
					<td>512,434</td>
					<td>50%</td>
				</tr>
				<tr>
					<td>로맨스</td>
					<td>123,412</td>
					<td>40%</td>
				</tr>
				<tr>
					<td>로맨스</td>
					<td>123,412</td>
					<td>40%</td>
				</tr>
				<tr>
					<td>로맨스</td>
					<td>123,412</td>
					<td>40%</td>
				</tr>
				<tr>
					<td>로맨스</td>
					<td>123,412</td>
					<td>40%</td>
				</tr>
				<tr>
					<td>로맨스</td>
					<td>123,412</td>
					<td>40%</td>
				</tr>
				<tr>
					<td colspan="2">합계</td>
					<td>100%</td>
				</tr>
			</table>
		 </div>
		 <div id="showStatics">
		 	<h3> 통계 그래프 표시 영역 </h3>
		 </div>
	</div>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
	
	<script type="text/javascript">
	$(function(){
		$("#totalPeriodSearch").on("click",function(){
			alert("전체 기간 조회");
		});

		$("#monthlySearch").on("click",function(){
			alert("월 단위 조회");
		});
		
		$("#specificPeriodSearch").on("click",function(){
			window.open(
				'specificPeriodSearch', // 팝업 창에 로드할 파일
    	        '상세기간 조회',    // 팝업 창 이름
        	    'width=300,height=200,scrollbars=no,resizable=no');
		});
	});
	
	</script>
</body>
</html>