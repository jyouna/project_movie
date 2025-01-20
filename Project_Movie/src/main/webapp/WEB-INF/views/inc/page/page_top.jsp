<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="page-wrapper">    
	<section id="header" class="wrapper">
		<!-- Top Nav -->
		<div class="navbar"> 
			<div class="navbar-right"> 
				<a href="${pageContext.request.contextPath}">홈</a> 
				<a href="#" onclick="openAdminpage()">관리자(임시)</a>
				<c:choose>
					<c:when test="${empty sessionScope.sMemberId}">
						<a href="MemberLogin">로그인</a> 
		    			<a href="MemberAgree">회원가입</a> 
					</c:when>
					<c:otherwise>
						<a href="#" onclick="openMypage()">${sessionScope.sMemberId}</a>
		   				<a href="javascript:void(0)" onclick="logout()">로그아웃</a> 
					
					</c:otherwise>
				</c:choose> 
			</div>
		</div>
		
		<script>
		   function logout() {
		      // confirm() 함수 활용하여 "로그아웃하시겠습니까?" 질문을 통해
		      // 확인 버튼 클릭 시 "MemberLogout" 페이지로 이동 처리
		      if(confirm("로그아웃하시겠습니까?")) {
		         location.href = "MemberLogout";
		      }
		   }
		</script>

		<!-- Logo -->
			<div id="logo">
				<h1><a href="${pageContext.request.contextPath}">Escape Velocity</a></h1>
				<p>A free responsive site template by HTML5 UP</p>
			</div>

			<!-- Nav -->
			<nav id="nav">
				<ul>
					<li>
						<a href="TheaterInfo">영화관안내</a>
						<ul>
							<li><a href="TheaterInfo">영화관안내</a></li>
							<li><a href="SeatingInfo">좌석배치도</a></li>
							<li><a href="DirectionsInfo">오시는길</a></li>
						</ul>
					</li>
					<li>
						<a href="SeasonMovieInfo">영화안내</a>
						<ul>
							<li><a href="SeasonMovieInfo">Season Movie</a></li>
							<li><a href="CurrentlyMovieInfo">현재상영작</a></li>
							<li><a href="UpcomingMovieInfo">상영예정작</a></li>
							<li><a href="PastMovieInfo">지난상영작</a></li>
						</ul>
					</li>
					<li>
						<a href="BookTickets">예매하기</a>
						<ul>
							<li><a href="MovieScheduleInfo">상영시간표</a></li>
							<li><a href="BookTickets">예매하기</a></li>
							<li><a href="#">예매확인/취소</a></li>
						</ul>
					</li>
					<li>
						<a href="MoivePick">영화PICK</a>
						<ul>
							<li><a href="MoivePick"">영화투표하기</a></li>
							<li><a href="MoivePickStatus">PICK 현황</a></li>
							<li><a href="MoivePickResult">PICK 결과보기</a></li>
						</ul>
					</li>
					<li>
						<a href="EventList">이벤트</a>
						<ul>
							<li><a href="EventList">이벤트목록</a></li>
							<li><a href="EventWinner">당첨자발표</a></li>
						</ul>
					</li>
					<li>
						<a href="NoticeList">고객센터</a>
						<ul>
							<li><a href="NoticeList">공지사항</a></li>
							<li><a href="FaqList">자주하는문의</a></li>
						</ul>
					</li>
				</ul>
			</nav>
	</section>
	
	<section id="main" class="wrapper style2">
		<div class="container">
			<div class="row gtr-150">
				<div class="col-4 col-12-medium">
				
<script>
    function openMypage() {
        window.open("MypageMain", "myPage", "width=1300, height=800, top=150, left=300, resizable=no");
    }
    
    function openAdminpage() {
        window.open("AdminpageMain", "Adminpage", "width=1300, height=800, top=150, left=300, resizable=no");
    }
</script>
	