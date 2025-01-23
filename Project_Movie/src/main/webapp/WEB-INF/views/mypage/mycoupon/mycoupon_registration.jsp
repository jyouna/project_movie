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
	<link href="${pageContext.request.contextPath}/resources/css/mypage/mycoupon/mycoupon_registration.css" rel="stylesheet" />
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
<article class="box post">
	<div id="title">
		<h1>쿠폰</h1>
	</div>
	<div class="dateSearch_sec all_point">
	  <div class="in_sec">
	    <dl class="search_list">
      		<dd class="select_btn">
	        	<ul class="period_tab" data-control="dateDiff" data-handler="[data-control='datepicker']" data-selected-text="선택됨">
		          <li class="on"><button type="button" data-val="7d" title="선택됨">1주일</button></li>
		          <li><button type="button" data-val="1m">1개월</button></li>
		          <li><button type="button" data-val="3m">3개월</button></li>
		          <li><button type="button" data-val="6m">6개월</button></li>
	        	</ul>
	      	</dd>
	      	<dd class="select_datepicker">
	        <div class="datepicker_wrap" style="display: flex; align-items: center; gap: 8px;">
	          <div class="inp_datepicker">
	          <input type="date" class="text hasDatepicker" title="시작 날짜 선택 yyyy.mm.dd" name="stdt" id="stdt" autocomplete="off">
	          </div>
	          <span class="hyphen">-</span>
	          <div class="inp_datepicker">
	            <input type="date" class="text hasDatepicker" title="종료 날짜 선택 yyyy.mm.dd" name="eddt" id="eddt" autocomplete="off">
	          </div>
	          <button type="button" class="btn btn_search" id="search_btn" onclick="searchDates();">조회</button>
			    <p class="bul_list"><span class="dot_arr">최근 2년 이내로 조회 가능</span></p>
	        </div>
	      </dd>
	    </dl>
	  </div>
	</div>

	<h6>${sessionScope.sMemberId } 님의 사용 가능한 쿠폰은 n장 입니다.</h6>
	<section id="listForm">
    	<table>
        	<tr id="tr_top">
               <td width="100px">쿠폰 상태</td>
               <td width="100px">쿠폰타입</td>
               <td width="200px">쿠폰 상세 정보</td>
               <td width="150px">사용기간</td>
            </tr>
            <tr>
	            <c:choose>
	               <c:when test="${empty couponList}"> 
            			<tr><td colspan="4">쿠폰이 존재하지 않습니다</td></tr>
	               </c:when>
	               <c:otherwise>
					    <c:forEach var="coupon" items="${couponList}" varStatus="status">
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
					            		<c:when test=" ${coupon.coupon_type == '0'}">금액</c:when>
					            		<c:otherwise>할인율</c:otherwise>
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
					            <td>
					                <fmt:formatDate value="${coupon.expired_date}" pattern="~ yy-MM-dd "/>
					            </td>
				       		 </tr>
				   		 </c:forEach>
					</c:otherwise>
            	</c:choose>
           	</tr>
         </table>
	</section>
	<section id="pageList">
		<input type="button" value="&lt" onclick="location.href='CouponList?pageNum=${pageInfo.pageNum - 1}'" 
		<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
		<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			<c:choose>
				<c:when test="${i eq pageInfo.pageNum }">
					<strong>${i}</strong>
				</c:when>
				<c:otherwise>
					<a href="CouponList?pageNum=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<input type="button" value="&gt" onclick="location.href='CouponList?pageNum=${pageInfo.pageNum + 1}'" 
		<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
	</section>
	</article>
	<script type="text/javascript">
		// jQuery UI Datepicker 적용
		$(function () {
		  $("#stdt, #eddt").datepicker({
		    dateFormat: "yy.mm.dd", // 날짜 형식
		    changeMonth: true,
		    changeYear: true,
		    yearRange: "-2:+0", // 최근 2년 범위
		    maxDate: 0 // 오늘까지 선택 가능
		  });
		});

		// 조회 버튼 클릭 이벤트
		function searchDates() {
		  const startDate = $("#stdt").val();
		  const endDate = $("#eddt").val();
		  
		  if (!startDate || !endDate) {
		    alert("시작 날짜와 종료 날짜를 선택해주세요.");
		    return;
		  }

		  if (new Date(startDate) > new Date(endDate)) {
		    alert("종료 날짜는 시작 날짜 이후여야 합니다.");
		    return;
		  }

		  alert(`선택된 기간: ${startDate} ~ ${endDate}`);
		}

	</script>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>