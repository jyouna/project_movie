<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<!--
	Escape Velocity by HTML5 UP
	html5up.net | @ajlkn
	
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/book_tickets/book_pay.css">
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/book_tickets/book_pay.js"></script>
	<!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- 포트원 결제 -->
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/book_tickets_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<!-- 	모달창 -->
		<div class="modal">
			<div class="modal_content">
				<div class="modal_close">x</div>
				<div class="top">
					<h2>결제하기</h2>
				</div>
				<form action="BookFinish" id="paymentForm" method="post">
					<input type="hidden" name="schedule_code" value="${schedule.schedule_code}">
					<input type="hidden" name="payment_code" value="${payment_code}">
					<input type="hidden" name="payment_method" id="paymentMethod">
					<input type="hidden" name="payment_status" id="paymentStatus">
					<input type="hidden" name="total_payment" id="totalPayment">
					<div class="main_container">
						<div class="left_section">
							<h4>예매정보</h4>
			
							<section class="book_info_container">
								<div class="poster">
									<div class="mv_poster"><img src="${schedule.movie_img1}"></div>
								</div>
								<div class="mv_info">
									<div class="mv_title">${schedule.movie_name}</div>
							        <div class="row">
							            <div class="header">일시</div>
							            <div class="data">
							            	<fmt:parseDate var="parsedReplyDate"
															value="${schedule.start_time}"
															pattern="yyyy-MM-dd HH:mm"
															type="both" />
											<fmt:formatDate value="${parsedReplyDate}" pattern="yyyy.MM.dd'('E')' HH:mm"/>
						            	</div>
							        </div>
							        <div class="row">
							            <div class="header">상영관</div>
							            <div class="data">
							            	<c:choose>
												<c:when test="${schedule.theater_code eq 'T1'}">
													1관
												</c:when>
												<c:when test="${schedule.theater_code eq 'T2'}">
													2관
												</c:when>
												<c:otherwise>
													3관
												</c:otherwise>
											</c:choose>
							            </div>
							        </div>
							        <div class="row">
							            <div class="header">인원</div>
							            <div class="data">
							            	<c:if test="${param.adult != 0}">
							            		일반 ${param.adult}명&nbsp;
							            	</c:if>
							            	<c:if test="${param.youth != 0}">
							            		청소년 ${param.youth}명&nbsp; 
							            	</c:if>
							            	<c:if test="${param.senior != 0}">
							            		경로/우대 ${param.senior}명
							            	</c:if>
							            </div>
							            <input type="hidden" name="adult" id="adult" value="${param.adult}">
										<input type="hidden" name="youth" id="youth" value="${param.youth}">
										<input type="hidden" name="senior" id="senior" value="${param.senior}">
							        </div>
									 <div class="row">
							            <div class="header">좌석</div>
							            <div class="data">${totalSeat}</div>
							        </div>
							        <input type="hidden" name="totalSeat" value="${totalSeat}">
						        </div>
							</section>
							
							<section class="discount_container">
								<div><h4>할인/포인트</h4><h6>(중복 적용 불가능)</h6></div>
								<div class="discount_tab">
									<button type="button" class="coupon_btn"> 쿠폰</button>
									<button type="button" class="point_btn">포인트</button>
								</div>
								<div class="coupon_container">
									<p>사용할 쿠폰을 선택해주세요 (예매취소시 포인트로 지급됩니다)</p>
									<div class="coupon_table">
										<table border="1">
											<tr>
												<th>쿠폰명</th>
												<th>유효기간</th>
												<th>사용</th>
											</tr>
											<c:forEach var="coupon" items="${myCouponList}">
												<c:if test="${coupon.coupon_status == false}">
													<tr>
									                    <td>${coupon.coupon_name}</td>
									                    <td>${coupon.expired_date}</td>
									                    <td><input class="checkCouponRadio" name="coupon_discount" value="${coupon.coupon_code}" type="radio"></td>
									                </tr>
												</c:if>
											</c:forEach>
										</table>
									</div>
								</div>
								<div class="point_container">
									<p>사용할 포인트를 입력해주세요 (최대 5000p 까지)</p>
									<div class="my_point">
										<div class="point01">보유 포인트</div>
										<div class="point02">${myPoint} p</div>
									</div>
									<div class="use_point">
										<span>사용할 포인트</span>
										<div class="form_btn">
											<input type="text" class="point_form" name="point_discount" value="${param.point_discount}" maxlength="4">
										</div>
									</div>
								</div>
							</section>
							
							<section class="pay_container">
								<h4>최종 결제수단</h4>
								<div class="pay_type">
									<label><input type="radio" class="pay" >신용카드</label>
									<label><input type="radio" class="pay" >카카오페이</label>
									<label><input type="radio" class="pay" >토스페이</label>
