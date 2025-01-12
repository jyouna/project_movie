<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <option value="지난상영작" disabled>지난상영작</option>
            </select><br>
            <div class="btnGroup">
            	<button type="submit">등록</button>
            	<button type="reset">초기화</button>
            	<button type="button" id="close_modal">닫기</button>
            </div>
        </form>
    </div>
</div>