<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<section id="movieListBody">
		<div id="sec01">
			<div id="title">영화목록</div>
			<div id="search01">
				<input type="button" value="조회조건선택">
				<input type="button" value="조회">
			</div>
			<div id="search02">
				<select>
					<option>영화제목</option>
				</select>
				<input type="text" placeholder="검색어를 입력하세요">
				<input type="button" value="검색">
			</div>
		</div>
		
		<div id="sec02">
			<table>
				<tr>
					<th><input type="checkbox" name="checkMovie"></th>
	                <th>영화코드</th>
	                <th>영화제목</th>
	                <th>장르</th>
	                <th>관람등급</th>
	                <th>개봉일</th>
	                <th>영화상태</th>
	                <th>등록일자</th>
	                <th>등록계정</th>
				</tr>
				<tr>
	                <td><input type="checkbox" name="checkMovie"></td>
	                <td>ABCDEF</td>
	                <td>영화제목1</td>
	                <td>코미디</td>
	                <td>전체관람가</td>
	                <td>2022.11.24</td>
	                <td>대기</td>
	                <td>2023.02.14</td>
	                <td>admin1</td>
	            </tr>
	            <tr>
	                <td><input type="checkbox" name="checkMovie"></td>
	                <td>ABCDEF</td>
	                <td>영화제목2</td>
	                <td>코미디</td>
	                <td>12세 관람가</td>
	                <td>2022.11.24</td>
	                <td>상영중</td>
	                <td>2023.02.14</td>
	                <td>admin2</td>
	            </tr>
	            <tr>
	                <td><input type="checkbox" name="checkMovie"></td>
	                <td>ABCDEF</td>
	                <td>영화제목2</td>
	                <td>코미디</td>
	                <td>12세 관람가</td>
	                <td>2022.11.24</td>
	                <td>상영중</td>
	                <td>2023.02.14</td>
	                <td>admin2</td>
	            </tr>
	            <tr>
	                <td><input type="checkbox" name="checkMovie"></td>
	                <td>ABCDEF</td>
	                <td>영화제목2</td>
	                <td>코미디</td>
	                <td>12세 관람가</td>
	                <td>2022.11.24</td>
	                <td>상영중</td>
	                <td>2023.02.14</td>
	                <td>admin2</td>
	            </tr>
	            <tr>
	                <td><input type="checkbox" name="checkMovie"></td>
	                <td>ABCDEF</td>
	                <td>영화제목2</td>
	                <td>코미디</td>
	                <td>12세 관람가</td>
	                <td>2022.11.24</td>
	                <td>상영중</td>
	                <td>2023.02.14</td>
	                <td>admin2</td>
	            </tr>
	            <tr>
	                <td><input type="checkbox" name="checkMovie"></td>
	                <td>ABCDEF</td>
	                <td>영화제목2</td>
	                <td>코미디</td>
	                <td>12세 관람가</td>
	                <td>2022.11.24</td>
	                <td>상영중</td>
	                <td>2023.02.14</td>
	                <td>admin2</td>
	            </tr>
	            <tr>
	                <td><input type="checkbox" name="checkMovie"></td>
	                <td>ABCDEF</td>
	                <td>영화제목2</td>
	                <td>코미디</td>
	                <td>12세 관람가</td>
	                <td>2022.11.24</td>
	                <td>상영중</td>
	                <td>2023.02.14</td>
	                <td>admin2</td>
	            </tr>
	            <tr>
	                <td><input type="checkbox" name="checkMovie"></td>
	                <td>ABCDEF</td>
	                <td>영화제목2</td>
	                <td>코미디</td>
	                <td>12세 관람가</td>
	                <td>2022.11.24</td>
	                <td>상영중</td>
	                <td>2023.02.14</td>
	                <td>admin2</td>
	            </tr>
	            <tr>
	                <td><input type="checkbox" name="checkMovie"></td>
	                <td>ABCDEF</td>
	                <td>영화제목2</td>
	                <td>코미디</td>
	                <td>12세 관람가</td>
	                <td>2022.11.24</td>
	                <td>상영중</td>
	                <td>2023.02.14</td>
	                <td>admin2</td>
	            </tr>
	            <tr>
	                <td><input type="checkbox" name="checkMovie"></td>
	                <td>ABCDEF</td>
	                <td>영화제목2</td>
	                <td>코미디</td>
	                <td>12세 관람가</td>
	                <td>2022.11.24</td>
	                <td>상영중</td>
	                <td>2023.02.14</td>
	                <td>admin2</td>
	            </tr>
			</table>
	       	<div>
	            <input type="button" value="<">
	            <input type="button" value="1">
	            <input type="button" value=">">
	        </div>
		</div>
		
		<div id="sec03">
			<div>
				<input type="button" value="영화등록" id="openModal">
				<input type="button" value="영화정보변경">
				<input type="button" value="영화삭제">
				<input type="button" value="영화정보">
			</div>
			<div>
				<input type="button" value="투표영화로 등록">
				<input type="button" value="상영예정작으로 등록">
			</div>
		</div>
	</div>
	
	<div id="modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>영화 등록</h2>
            <button>영화 API 사용으로 검색</button>
            <hr>
            <form>
                <label>영화코드</label><input type="text"><br>
                <label>영화명</label><input type="text"><br>
                <label>장르</label><input type="text"><br>
                <label>감독</label><input type="text"><br>
                <label>출연</label><input type="text"><br>
                <label>개봉일</label><input type="date"><br>
                <label>러닝타임</label><input type="text"><br>
                <label>관람연령</label><input type="text"><br>
                <label>별점</label><input type="text"><br>
               	<label>줄거리</label><br>
                <textarea cols="40" rows="5"></textarea><br>
                <label>스틸컷 파일</label><br>
                <input type="file" multiple><br>
                <label>예고편 파일</label><br>
                <input type="file"><br>
                <label>영화 상태</label>
                <select>
                    <option value="default">대기(Default)</option>
                </select><br>
                <button type="submit">등록</button>
                <button type="reset">초기화</button>
                <button type="button" id="closeModal">닫기</button>
            </form>
        </div>
    </section>
    
    <script>
	    let modal = document.getElementById("modal");
	    let openModalButton = document.getElementById("openModal");
	    let closeModalButton = document.querySelector(".close");
	    let closeModalById = document.getElementById("closeModal");
	
	    // 모달 열기
	    openModalButton.onclick = () => {
	        modal.style.display = "block";
	    };
	
	    // 모달 닫기 (X 버튼)
	    closeModalButton.onclick = () => {
	        modal.style.display = "none";
	    };
	
	    // 모달 닫기 (닫기 버튼)
	    closeModalById.onclick = () => {
	        modal.style.display = "none";
	    };
	
	    // 모달 외부 클릭 시 닫기
	    window.onclick = (event) => {
	        if (event.target === modal) {
	            modal.style.display = "none";
	        }
	    };
    </script>
	
	
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>