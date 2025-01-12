<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="movie_info_modal" class="modal">
	<div class="modal_content2">
	    <h2>영화 정보</h2>
	    <hr>
        <label>영화코드</label><input type="text" name="movie_code" readonly><br>
        <label>영화명</label><input type="text" name="movie_name" readonly><br>
        <label>장르</label><input type="text" name="movie_genre" readonly><br>
        <label>감독</label><input type="text" name="movie_director" readonly><br>
        <label>출연</label><input type="text" name="movie_actor" readonly><br>
        <label>개봉일</label><input type="date" name="release_date" readonly><br>
        <label>러닝타임</label><input type="text" name="running_time" readonly><br>
        <label>관람연령</label><input type="text" name="age_limit" readonly><br>
        <label>별점</label><input type="text" name="movie_rating" readonly><br>
       	<label>줄거리</label><br>
        <textarea cols="40" rows="5" name="movie_synopsis"></textarea><br>
        <label class="url_label">이미지1</label><input type="text" class="url" name="movie_img1" readonly>
        <label class="url_label">이미지2</label><input type="text" class="url" name="movie_img2" readonly><br>
        <label class="url_label">이미지3</label><input type="text" class="url" name="movie_img3" readonly>
        <label class="url_label">이미지4</label><input type="text" class="url" name="movie_img4" readonly><br>
        <label class="url_label">이미지5</label><input type="text" class="url" name="movie_img5" readonly>
        <label class="url_label">예고편</label><input type="text" class="url" name="movie_trailer" readonly><br>
        <label>영화상태</label>
        <select name="movie_status">
            <option value="대기" disabled>대기</option>
            <option value="투표영화" disabled>투표영화</option>
            <option value="상영예정작">상영예정작</option>
            <option value="현재상영작" disabled>현재상영작</option>
            <option value="과거상영작" disabled>과거상영작</option>
        </select><br>
        <div class="btnGroup">
        	<button type="button" class="close_modal">닫기</button>
        </div>
	</div>
</div>