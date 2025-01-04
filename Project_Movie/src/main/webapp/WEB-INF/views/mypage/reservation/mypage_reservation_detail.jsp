<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html lang="en">
<html>
<head>	
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>마이페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/mypage/reservation/mypage_reservation_detail.css" rel="stylesheet" />
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

</head>
<body class="sb-nav-fixed">
<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
 <article class="box post">
 	<div id="title">
		<h1>예매내역</h1>
 	</div>
		<!-- 로그인 한 회원 이름 +n건입니다. - 예매한 갯수로 연결 -->
		<h6>정유나님 관람가능한 예매내역이 1건 입니다.</h6>
      <section id="listForm">
         <table>
            <tr id="tr_top">
	           	<td width="8%">순서</td>
				<td width="15%">예매번호</td>
				<td width="20%">영화명</td>
				<td width="11%">관람인원</td>
				<td width="11%">관람좌석</td>
				<td width="10%">상영관</td>
				<td width="15%">예매일</td>
				<td width="10%">금액</td>

            </tr>
               
            <c:choose>
               <c:when test="${empty boardList}"> 
                  <tr><td colspan="8">게시물이 존재하지 않습니다</td></tr>
               </c:when>
               <c:otherwise>
                  <c:forEach var="board" items="${boardList}" varStatus="status">
                     <tr>
                        <td class="board_num">${board.board_num}</td>
                        <td class="board_subject">${board.board_subject}</td>
                        <td>${board.board_name}</td>
                        <td>
                           <fmt:formatDate value="${board.board_date}" pattern="yy-MM-dd - yy-MM-dd"/>
                        </td>
                        <td>${board.board_readcount}</td>
                     </tr>
                  </c:forEach>
               </c:otherwise>               
            </c:choose>
         </table>
      </section>
<!--       오른쪽 정렬 -->
	<div id="underButton" style="text-align: right;">
<!-- 	상세정보 클릭 시 상세정보 창 띄우기  -->
      <input type="button" value="상세정보" id="detail">
<!--       예매취소 클릭 시 취소하시겠습니까? 알림창 -->
      <input type="button" value="예매취소" id="cancel">
<!-- 확인 시 예매가 취소되었습니다. -->
	</div>
            <section id="pageList">
         <input type="button" value="&lt" 
            onclick="location.href='BoardList?pageNum=${pageInfo.pageNum - 1}'" 
             <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
         
         <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
            <c:choose>
               <c:when test="${i eq pageInfo.pageNum }">
                  <strong>${i}</strong>
               
               </c:when>
               <c:otherwise>
                  <a href="BoardList?pageNum=${i}">${i}</a>
               </c:otherwise>
            </c:choose>
         </c:forEach>
         
         
         <input type="button" value="&gt" 
            onclick="location.href='BoardList?pageNum=${pageInfo.pageNum + 1}'" 
             <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
      </section>
	</article>
	<script type="text/javascript">
		$(function () {
			$("#detail").on("click", function() {
				window.open(    
					'detail',
					'예매내역 상세 정보',
					'width=400, height=700, scrollbars=no, resizeable=no');
			});
			
			$("#cancel").on("click", function() {
				confirm("예매 취소하시겠습니까?")
			});
			
			
		});
		
	
	
	
	
	</script>	

	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
</body>
</html>