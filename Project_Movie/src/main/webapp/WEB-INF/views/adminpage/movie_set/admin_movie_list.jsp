<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/movie_set/admin_movie_list.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/movie_set/admin_movie_list.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<section id="movieListBody">
		<div id="sec01">
			<div id="title">영화목록</div>
			<div id="search01">
				<input type="button" value="전체 영화 조회" onclick="location.href='AdminMovieSetList'">
			</div>
			<div id="search02">
				<select class="search_box">
					<option selected="selected" value="movie_name">영화제목</option>
					<option value="movie_genre">장르</option>
					<option value="movie_status">영화상태</option>
				</select>
				<input type="text" placeholder="검색어를 입력하세요">
				<input type="button" value="검색">
			</div>
		</div>
		
		<div id="sec02">
			<table>
				<tr>
					<th><input type="radio" name="movie_radio" disabled></th>
	                <th>영화코드</th>
	                <th>영화제목</th>
	                <th>장르</th>
	                <th>관람등급</th>
	                <th>영화상태</th>
	                <th>등록일자</th>
	                <th>등록계정</th>
				</tr>
				<c:choose>
					<c:when test="${empty movieList}">
						<tr><td colspan="8">게시물이 존재하지 않습니다</td><tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="movie" items="${movieList}">
							<tr>
				                <td><input type="radio" name="movie_radio"></td>
				                <td>${movie.movie_code}</td>
				                <td>${movie.movie_name}</td>
				                <td>${movie.movie_genre}</td>
				                <td>${movie.age_limit}</td>
				                <td>${movie.movie_status}</td>
				                <td><fmt:formatDate value="${movie.regist_date}" pattern="yyyy-MM-dd"/></td>
				                <td>${movie.regist_admin_id}</td>
				            </tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
	       	<div class="page_btn_group">
	            <input type="button" value="<" <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>
	            	onclick="location.href='AdminMovieSetList?pageNum=${pageInfo.pageNum - 1}'">
	            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
	            	<c:choose>
	            		<c:when test="${pageInfo.pageNum eq i}">
	            			<b>${i}</b>
	            		</c:when>
	            		<c:otherwise>
	            			<a href="AdminMovieSetList?pageNum=${i}">${i}</a>
	            		</c:otherwise>
	            	</c:choose>
	            </c:forEach>
	            <input type="button" value=">" <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>
	            onclick="location.href='AdminMovieSetList?pageNum=${pageInfo.pageNum + 1}'">
	            
	        </div>
		</div>
		<div id="sec03">
			<div>
				<input type="button" value="영화등록" id="regist_modal_open">
				<input type="button" value="영화삭제" id="delete_movie">
				<input type="button" value="영화정보" id="movie_detail_info">
			</div>
			<div>
				<input type="button" value="투표영화로 등록" id="regist_pick">
				<input type="button" value="상영예정작으로 등록" id="regist_upcoming">
			</div>
		</div>
	
    </section>
    
	<div id="regist_movie_modal" class="modal">
        <div class="modal_content">
            <h2>영화 등록</h2>
            <hr>
            <form action="" class="form01">
                <label><input type="radio" name="search_method" value="movieNm" checked>영화명으로 조회</label><input type="text" id="movie_name"><br>
                <label><input type="radio" name="search_method" value="directorNm" >감독명으로 조회</label><input type="text" id="director_name" disabled><br>
                <label><input type="radio" name="search_method" value="releaseYear">개봉년도로 조회</label><select id="release_year_select1" disabled><option value="선택">선택</option></select>
                ~ <select id="release_year_select2" disabled><option value="선택">선택</option></select><br>
                <input type="button" id="request_movie_info_btn" value="영화조회하기">
                <hr>
	            <div class="search_table">
	            </div>
            </form>
            <form action="AdminMovieInfoRegist" class="form02" method="post">
                <label>영화코드</label><input type="text" name="movie_code" required><br>
                <label>영화명</label><input type="text" name="movie_name" required><br>
                <label>장르</label><input type="text" name="movie_genre" required><br>
                <label>감독</label><input type="text" name="movie_director" required><br>
                <label>출연</label><input type="text" name="movie_actor" required><br>
                <label>개봉일</label><input type="date" name="release_date" required><br>
                <label>러닝타임</label><input type="text" name="running_time" required><br>
                <label>관람연령</label><input type="text" name="age_limit" required><br>
                <label>별점</label><input type="text" name="movie_rating" required><br>
               	<label>줄거리</label><br>
                <textarea cols="40" rows="5" name="movie_synopsis" required="required"></textarea><br>
                <label class="url_label">이미지1</label><input type="text" class="url" name="movie_img1" required>
                <label class="url_label">이미지2</label><input type="text" class="url" name="movie_img2" required><br>
                <label class="url_label">이미지3</label><input type="text" class="url" name="movie_img3" required>
                <label class="url_label">이미지4</label><input type="text" class="url" name="movie_img4" required><br>
                <label class="url_label">이미지5</label><input type="text" class="url" name="movie_img5" required>
                <label class="url_label">예고편</label><input type="text" class="url" name="movie_trailer" required><br>
                <label>영화상태</label>
                <select name="movie_status" required="required">
                    <option value="대기">대기</option>
                    <option value="투표영화" disabled>투표영화</option>
                    <option value="상영예정작" disabled>상영예정작</option>
                    <option value="현재상영작" disabled>현재상영작</option>
                    <option value="과거상영작" disabled>과거상영작</option>
                </select><br>
                <div class="btnGroup">
                	<button type="submit">등록</button>
                	<button type="reset">초기화</button>
                	<button type="button" id="close_modal">닫기</button>
                </div>
            </form>
        </div>
    </div>
    
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>