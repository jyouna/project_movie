<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminMainPage.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>	
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/adminMain.js" ></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<article id="testArticle">
		<div id="time"></div>
		<section id="sec01" class="secMain">
			<h5>공지사항
				<span>
					<a href="AdminNotice" class="link">더보기</a>
				</span>
			</h5>
			<div id="noticeBoardMain" class="secitonBoard">
				<table>
					<tr class="tr01">
						<th width="40px">번호</th>
						<th width="150px">제목</th>
						<th width="70px">작성자</th>
						<th width="70px">등록일</th>
					</tr>
					<c:choose>
						<c:when test="${empty noticeVo}">
							<tr>
								<td colspan="4">등록된 공지사항이 없습니다</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="notice" items="${noticeVo}" begin="0" end="9">
								<tr>
									<td>${notice.notice_code}</td>
									<td class="subjectTextAlign">${notice.notice_subject}</td>
									<td>${notice.notice_writer}</td>
									<td><fmt:formatDate value="${notice.regis_date}" pattern="yyyy-MM-dd" /></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
		</section>
		<section id="sec02" class="secMain">
			<h5>미답변 문의 내역
				<span>
					<a href="AdminInquiry" class="link">답변하기</a>
				</span>
			</h5>
			<div class="secitonBoard">
				<table>
					<tr class="tr01">
						<th width="40px">번호</th>
						<th width="150px">제목</th>
						<th width="70px">작성자</th>
						<th width="70px">등록일</th>
<!-- 						<th width="50px">답변여부</th> -->
					</tr>
					<c:choose>
						<c:when test="${empty inquiryVo}">
							<tr>
								<td colspan="4">등록된 공지사항이 없습니다</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="inquiry" items="${inquiryVo}" begin="0" end="9">
								<tr>
									<td>${inquiry.inquiry_code}</td>
									<td class="subjectTextAlign">${inquiry.inquiry_subject}</td>
									<td>${inquiry.inquiry_writer}</td>
									<td><fmt:formatDate value="${inquiry.inquriy_date}" pattern="yyyy-MM-dd" /></td>
<!-- 									<td>미답변</td> -->
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>			
		</section>
		<section id="sec03" class="secMain">
			<h5>매출 통계
				<span>
					<a href="StaticsSales" class="link">더보기</a>
				</span>
			</h5>
			<div id="chartArea2" class="secitonBoard">
				<span id="showPeriod2"></span>
				<canvas class="myChart2"></canvas>
			</div>				
		</section>
		
		<section id="sec04" class="secMain">
			<h5>가입자 통계
				<span>
					<a href="StaticsNewMember" class="link">더보기</a>
				</span>
			</h5>
			<div id="chartArea" class="secitonBoard">
				<span id="showPeriod"></span>
				<canvas class="myChart"></canvas>
			</div>
		</section>
		<hr>
	</article>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
<script type="text/javascript">
</script>	

</body>
</html>