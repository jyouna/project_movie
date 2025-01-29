<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<link href="${pageContext.request.contextPath}/resources/css/mypage/mypageMainPage.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
	<section>
		<div id="time"></div>
		<section id="sec01" class="secMain">
			<h5>${sessionScope.sMemberId}님의 예매내역 </h5>
			<div id="noticeBoardMain" class="secitonBoard">
				<table>
					<tr class="tr01">
						<th width="130px">영화명</th>
						<th width="70px">관람인원</th>
						<th width="90px">관람일</th>
					</tr>
					<c:choose>
						<c:when test="${empty reservationList}">
							<tr>
								<td colspan="3">예매내역이 존재하지 않습니다</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="reservationDetail" items="${reservationList}" begin="0" end="5">
								<tr>
									<td>${reservationDetail.movie_name}</td>
									<td>${reservationDetail.ticket_count}</td>
									<td> <fmt:formatDate value="${reservationDetail.start_time}" pattern="yyyy-MM-dd HH:mm"/></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
		</section>
		<section id="sec02" class="secMain">
			<h5>${sessionScope.sMemberId}님의 1:1문의 내역 </h5>
			<div class="secitonBoard">
				<table>
					<tr class="tr01">
						<th width="40px">번호</th>
						<th width="50px">상태</th>
						<th width="130px">제목</th>
						<th width="110px">등록일</th>
					</tr>
					<c:choose>
						<c:when test="${empty inquiryList}">
							<tr>
								<td colspan="4">등록된 1:1문의 내역이 없습니다</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="inquiry" items="${inquiryList}" begin="0" end="5">
								<tr>
									<td>${inquiry.inquiry_code}</td>
									<td>
										<c:if test="${inquiry.response_status eq 0}">
											답변 전
										</c:if>
										<c:if test="${inquiry.response_status eq 1}">
											답변 완료
										</c:if>
										<c:if test="${inquiry.response_status eq 2}">
											답변
										</c:if>
									</td>
									<td>
										<c:if test="${inquiry.inquiry_re_lev > 0}">
											<c:forEach begin="1" end="${inquiry.inquiry_re_lev}">
												&nbsp;&nbsp; ↳ &nbsp;
											</c:forEach>
										</c:if>
										${inquiry.inquiry_subject}
									</td>
									<td><fmt:formatDate value="${inquiry.inquriy_date}" pattern="yyyy-MM-dd"/></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>			
		</section>
		<section id="sec03" class="secMain">
			<h5>${sessionScope.sMemberId}님의 포인트</h5>
				<div class="secitonBoard">
				<table>
					<tr class="tr01">
						<th width="80px">적립날짜</th>
						<th width="100px">적립 포인트</th>
						<th width="100px">인출 포인트</th>
					</tr>
					<c:choose>
						<c:when test="${empty pointList}">
							<tr>
								<td colspan="4">포인트 내역이 존재하지 않습니다</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="point" items="${pointList}" >
								<tr>
									<td>
									    <fmt:formatDate value="${point.regis_date}" pattern="yyyy-MM-dd"/>
									</td>
									<td>
										<c:choose>
											<c:when test="${point.point_credited > 0}">
											 +${point.point_credited}
											</c:when>                        
		                        		</c:choose>
	                        	</td>
	                        	 <td>
	                             	<c:choose>
										<c:when test="${point.point_debited != null}">
										  -${point.point_debited}
										</c:when>                        
		                        	</c:choose>
	                       		</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>				
		</section>
		
		<section id="sec04" class="secMain">
			<h5>${sessionScope.sMemberId}님의 쿠폰</h5>
				<div class="secitonBoard">
				<table>
					<tr class="tr01">
						<th width="60px">쿠폰 상태</th>
						<th width="130px">쿠폰 상세 정보</th>
						<th width="90px">사용기간</th>
					</tr>
					<c:choose>
						<c:when test="${empty couponList}" >
							<tr>
								<td colspan="4">쿠폰이 존재하지 않습니다</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="coupon" items="${couponList}" >
								<tr>
									<td>
										<c:choose>
						            		<c:when test="${coupon.coupon_status == 'true'}">
						            			사용완료
						            		</c:when>
						            		<c:otherwise>
						            			사용전
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
									<td> <fmt:formatDate value="${coupon.expired_date}" pattern="~ yy-MM-dd "/></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>		
		</section>
		<hr>
	</section>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>