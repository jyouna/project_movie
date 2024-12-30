<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html lang="en">
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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/movie_pick_set/movie_pick_set.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<section>
		<div id="body_top">
			<div id="title">투표 설정</div>
			<div id="btnGroup01">
				<input type="button" value="투표등록">
				<input type="button" value="상영예정작으로 등록">
				<input type="button" value="삭제하기">
				<input type="button" value="투표시작">
				<input type="button" value="투표종료">
			</div>
			<div id="btnGroup02">
				<input type="button" value="영화정보">
			</div>
		</div>
		<div id="body_main">
			<div id="pick_movie_list">
				<table>
					<tr><th colspan="8">Season 영화</th></tr>
					<tr>
						<th><input type="checkbox" class="check"></th>
						<th>영화코드</th>
						<th>영화제목</th>
						<th>투표기간</th>
						<th>상영시간</th>
						<th>관람연령</th>
						<th>등록일자</th>
						<th>등록계정</th>
					</tr>
					<c:forEach var="i" begin="1" end="5">
						<tr>
							<th><input type="checkbox" class="check"></th>
							<td>ABCDFD</td>
							<td>극장판짱구는못말려</td>
							<td>24.06.17 ~ 24.08.08</td>
							<td>120분</td>
							<td>전체관람과</td>
							<td>24.05.31</td>
							<td>admin</td>
						<tr>
					</c:forEach>
				</table>
			</div>
			<div  id="pick_currently_status">
				<div>
					투표현황 그래프 들어갈자리
				</div>
				<table>
					<tr>
						<th colspan="5">투표 집계 결과</th>
						<th colspan="1"><input type="button" value="조회하기"></th>
					</tr>
					<tr>
						<th>순위</th>
						<th>영화코드</th>
						<th>영화제목</th>
						<th>투표수</th>
						<th>전체투표수</th>
						<th>백분율</th>
					</tr>
					<c:forEach var="i" begin="1" end="5">
						<tr>
							<th>${i}</th>
							<td>ABCDFD</td>
							<td>극장판짱구는못말려</td>
							<td>1560</td>
							<td>3120</td>
							<td>50%</td>
						<tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</section>
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>