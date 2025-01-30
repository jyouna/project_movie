<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>


<div id="season_movie_list">
	<div>
		<h2>Season Movie</h2>
	</div>
	<c:choose>
		<c:when test="${seasonMovieCount < 3}">
			<img src="${pageContext.request.contextPath}/resources/images/coming_soon.jpg">
		</c:when>
		<c:otherwise>
			<div>
				<c:forEach var="i" begin="0" end="${seasonMovieCount - 1}">
					<div class="movie">
						<label>${movieList[i].movie_name}</label>(${movieList[i].movie_rating})<br>
						<a href=""><img src="${movieList[i].movie_img1}"></a><br>
						<input type="button" value="자세히보기" onclick="location.href='MovieInfoDetail?movie_code=${movieList[i].movie_code}'">
						<input type="button" value="예매하기" onclick="location.href='BookTickets'" <c:if test="${movieList[i].movie_status == '상영예정작'}">disabled</c:if>>
						<div class="movie_info">
	            			&lt;${movieList[i].movie_name}&gt;
				            <ul>
					            <li>감독: ${movieList[i].movie_director}</li>
					            <li>출연:<br> ${movieList[i].movie_actor}</li>
					            <li>등급: ${movieList[i].age_limit}</li>
					            <li>장르: ${movieList[i].movie_genre}</li>
					            <li>개봉일: ${movieList[i].release_date}</li>
					            <li>러닝 타임: ${movieList[i].running_time}</li>
					            <li>예매가: ${generalPrice}원</li>
				            </ul>
				        </div>
					</div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>
</div>
<div id="movie_list">
	<div>
		<c:forEach var="i" begin="${seasonMovieCount}" end="${seasonMovieCount + generalMovieCount - 1}">
			<div class="movie">
				<label>${movieList[i].movie_name}</label>(${movieList[i].movie_rating})<br>
				<a href=""><img src="${movieList[i].movie_img1}"></a><br>
				<input type="button" value="자세히보기" onclick="location.href='MovieInfoDetail?movie_code=${movieList[i].movie_code}'">
				<input type="button" id="bookingBtn" value="예매하기" onclick="location.href='BookTickets'" <c:if test="${movieList[i].movie_status == '상영예정작'}">disabled</c:if>>
				<div class="movie_info">
	           		<${movieList[i].movie_name}>
		            <ul>
			            <li>감독: ${movieList[i].movie_director}</li>
			            <li>출연:<br> ${movieList[i].movie_actor}</li>
			            <li>등급: ${movieList[i].age_limit}</li>
			            <li>장르: ${movieList[i].movie_genre}</li>
			            <li>개봉일: ${movieList[i].release_date}</li>
			            <li> 러닝 타임: ${movieList[i].running_time}</li>
			            <li>예매가: ${generalPrice}원</li>
		            </ul>
		        </div>
			</div>
		</c:forEach>
	</div>
</div>