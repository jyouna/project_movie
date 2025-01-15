<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
	<title>관리자메인</title>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/adminpage_scripts.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/adminpage_login.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

<style type="text/css">
#leftTop {
/* 	height: auto; /* 자동으로 높이를 조정 */ */
	overflow: hidden; /* 포함된 페이지가 넘칠 경우 숨김 */
	border: 1px solid #ccc; /* 테두리(optional) */
/* 	position: relative; */
}
#leftTop_2{
   transform: scale(0.4); /* 크기를 80%로 조정 */
   transform-origin: top left; /* 스케일 조정 기준 설정 */
}
</style>
</head>
<body>
	<footer class="py-4 bg-light mt-auto">
		<div class="container-fluid px-4">
	    	<div class="d-flex align-items-center justify-content-between small">
	        	<div class="text-muted">Copyright &copy; Your Website 2023</div>
		           	<div>
		           		<a href="#">Privacy Policy</a>&middot;
		           		<a href="#">Terms &amp; Conditions</a>
		           	</div>
				<c:choose>
					<c:when test="${not empty admin_sId}"> <!--  관리자 페이지 로그인 중인 경우 로그아웃 버튼 표시, 로그아웃 시 나가기 버튼으로 표시 -->
						<button id="exit" class="adminLogout" onclick="adminLogout()">로그아웃</button>
					</c:when>
					<c:otherwise>
						<button id="exit" onclick="window.close()">나가기</button>
					</c:otherwise>
				</c:choose>		                    
			</div>
	    </div>
	</footer>
</body>    
</html> 
    
    
    
	
		
