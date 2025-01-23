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
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypoint/mypoint_reward.css" />
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
	<article class="box post">
		<div id="title">
			<h1>포인트</h1>
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
		<h6>${sessionScope.sMemberId } 님의 사용 가능한 포인트는 xxx 원 입니다.</h6>
        <p>* 포인트는 소멸되지 않습니다.</p>
	      <section id="listForm">
	         <table>
	            <tr id="tr_top">
	               <td width="100px">구분</td>
	               <td width="100px">적립날짜</td>
	               <td width="180px">상세내용</td>
	               <td width="100px">적립포인트</td>
	               <td width="100px">인출포인트</td>
	            </tr>
	               
	            <c:choose>
	               <c:when test="${empty pointList}"> 
	                  <tr><td colspan="5">포인트 내역이 존재하지 않습니다</td></tr>
	               </c:when>
	               <c:otherwise>
	                  <c:forEach var="point" items="${pointList}" varStatus="status">
	                     <tr>
	                        <td>${point.point_code}</td>
	                        <td>
	                           <fmt:formatDate value="${point.regis_date}" pattern="yy-MM-dd"/>
	                        </td>
	                        <td>${point.event_subject}</td>
	                        <td>+${point.point_credited}</td>
	                        <td>-${point.point_debited}</td>
	                     </tr>
	                  </c:forEach>
	               </c:otherwise>               
	            </c:choose>
	         </table>
	      </section>
          <section id="pageList">
	         <input type="button" value="&lt" 
	            onclick="location.href='MypointReward?pageNum=${pageInfo.pageNum - 1}'" 
	             <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
	         
	         <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
	            <c:choose>
	               <c:when test="${i eq pageInfo.pageNum }">
	                  <strong>${i}</strong>
	               </c:when>
	               <c:otherwise>
	                  <a href="MypointReward?pageNum=${i}">${i}</a>
	               </c:otherwise>
	            </c:choose>
	         </c:forEach>
	         
	         
	         <input type="button" value="&gt" 
	            onclick="location.href='MypointReward?pageNum=${pageInfo.pageNum + 1}'" 
	             <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
	      </section>
		</article>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>