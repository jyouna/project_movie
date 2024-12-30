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
		<h3>죄송합니다.<br>
		요청하신 페이지를 찾을 수 없습니다.<br>
		방문하시려는 페이지의 주소가 잘못 입력되었거나,<br>
		페이지의 주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.<br>
		<br>
		입력하신 주소가 정확한지 다시 한번 확인해 주시기 바랍니다.<br>
		<br>
		관련 문의사항은 고객센터에 알려주시면 친절하게 안내해 드리겠습니다.<br>
		<br>
		감사합니다.</h3>
	</article>
	<footer>
		<!-- 하단 기업 정보 표시 영역 - inc/bottom.jsp 페이지 삽입 -->
<%-- 		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" /> --%>
	</footer>
</body>
</html>









