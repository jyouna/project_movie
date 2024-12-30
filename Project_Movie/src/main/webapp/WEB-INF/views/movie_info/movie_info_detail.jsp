<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<!--
	Escape Velocity by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movie_info/movie_info_detail.css" />
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/movie_info_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<div id="movie_info_detail">
			<div id="page_top">
				현재상영작
			</div>
			<div>
				<div id="movie_poster">
					<img src="${pageContext.request.contextPath}/resources/images/poster1.webp"><br>
					<input type="button" value="예매하기">
				</div>
				<div id="movie_info">
					<b>영화제목</b>
					<p id="p01">
						★★★★★ <br>
						2024/12/31 | 120분 | 전체관람가
					</p>
					<p id="p02">
					    감독 : xxx<br>
						출연 : 아놀드 슈왈츠 제네거, 로버트 다우니 주니어, 박정현<br>
						장르 : 액션
					</p>
					줄거리
					<div id="movie_summary">
						붉게 물든 노을 바라보며 슬픈 그대 얼굴 생각이나 고개 숙이네 눈물 흘러 아무 말 할 수가 없지만 난 너를
						사랑하네 (후우우) 이 세상은 너뿐이야 소리쳐 부르지만 저 대답 없는 노을만 붉게 타는데 그 세월 속에 잊어야 할
						기억들이 다시 생각나면 눈 감아요 소리 없이 그 이름 불러요 아름다웠던 그대 모습 다시 볼 수 없는 것 알아요 후회
						없어 저 타는 노을 붉은 노을처럼 난 너를 사랑하네 (후우우) 이 세상은 너뿐이야 소리쳐 부르지만 저 대답 없는 노을만
						붉게 타는데 어데로 갔을까? 사랑하던 슬픈 그대 얼굴 보고 싶어 깊은 사랑 후회 없어 저 타는 붉은 노을처럼 난 너를
						사랑하네 (후우우) 이 세상은 너뿐이야 소리쳐 부르지만 저 대답 없는 노을만 붉게 타는데 그 세월 속에 잊어야 할
						기억들이 다시 생각나면 눈 감아요 소리 없이 그 이름 불러요 아름다웠던 그대 모습 다시 볼 수 없는 것 알아요 후회
						없어 저 타는 노을 붉은 노을처럼 난 너를 사랑하네 (후우우) 이 세상은 너 뿐이야 소리쳐 부르지만 저 대답 없는
						노을만 붉게 타는데 난 너를 사랑하네 (후우우) 이 세상은 너뿐이야 소리쳐 부르지만 저 대답 없는 노을만 붉게 타는데
					</div>
				</div>
			</div>
			<div id="movie_trailer">
				메인예고편
				<div>
					예고편
				</div>
			</div>
			<div id="movie_stillcut">
				스틸컷
				<div>
					<img src="${pageContext.request.contextPath}/resources/images/poster1.webp">
					<div class="stillcut">
						<img src="${pageContext.request.contextPath}/resources/images/stillcut1.jpg">
						<img src="${pageContext.request.contextPath}/resources/images/stillcut2.jpg"><br>
						<img src="${pageContext.request.contextPath}/resources/images/stillcut3.jpg">
						<img src="${pageContext.request.contextPath}/resources/images/stillcut4.jpg">
					</div>
				</div>
			</div>
			<div id="movie_review">
				<div id="review_title">관람평</div>
				<div>
					<table>
						<tr>
							<th>ID</th>
							<th>영화명</th>
							<th>한줄평</th>
							<th>추천/비추천</th>
							<th>작성일자</th>
						</tr>
						<c:forEach var="i" begin="1" end="10">
							<tr>
								<td>asdfqer</td>
								<td>소방관</td>
								<td>다시 보고 싶은 영화입니다.</td>
								<td>추천</td>
								<td>2024-12-16</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div id="page_button_group">
					<input type="button" value="<">
					<input type="button" value="1">
					<input type="button" value=">">
				</div>
			</div>
		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>