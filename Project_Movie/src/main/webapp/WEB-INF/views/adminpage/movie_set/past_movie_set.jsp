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
			<div id="title">지난상영작 관리</div>
			<div id="search01">
				<input type="button" value="전체 지난상영작 조회" onclick="location.href='AdminMovieSetPast'">
				<input type="button" id="movie_detail_info" value="영화정보">
			</div>
			<div id="search02">
				<form action="AdminMovieSetPast">
					<select class="search_box" name="howSearch">
						<option value="movie_name" <c:if test ="${param.howSearch eq 'movie_name'}">selected</c:if>>영화제목</option>
						<option value="movie_genre" <c:if test ="${param.howSearch eq 'movie_genre'}">selected</c:if>>장르</option>
					</select>
					<c:choose>
						<c:when test="${not empty param.searchKeyword}">
							<input type="text" name="searchKeyword" value="${param.searchKeyword}"required>
						</c:when>
						<c:otherwise>
							<input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" required>
						</c:otherwise>
					</c:choose>
					<input type="submit" value="검색">
				</form>
			</div>
		</div>
		
		<div id="sec02">
			<table>
				<tr>
					<th style="width:30px"><input type="radio" name="movie_radio" disabled></th>
	                <th style="width:80px">영화코드</th>
	                <th style="width:242px">영화제목</th>
	                <th style="width:231px">장르</th>
	                <th style="width:130px">관람등급</th>
	                <th style="width:180px">상영기간</th>
	                <th style="width:98px">영화상태</th>
				</tr>
				<c:choose>
					<c:when test="${empty movieList}">
						<tr>
							<td colspan="8">
								검색 결과가 없습니다. 검색어를 확인해주세요<br>
								(영화장르 - 코미디, 드라마, 액션, SF, 범죄,  스릴러, 공포, 판타지<br>
								애니메이션, 어드벤처, 미스터리... )
							</td>
						<tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="movie" items="${movieList}">
							<tr>
				                <td><input type="radio" name="movie_radio"></td>
				                <td>${movie.movie_code}</td>
				                <td>${movie.movie_name}</td>
				                <td>${movie.movie_genre}</td>
				                <td>${movie.age_limit}</td>
				                <td>
<%-- 				                	<fmt:formatDate value="${movie.start_screening_date}" pattern="yyyy-MM-dd"/> --%>
<%-- 			                		~ <fmt:formatDate value="${movie.end_screening_date}" pattern="yyyy-MM-dd"/> --%>
				                	${movie.start_screening_date} ~ ${movie.end_screening_date}
			                	</td>
				                <td>${movie.movie_status}</td>
				            </tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
	       	<div class="page_btn_group">
				<c:if test="${not empty param.searchKeyword}">
					<c:set var="searchParam" value="&howSearch=${param.howSearch}&searchKeyword=${param.searchKeyword}"/>			
				</c:if>
				<c:if test="${pageInfo.maxPage != 0}">
		            <input type="button" value="<" <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>
		            	onclick="location.href='AdminMovieSetPast?pageNum=${pageInfo.pageNum - 1}${searchParam}'">
		            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
		            	<c:choose>
		            		<c:when test="${pageInfo.pageNum eq i}">
		            			<b>${i}</b>
		            		</c:when>
		            		<c:otherwise>
		            			<a href="AdminMovieSetPast?pageNum=${i}${searchParam}">${i}</a>
		            		</c:otherwise>
		            	</c:choose>
		            </c:forEach>
		            <input type="button" value=">" <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>
		            onclick="location.href='AdminMovieSetPast?pageNum=${pageInfo.pageNum + 1}${searchParam}'">
				</c:if>
	        </div>
		</div>
		
    </section>
    
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/movie_set/movie_regist_modal.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>