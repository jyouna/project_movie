<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/adminpage/movie_set/admin_movie_list.css" rel="stylesheet" /> --%>
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/reservation_info_board.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/movie_set/admin_movie_list.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<section id="movieListBody">
		<div id="sec01">
			<div id="title">회원 예매내역</div>
			<div id="search01">
				<input type="button" value="전체 목록 조회" onclick="location.href='AdminPaymentList'">
			</div>
			<div id="search02">
				<form action="AdminPaymentList">
					<select class="search_box" name="howSearch">
						<option value="member_id" <c:if test ="${param.howSearch eq 'member_id'}">selected</c:if>>아이디</option>
						<option value="payment_code" <c:if test ="${param.howSearch eq 'payment_code'}">selected</c:if>>예매번호</option>
					</select>
					<c:choose>
						<c:when test="${not empty param.searchKeyword}">
							<input type="text" name="searchKeyword" value="${param.searchKeyword}"required>
						</c:when>
						<c:otherwise>
							<input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" required>
						</c:otherwise>
					</c:choose>
					<input type="submit" value="검색">
				</form>
			</div>
		</div>
		
		<div id="sec02">
			<table>
				<tr>
					<th style="width:2%"><input type="radio" name="payment_radio" disabled></th>
	                <th style="width:8%">예매번호</th>
	                <th style="width: 7%">예매자</th>
	                <th style="width:13%">영화명</th>
	                <th style="width:8%">상영일시</th>
	                <th style="width:6%">관람좌석</th>
	                <th style="width:6%">할인</th>
	                <th style="width:6%">결제금액</th>
	                <th style="width:6%">결제수단</th>
	                <th style="width:8%">결제일자</th>
				</tr>
				<c:choose>
					<c:when test="${empty paymentList}">
						<tr>
							<td colspan="10">
								조회된 예매내역이 없습니다
							</td>
						<tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="payment" items="${paymentList}">
							<tr>
				                <td><input type="radio" name="payment_radio"></td>
				                <td>${payment.payment_code}</td>
				                <td>${payment.member_name}<br>(${payment.member_id})</td>
				                <td>${payment.movie_name}</td>
				                <td><fmt:formatDate value="${payment.start_time}" pattern="yyyy-MM-dd HH:mm"/></td>
				                <td>${payment.total_seat_code}</td>
				                <td>${payment.total_discount} 원</td>
				                <td>${payment.total_payment} 원</td>
				                <td>${payment.payment_method}</td>
				                <td><fmt:formatDate value="${payment.payment_date}" pattern="yyyy-MM-dd HH:mm"/></td>
				            </tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
	       	<div class="page_btn_group">
	       		<div class="page_btn">
					<c:if test="${not empty param.searchKeyword}">
						<c:set var="searchParam" value="&howSearch=${param.howSearch}&searchKeyword=${param.searchKeyword}"/>			
					</c:if>
					<c:if test="${pageInfo.maxPage != 0}">
			            <input type="button" value="<" <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>
			            	onclick="location.href='AdminPaymentList?pageNum=${pageInfo.pageNum - 1}${searchParam}'">
			            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			            	<c:choose>
			            		<c:when test="${pageInfo.pageNum eq i}">
			            			<b>${i}</b>
			            		</c:when>
			            		<c:otherwise>
			            			<a href="AdminPaymentList?pageNum=${i}${searchParam}">${i}</a>
			            		</c:otherwise>
			            	</c:choose>
			            </c:forEach>
			            <input type="button" value=">" <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>
			            onclick="location.href='AdminPaymentList?pageNum=${pageInfo.pageNum + 1}${searchParam}'">
					</c:if>
	       		</div>
				<div class="cancel_btn">
					<input type="button" value="예매취소" id="cancel">
				</div>
	        </div>
		</div>
	
    </section>
    
    <script>
    	$(".search_box").click(function() {
	    	if($("input[name='searchKeyword']").val() != "") {
	    		$("input[name='searchKeyword']").val("");
	    	}
		});
    </script>
    
    <jsp:include page="/WEB-INF/views/inc/adminpage_mypage/movie_set/movie_regist_modal.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>