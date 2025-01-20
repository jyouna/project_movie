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
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/movie_pick_set/movie_pick_set.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<section>
		<div id="body_top">
			<div id="title">투표 설정</div>
			<div id="btnGroup01">
				<input type="button" id="registPickBtn" value="투표등록">
				<input type="button" value="상영예정작으로 등록">
				<input type="button" value="투표영화에서 삭제하기">
				<input type="button" value="투표시작">
				<input type="button" value="투표종료">
			</div>
		</div>
		<div id="body_main">
			<div id="pick_movie_list">
				<table>
					<tr><th colspan="8">투표 영화</th></tr>
					<tr>
						<th><input type="checkbox" id="allCheck"></th>
						<th>영화코드</th>
						<th>영화제목</th>
						<th>투표기간</th>
						<th>상영시간</th>
						<th>관람연령</th>
					</tr>
					<c:forEach var="movie" items="${movieList}">
						<tr>
							<td><input type="checkbox" value="${movie.movie_code}" class="check"></td>
							<td>${movie.movie_code}</td>
							<td>${movie.movie_name}</td>
							<td>투표등록전입니다</td>
							<td>${movie.running_time}</td>
							<td>${movie.age_limit}</td>
						</tr>
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
	
	<div id="screening_date_modal" class="modal">
		<div class="modal_content">
			<form action="RegistPickInfo" method="post">
			   	   <h4>투표 등록</h4>
			    <hr>
		    	<label>투표명</label><input type="text" name="vote_name" placeholder="ex) 24년 겨울시즌 투표" required><br>
	    	    <label>투표시작날짜</label><input type="date" name="start_date" required><br>
	    	    <label>투표종료날짜</label><input type="date" name="end_date" required><br>
	    	    <label>투표영화1</label><input type="text" name="vote_movie1" value="${movieList[0].movie_code}" required readonly><br>
	    	    <label>투표영화2</label><input type="text" name="vote_movie2" value="${movieList[1].movie_code}" required readonly><br>
	    	    <label>투표영화3</label><input type="text" name="vote_movie3" value="${movieList[2].movie_code}" required readonly><br>
	    	    <label>투표영화4</label><input type="text" name="vote_movie4" value="${movieList[3].movie_code}" required readonly><br>
	    	    <label>투표영화5</label><input type="text" name="vote_movie5" value="${movieList[4].movie_code}" required readonly><br>
			    <div class="btnGroup">
			        <input type="submit" value="등록">
			        <input type="button" class="close_modal" value="닫기">
			    </div>
			</form>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>