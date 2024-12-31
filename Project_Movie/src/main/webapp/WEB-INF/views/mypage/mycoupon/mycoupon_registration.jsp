<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mycoupon/mycoupon_registration.css" />
</head>
<body>
<article class="box post">
		<h1>쿠폰</h1>
<!-- 		이거 오른쪽 정렬 -->
		<button>쿠폰등록하기</button>
<!-- 		이용할 수 있는 쿠폰 > 0건  -->
      <section id="listForm">
         <table>
            <tr id="tr_top">
               <td width="100px">쿠폰 이름</td>
               <td>쿠폰 정보</td>
               <td width="200px">사용기간</td>
            </tr>
               
            <c:choose>
               <c:when test="${empty boardList}"> 
                  <tr><td colspan="5">게시물이 존재하지 않습니다</td></tr>
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
      <hr>
      <div class="search-bar">
      <button>조회기간</button>
      <button>1개월</button>
      <button>3개월</button>
      <button>6개월</button>
        <select>
          <option>기간설정</option> 
          <option>기간설정</option>
        </select>
        <input type="text" placeholder="검색">
        <button>조회하기</button>
      </div>
      <section id="listForm">
         <table>
            <tr id="tr_top">
               <td width="100px">쿠폰 번호</td>
               <td>쿠폰 이름</td>
               <td width="150px">사용일(만료일)</td>
            </tr>
               
            <c:choose>
               <c:when test="${empty boardList}"> 
                  <tr><td colspan="5">게시물이 존재하지 않습니다</td></tr>
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

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>