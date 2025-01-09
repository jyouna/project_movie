<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
	    <a class="navbar-brand ps-3" href="adminPage.jsp">관리자페이지</a>
	    <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
</nav>
<div id="layoutSidenav">
    <div id="layoutSidenav_nav">				
		<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        	<div class="sb-sidenav-menu">
            	<div class="nav">
<!--                     계정관리 탭 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseAccounts" aria-expanded="false" aria-controls="collapseAccounts">
					    계정관리
					    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapseAccounts" aria-labelledby="headingAccounts" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionAccounts">
					        <a class="nav-link" href="AdminAccountManage">
					            관리자계정관리
					        </a>
					    </nav>
					</div>
<!-- 					회원목록 탭 -->
					<a class="nav-link collapsed" href="MemberList" data-bs-toggle="collapse" data-bs-target="#collapseMembers" aria-expanded="false" aria-controls="collapseMembers">
					    회원목록
					    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapseMembers" aria-labelledby="headingMembers" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionMembers">
					        <a class="nav-link" href="MemberList">
					            회원목록
					        </a>
<!-- 					        <a class="nav-link" href="AdminAccountManage"> -->
<!-- 					            관리자 권한 관리 -->
<!-- 					        </a> -->
					    </nav>
					</div>
						
<!-- 					결제관리 탭 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePayments" aria-expanded="false" aria-controls="collapsePayments">
					    결제관리
					    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapsePayments" aria-labelledby="headingPayments" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPayments">
					        <a class="nav-link" href="">
					            예매/결제내역
					        </a>
					        <a class="nav-link" href="">
					            취소내역/처리
					        </a>
					    </nav>
					</div>
						
<!-- 					영화관리 탭 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseMovies" aria-expanded="false" aria-controls="collapseMovies">
					    영화관리
					    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapseMovies" aria-labelledby="headingMovies" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionMovies">
					        <a class="nav-link" href="AdminMovieSetList">
					            영화목록
					        </a>
					        <a class="nav-link" href="AdminMovieSetSchedule">
					            상영스케줄관리
					        </a>
					        <a class="nav-link" href="AdminMovieSetUpcoming">
					            상영예정작
					        </a>
					        <a class="nav-link" href="AdminMovieSetCurrently">
					            현재상영작
					        </a>
					        <a class="nav-link" href="AdminMovieSetPast">
					            지난상영작
					        </a>
					    </nav>
					</div>
						
<!-- 					투표관리 탭 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseVotes" aria-expanded="false" aria-controls="collapseVotes">
					    투표관리
					    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapseVotes" aria-labelledby="headingVotes" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionVotes">
					        <a class="nav-link" href="AdminMoviePickSet">
					            투표설정
					        </a>
					    </nav>
					</div>
						
<!-- 					영화관관리 탭 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseCinemas" aria-expanded="false" aria-controls="collapseCinemas">
					    영화관관리
					    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapseCinemas" aria-labelledby="headingCinemas" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionCinemas">
					        <a class="nav-link" href="">
					            좌석관리
					        </a>
					    </nav>
					</div>
						
<!-- 					고객지원관리 탭 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseSupport" aria-expanded="false" aria-controls="collapseSupport">
					    고객지원관리
					    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapseSupport" aria-labelledby="headingSupport" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionSupport">
					        <a class="nav-link" href="notice_board_manage">
					            공지사항관리
					        </a>
					        <a class="nav-link" href="faq_board_manage">
					            FAQ관리
					        </a>
					        <a class="nav-link" href="inquiry_board_manage">
					            1:1문의관리
					        </a>
					    </nav>
					</div>
						
<!-- 					이벤트관리 탭 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseEvents" aria-expanded="false" aria-controls="collapseEvents">
					    이벤트관리
					    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapseEvents" aria-labelledby="headingEvents" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionEvents">
					        <a class="nav-link" href="EventBoardManage">
					            이벤트관리
					        </a>
					        <a class="nav-link" href="CouponWinnerManage">
					            이벤트쿠폰당첨자
					        </a>
					        <a class="nav-link" href="PointWinnerManage">
					            이벤트포인트당첨자
					        </a>
					        <a class="nav-link" href="CouponBoardManage">
					            쿠폰내역
					        </a>
					        <a class="nav-link" href="PointBoardManage">
					            포인트내역
					        </a>
					    </nav>
					</div>
						
<!-- 					영화후기관리 탭 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseReviews" aria-expanded="false" aria-controls="collapseReviews">
					    영화후기관리
					    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapseReviews" aria-labelledby="headingReviews" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionReviews">
					        <a class="nav-link" href="">
					            조회 및 삭제
					        </a>
					    </nav>
					</div>
						
<!-- 					기간별통계 탭 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseStatistics" aria-expanded="false" aria-controls="collapseStatistics">
					    기간별통계
					    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapseStatistics" aria-labelledby="headingStatistics" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionStatistics">
					        <a class="nav-link" href="StaticsVisitors">
					            방문자통계
					        </a>
					        <a class="nav-link" href="StaticsSales">
					            매출통계
					        </a>
					        <a class="nav-link" href="StaticsVoteResult">
					            선호영화통계
					        </a>
					        <a class="nav-link" href="StaticsNewMember">
					            가입자통계
					        </a>
					    </nav>
					</div>

            	</div>
        	</div>
	       	<div class="sb-sidenav-footer">
	            <div class="small">Logged in as:</div>
	            Start Bootstrap
	        </div>
		</nav>
	</div>
    <div id="layoutSidenav_content">