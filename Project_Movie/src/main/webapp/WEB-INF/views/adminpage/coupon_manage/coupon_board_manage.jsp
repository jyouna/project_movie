<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>쿠폰 내역</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<h3>쿠폰 내역</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
		</div>	
		<div id="divTopRight"> <!--  우측 상단 검색란 -->
			<form action="CouponBoardManage" method="post">
				<input type="hidden" name="pageNum" value="${param.pageNum}">
				<select name="searchKeyword" id="selectKeyword">
					<option value="couponHolder" <c:if test="${param.searchKeyword eq 'couponHolder'}">selected</c:if>>아이디</option>
					<option value="couponStatus" <c:if test="${param.searchKeyword eq 'couponStatus'}">selected</c:if>>쿠폰상태</option>
				</select>
				<input type="text" placeholder="아이디를입력하세요" name="searchContent" value="${param.searchContent}" id="writeContent"> 
				<input type="submit" value="검색">
			</form>
		</div>	
	</div>
	<div id="tableDiv" class="view" style="overflow-x: auto;">
		<table id="mainTable">
			<tr align="center" id="tr01">
				<th>쿠폰번호</th>
				<th>쿠폰타입</th>
				<th>쿠폰상세</th>
				<th>등록일자</th>
				<th>만료일자</th>
				<th>쿠폰상태</th>
				<th>보유계정</th>
				<th>이벤트코드</th>
			</tr>
			<c:choose>
				<c:when test="${empty couponVo}">
					<tr>
						<th colspan="9">"작성된 게시글이 없습니다."</th>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="coupon" items="${couponVo}" varStatus="status">
						<tr>
							<td>${coupon.coupon_code}</td>	
							<td>
								<c:choose>
									<c:when test="${coupon.coupon_type eq false}">
										금액할인
									</c:when>
									<c:otherwise>
										할인율
									</c:otherwise>
								</c:choose>
							</td>	
							<td>
								<c:choose>
									<c:when test="${coupon.discount_amount eq '0'}">
										${coupon.discount_rate}% 할인권
									</c:when>
									<c:otherwise>
										${coupon.discount_amount}원 할인권
									</c:otherwise>
								</c:choose>
							</td>	
							<td><fmt:formatDate value="${coupon.regis_date}" pattern="yyyy-MM-dd"/> </td>	
							<td><fmt:formatDate value="${coupon.expired_date}" pattern="yyyy-MM-dd"/> </td>	
							<td>
								<c:choose>
									<c:when test="${coupon.coupon_status eq false}">
									<!--  기한 만료 혹은 사용 완료 -->
										사용가능
									</c:when>
									<c:otherwise>
										사용불가
									</c:otherwise>
								</c:choose>
							</td>	
							<td>${coupon.member_id}</td>	
							<td>${coupon.event_code}</td>	
						</tr>	
					</c:forEach>
				</c:otherwise>
			</c:choose> 			
		</table>
	</div>
	<c:set var="searchRecord" value="&searchKeyword=${param.searchKeyword}&searchContent=${param.searchContent}" />
	<div id="divBottom" class="view">
		<input type="button" value="처음" 
			onclick="location.href='CouponBoardManage?pageNum=1'" 
			<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>> 
<%-- 이전 페이지 이동	 --%>
		<input type="button" value="이전" 
			onclick="location.href='CouponBoardManage?pageNum=${pageInfo.pageNum - 1}${searchRecord}'" 
			<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
		<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			<c:choose>
				<c:when test="${i eq pageInfo.pageNum}">
<%-- 현재 페이지 표시	 --%>
					<strong>${i}</strong>
				</c:when>
<%-- 페이지 번호 클릭하여 이동	 --%>
				<c:otherwise>
					<a href="CouponBoardManage?pageNum=${i}${searchRecord}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
<%-- 다음 페이지 이동	 --%>
		<input type="button" value="다음" onclick="location.href='CouponBoardManage?pageNum=${pageInfo.pageNum + 1}${searchRecord}'"
		<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		<input type="button" value="마지막" onclick="location.href='CouponBoardManage?pageNum=${pageInfo.maxPage}'"
		<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
	</div>	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>

<script type="text/javascript">
$(function(){
	$("#selectKeyword").on("change", function(){
		let check = $("#selectKeyword").val();
		
		if(check === 'couponStatus'){
			$("#writeContent").attr("placeholder", "0 미사용 / 1 사용");
		} else {
			$("#writeContent").attr("placeholder", "아이디를입력하세요");
		}
	})
})
</script>
</body>
</html>