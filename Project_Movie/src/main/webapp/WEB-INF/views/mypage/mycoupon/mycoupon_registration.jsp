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
<!-- 		이용할 수 있는 쿠폰 > 0건  -->
<!-- 할인쿠폰 등록 버튼 생성 -->
<!-- 쿠폰 번호 입력 후 등록하기 버튼 클릭 -> 쿠폰 등록 -->
<!-- 등록된 쿠폰 볼 수 있게 사용전 / 사용 완료 표시 -->
<!-- 쿠폰 상태 / 쿠폰명 / 쿠폰 정보 / 사용기간 만 표시  -->
  
      	
<div class="dateSearch_sec all_point">
  <div class="in_sec">
    <dl class="search_list">
      <dt class="tit">기간선택</dt>
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


      <section id="listForm">
         <table>
            <tr id="tr_top">
               <td width="100px">쿠폰 상태</td>
               <td width="100px">쿠폰명</td>
               <td width="200px">쿠폰 정보</td>
               <td width="200px">사용기간</td>
            </tr>
            <tr>
               <td>사용전</td>
               <td>신규회원 웰컴쿠폰</td>
               <td>예매 50% 할인 쿠폰</td>
               <td>~ 2025.01.31</td>
            </tr>
            <tr>
               <td>기간 만료</td>
               <td>연말깜짝 쿠폰</td>
               <td>예매 20% 할인 쿠폰</td>
               <td>~ 2024.12.31</td>
            </tr>
               
<%--             <c:choose> --%>
<%--                <c:when test="${empty boardList}">  --%>
<!--                   <tr><td colspan="5">게시물이 존재하지 않습니다</td></tr> -->
<%--                </c:when> --%>
<%--                <c:otherwise> --%>
<%--                   <c:forEach var="board" items="${boardList}" varStatus="status"> --%>
<!--                      <tr> -->
<%--                         <td class="board_num">${board.board_num}</td> --%>
<%--                         <td class="board_subject">${board.board_subject}</td> --%>
<%--                         <td>${board.board_name}</td> --%>
<!--                         <td> -->
<%--                            <fmt:formatDate value="${board.board_date}" pattern="yy-MM-dd - yy-MM-dd"/> --%>
<!--                         </td> -->
<%--                         <td>${board.board_readcount}</td> --%>
<!--                      </tr> -->
<%--                   </c:forEach> --%>
<%--                </c:otherwise>                --%>
<%--             </c:choose> --%>
         </table>
      </section>
      <hr>

    
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
			$("#couponRegister").on("click", function () {
				window.open(
						'couponRegister',
						'쿠폰 등록 창',
						'width=400, height=700, scrollbars=no, resizeable=no'
						);
			});
			
		});
		
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