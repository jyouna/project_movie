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
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<h3>주요 현황</h3>
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
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일</th>
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
									<td>${notice.notice_subject}</td>
									<td>${notice.notice_writer}</td>
									<td><fmt:formatDate value="${notice.regis_date}" pattern="yyyy-MM-dd hh:mm" /></td>
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
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일</th>
						<th>답변여부</th>
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
									<td>${inquiry.inquiry_subject}</td>
									<td>${inquiry.inquiry_writer}</td>
									<td><fmt:formatDate value="${inquiry.inquriy_date}" pattern="yyyy-MM-dd hh:mm" /></td>
									<td>미답변</td>
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
$(function(){
	let myChart;
	let myChart2;
	let date = new Date();
	let year = date.getFullYear()-1;
	let month = date.getMonth();
	$("#showPeriod").text(" : " + year).css("color", "black");

	$.ajax({
		url: "AdminMainGetYearTotalMemberJoinStaticsInfo",
		type: "get",
		data : {
			year : year,
		},
		dataType: "json",
		success: function(response){
  			if(myChart){myChart.destroy();} // 차트가 존재하면 먼저 지우고 새 차트를 생성
			
  			const monthOrder = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
 			const data = monthOrder.map(month => response[month] || 0); // 월 순서에 맞게 배열로 변환 (값이 없으면 0)
			const ctx = document.getElementsByClassName('myChart')[0].getContext('2d');
			
			let yearTotal = 0;
			for(let i = 0; i < monthOrder.length; i++) {
				yearTotal += data[i];
			}
			console.log(yearTotal);
			
			$("#showPeriod").text(year + "년 신규 가입자 : " + yearTotal.toLocaleString('ko-KR') + "명");
 			
 			myChart = new Chart(ctx, {
				type: "line",
				data: {
					labels : monthOrder, // 축
					datasets: [{ // 각 축에 들어갈 값 설정
						label: year + "년 가입자 수", // 값 이름
						data: data, // 값
						backgroundColor: 'rgba(255, 99, 132, 0.2)',
						borderColor: 'rgba(54, 162, 235, 1)',
						borderWidth: 2
					}]
				},
				options: {
			        responsive: true, // 반응형 차트 설정
			        maintainAspectRatio: false, // 가로세로 비율 고정 해제	
					plugins: {
			            legend: {
			                labels: {
			                    usePointStyle: true, // 범례를 점 모양으로
			                    pointStyle: 'line'  // 범례를 직선으로 설정
			                }
			            },						
// 						subtitle: { // 차트 제목
// 							display: true,
// 							text: '연간 가입자 통계' 
// 						}
					},
					scales: {
						x : {
							ticks: {
								color: 'rgba(75, 192, 192, 1)'
							}
						},
						y: {
							min : 0,
							max : 500,
							ticks: {
								color: 'rgba(75, 192, 192, 1)',
								stepSize: 50
							}
						}
					}
				}
			});
		}
	});
	
	$("#showPeriod2").text(" : " + year).css("color", "black");
	$.ajax({
		url: "GetYearSales",
		type: "get",
		data : {
			year : year,
		},
		dataType: "json",
		success: function(response){
  			if(myChart2){myChart2.destroy();} // 차트가 존재하면 먼저 지우고 새 차트를 생성
			
  			const monthOrder = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
 			const data = monthOrder.map(month => response[month] || 0); // 월 순서에 맞게 배열로 변환 (값이 없으면 0)
			const ctx = document.getElementsByClassName('myChart2')[0].getContext('2d');
			
			let yearTotal = 0;
			for(let i = 0; i < monthOrder.length; i++) {
				yearTotal += data[i];
			}
			console.log(yearTotal);
			
			$("#showPeriod2").text(year + "년 매출액 : " + yearTotal.toLocaleString('ko-KR') + "원");
 			
 			myChart = new Chart(ctx, {
				type: "bar",
				data: {
					labels : monthOrder, // 축
					datasets: [{ // 각 축에 들어갈 값 설정
						label: year + "년 매출액", // 값 이름
						data: data, // 값
						backgroundColor: 'rgba(255, 99, 132, 0.2)',
						borderColor: 'rgba(54, 162, 235, 1)',
						borderWidth: 1
					}]
				},
				options: {
					plugins: {
			            legend: {
			                labels: {
			                    usePointStyle: true, // 범례를 점 모양으로
			                    pointStyle: 'line'  // 범례를 직선으로 설정
			                }
			            },						
						subtitle: { // 차트 제목
							display: true,
							text: '연간 매출액 통계' 
						}
					},
					scales: {
						x : {
							ticks: {
								color: 'rgba(75, 192, 192, 1)'
							}
						},
						y: {
							min : 0,
							max : 25000000,
							ticks: {
								color: 'rgba(75, 192, 192, 1)',
								stepSize: 2500000
							}
						}
					}
				}
			});
		}
	});
})
	
</script>	

</body>
</html>