<!-- 									<label><input type="radio" class="pay" name="payment_method" value="신용카드">신용카드</label> -->
<!-- 									<label><input type="radio" class="pay" name="payment_method" value="카카오페이">카카오페이</label> -->
<!-- 									<label><input type="radio" class="pay" name="payment_method" value="토스페이">토스페이</label> -->
								</div>
							</section>
							
							<div class="right_section">
								<p>결제금액</p>
								<section class="payment_final">
									<div class="div01">
										<div class="tit">금액</div>
										<div class="row">
											<div class="price">${param.totalAmount}</div>
											<div class="won">원</div>
										</div>
									</div>
									<div class="minus">-</div>
									<div class="div02">
										<div class="tit">할인적용</div>
										<div class="row">
											<div class="price">0</div>
											<div class="won">원</div>
										</div>
										<input type="hidden" name="total_discount" value="0">
									</div>
									<div class="div03">
										<div class="tit">총결제금액</div>
										<div class="row">
											<div class="price">${param.totalAmount}</div>
											<div class="won">원</div>
										</div>
									</div>
									<div class="payment">
										<button type="button" class="back_btn" onclick="history.back()">이전</button>
										<button type="button" class="payment_btn">결제</button>
									</div>
								</section>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		
		<script>
			 $(".modal_close").click(function() {
				$(".modal").css("display", "none");
				$(".modal_content").css("display", "none");
			});
			 
			 // 쿠폰 버튼 클릭 이벤트
			 $(".coupon_btn").click(function() {
				$(".coupon_container").css("display", "block");
				
				if($(".point_container").css("display", "block")) {
					$(".point_container").css("display", "none");
				}
				
				// 쿠폰 버튼 클릭 시 포인트 값 있으면 할인적용 초기화
				if($(".point_form").val() != "") {
					$(".point_form").val("");
					$(".div02 .price").text("0");
					$(".div03 .price").text($(".div01 .price").text());
					$("input[name='total_discount']").val($(".div02 .price").text());
				}
			});

			 // 포인트 버튼 클릭 이벤트
			 $(".point_btn").click(function() {
				$(".point_container").css("display", "block");
				
				if($(".coupon_container").css("display", "block")) {
					$(".coupon_container").css("display", "none");
				}

				// 포인트 버튼 클릭 시 쿠폰 선택되어 있으면 할인적용 초기화
				$(".checkCouponRadio").each(function() {
				    if ($(this).prop("checked")) {
				        $(this).prop("checked", false);
				        $(".div02 .price").text("0");
				        $(".div03 .price").text($(".div01 .price").text());
				        $("input[name='total_discount']").val($(".div02 .price").text());
				    }
				});
			});
			
			// 결제 api
			// 신용카드
			function KGmobilians() {
				IMP.init("imp33121188");

				IMP.request_pay(
					{
						channelKey: "channel-key-66affb7d-259e-4fcd-bd05-8338b7749870",
					    pay_method: "card",
					    merchant_uid: "${payment_code}", // 상점에서 생성한 고유 주문번호
					    name: "KGinicis_test", // 필수 파라미터 입니다.
					    amount: $(".div03 .price").text(),
					    buyer_email: "${sessionScope.sEmail}",
					    buyer_name: "${sessionScope.sName}",
					    buyer_tel: "${sessionScope.sPhone}",
					    buyer_addr: "서울특별시 강남구 삼성동",
					    buyer_postcode: "123-456",
					    m_redirect_url: "BookFinish",
				   },
				   function (rsp) {
					   handlePaymentResponse(rsp, '신용카드');
				   }
				);
			}
			
			// 카카오페이
			 function kakaopay() {
				 IMP.init("imp33121188");
				 
				 IMP.request_pay(
				 	{
						 channelKey: "channel-key-d2e52257-fb29-4bfe-9a57-d02a9cc8977d",
						 pay_method: "card", // 생략가
						 merchant_uid: "${payment_code}", // 상점에서 생성한 고유 주문번호
						 name: "kakaopay_test",
						 amount: $(".div03 .price").text(),
						 buyer_email: "${sessionScope.sEmail}",
						 buyer_name: "${sessionScope.sName}",
						 buyer_tel: "${sessionScope.sPhone}",
						 buyer_addr: "서울특별시 강남구 삼성동",
						 buyer_postcode: "123-456",
						 m_redirect_url: "BookFinish",
					},
					function (rsp) {
						handlePaymentResponse(rsp, '카카오페이');
					}
				);
			}
			
			// 토스페이
			function tosspay() {
				IMP.init("imp33121188");
				 
				IMP.request_pay(
					{
						channelKey: "channel-key-51cedd5b-cad6-4f50-991d-e77a047bc21e",
					    pay_method: "card",
					    merchant_uid: "${payment_code}", // 상점에서 생성한 고유 주문번호
					    name: "tosspay_test", // 필수 파라미터 입니다.
					    amount: $(".div03 .price").text(),
					    buyer_email: "${sessionScope.sEmail}",
					    buyer_name: "${sessionScope.sName}",
					    buyer_tel: "${sessionScope.sPhone}",
					    buyer_addr: "서울특별시 강남구 삼성동",
					    buyer_postcode: "123-456",
					    m_redirect_url: "BookFinish",
					},
				    function (rsp) {
						handlePaymentResponse(rsp, '토스페이');
					}
				);
			}
			
			function handlePaymentResponse(rsp, payment_method) {
				if(rsp.success) {
					alert("결제가 완료되었습니다");
					
					$("#paymentStatus").val("1");
					$("#totalPayment").val(rsp.paid_amount);
					$("#paymentMethod").val(payment_method);
					
					$("#paymentForm").submit();
				} else {
					alert("결제가 취소되었습니다");
					location.reload();
				}
			}

		</script>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>