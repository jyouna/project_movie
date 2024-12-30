<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 외부 CSS 파일(resources/css/default.css) 로드 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header>
		<!-- 기본 메뉴 표시 영역 - inc/top.jsp 페이지 삽입 -->
		<!-- 상대 경로를 사용하여 top.jsp 페이지 지정 -->
		<!-- 1) 현재 main.jsp 페이지 경로(views) 기준 inc/top.jsp 지정 -->
<%-- 		<jsp:include page="inc/top.jsp"></jsp:include> --%>
		<!-- 2) 최상위 루트(/) 기준으로 inc/top.jsp 지정 -->
		<!--    스프링에서 뷰페이지 기준 루트는 webapp 디렉토리이므로 나머지 경로 기술 필요 -->
<%-- 		<jsp:include page="/WEB-INF/views/inc/top.jsp" /> --%>
	</header>
	<article>
		<!-- 본문 표시 영역 -->
		<h3>
			작업을 처리하는 도중 에러 발생!<br>
			자세한 사항은 고객센터에 문의하시기 바랍니다.
		</h3>
	</article>
	<footer>
		<!-- 하단 기업 정보 표시 영역 - inc/bottom.jsp 페이지 삽입 -->
<%-- 		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" /> --%>
	</footer>
</body>
</html>









