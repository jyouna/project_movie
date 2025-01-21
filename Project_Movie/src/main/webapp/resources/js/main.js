$(function() {
	// 메인페이지 영화포스터 좌우 버튼 클릭시 append할 문자열 배열
	const addMovieListStr = [];
	
	// 현재 상영작 리스트 조회
	$.ajax({
		type : "GET",
		url : "mainGetCurrentMovie",
	}).done(function(movieList) {
		let count = 0;
		for(let movie of movieList) {
			addMovieListStr.push(
				`<div class="movieImgDiv">
					<input type="hidden" value="${count}">
					<img src="${movie.movie_img1}" title="상세페이지로 이동" 
						onclick="location.href='MovieInfoDetail?movie_code=${movie.movie_code}'">
					<label>${movie.movie_name}</label>
				</div>`
			); 
			
			count ++;
		}
		
		for(let index = 0; index < 3; index++) {
			$(".style2").append(addMovieListStr[index]);
		}	
		
	}).fail(function() {
		alert("영화정보 불러오기에 실패했습니다");
	});
	
	// 오른쪽 버튼 클릭시 첫 영화 포스터 삭제 후 다음 영화 포스터 추가
	$("#rightBtn").click(function() {
		// 첫번째 포스터 삭제
		$(".style2 div:first-child").remove();
		// 마지막 요소의 index 변수에 초기화
		let lastIndex = parseInt($(".style2 div:last-child").find("input").val());
		// 마지막 요소가 배열의 마지막요소이면 첫번째 요소의 영화 포스터 추가
		if(lastIndex == addMovieListStr.length - 1) {
			$(".style2").append(addMovieListStr[0]);
		} else {
			$(".style2").append(addMovieListStr[lastIndex + 1]);
		}
	});
	
	// 왼쪽 버튼 클릭시 마지막 영화 포스터 삭제 후 이전 영화 포스터 추가
	$("#leftBtn").click(function() {
		// 마지막 포스터 삭제
		$(".style2 div:last-child").remove();
		// 첫번째 요소의 index 변수에 초기화
		let firstIndex = parseInt($(".style2 div:first-child").find("input").val());
		// 첫번째 요소가 배열의 제일 처음 요소이면 마지막 요소의 영화 포스터 추가
		if(firstIndex == 0) {
			$(".style2").prepend(addMovieListStr[addMovieListStr.length - 1]);
		} else {
			$(".style2").prepend(addMovieListStr[firstIndex - 1]);
		}
	});
	
});