<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/event/event_post.css" />
		<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/event_sidebar.jsp"></jsp:include>
		<article id="articleForm">
		<h1>이벤트 - 글</h1>
		<section id="basicInfoArea">
			<table>
				<tr>
					<th>제목</th>
					<td colspan="3">${event.event_subject}</td>
				</tr>
				<tr>
					<th>등록일</th>
					<td>
						<fmt:formatDate value="${event.event_date}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>	
			</table>
			<table>
				<div id="content">
					해당 조사는 파파존스의 공식 주문 채널, 그리고 지정된 지점을 통해서만 주문을 해야 하는 조사입니다. (배달앱 사용 불가)
					파파존스 공식 주문 채널 ↓
					
					- 지점 번호를 통한 직접 전화 주문이 가능한 지점
					- 파파존스 콜센터 주문(대표번호: 1577-8080로 주문)
					- 파파존스 홈페이지 온라인 주문
					- 파파존스 앱(스마트폰) 주문
					
					1회 참여가 아닌 주기적으로 반복되는 조사이므로 1년간 이사 계획이 없는 분으로 신청 부탁드립니다.
					
					조사는 피자 주문 시 배달 예상 소요 시간, 실제 배달 소요 시간, 피자를 받은 후 사진 촬영 및 업로드 등 조사를 끝까지 참여해주셔야 하며
					업로드해주신 영수증 기준으로 피자(제품) 비용 + 2,000원(참여 리워드) 한 번에 패널적립금으로 지급될 예정입니다.
					
					모집 중인 지점에 해당하시는 분께만 순차적으로 유선상으로 안내드린 후,
					조사에 선정되시면 확정 안내 문자를 보내드리고 있습니다.
					확정되시면 조사에 참여해주시는겁니다.
					<br>
				</div>
				<tr>
					<th>첨부파일</th>
					<td colspan="3" id="board_file"></td>
				</tr>
			</table>
		</section>
		
		<section id="articleContentArea">
			${board.board_content}
		</section>
		<section id="commandCell">
				<c:if test="${sessionScope.sId eq board.board_name || sessionScope.sId eq 'admin' }">
					<input type="button" value="수정" id="Modify" >
					<input type="button" value="삭제" id="Delete">
				</c:if>
		</section>
		<table id="postList">
			<tr>
				<th>△이전글      </th>
				<th>이거는 이전 글 </th>
			</tr>
			<tr>
				<th>▽다음글     </th>
				<th>여기는 다음글</th>
			</tr>
		</table>

	</article>
		<script type="text/javascript">
		$(function() {
			$("#Modify").on("click", function () {
				confirm("수정하시겠습니까?")
			});
			
			$("#Delete").on("click", function () {
				confirm("삭제하시겠습니까?")
			});
		});
	
	
	</script>
	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>