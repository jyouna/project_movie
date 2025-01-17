<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_account_manage.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />	
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/account_manage.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

<style type="text/css">
input[type="checkbox"] {
    transform: scale(1.5); /* 1.5배 확대 */
    margin: 5px;}
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<h3>관리자 계정관리</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
			<input type="button" value="권한설정" id="setAuth">
			<input type="button" value="계정생성" id="createId">
			<input type="button" value="계정삭제" id="deleteId">
		</div>	
		<div id="divTopRight">
		</div>	
	</div>
	<div id="tableDiv" class="view">
		<table id="mainTable">
			<tr align="center" id="tr01">
				<th width="50"><input type="checkbox" id="selectAll" class="deleteCheck"></th>
				<th width="70">번호</th>
				<th width="90">ID</th>
				<th width="90">비밀번호</th>
				<th width="150">등록일</th>
				<th width="80">상태</th>
				<th width="80">담당자</th>
				<th width="90">계정|<br>통계관리</th>
				<th width="80">결제관리</th>
				<th width="80">게시판관리</th>
				<th width="80">영화관리</th>
				<th width="80">상영관관리</th>
				<th width="80">이벤트|<br>투표관리</th>
			</tr>
			<c:choose>		
				<c:when test="${empty voList}">
					<tr>
						<th colspan="15">등록된 계정이 없습니다.</th>
					</tr>	
				</c:when>	
				<c:otherwise>
					<c:forEach var="vo" items="${voList}" varStatus="status">
				        <tr>
				            <td><input type="checkbox" class="deleteCheck" value="${vo.admin_id}"></td>
				            <td>${status.count}</td>
				            <td><a href="AdminAccountModify?admin_id=${vo.admin_id}">${vo.admin_id}</a></td>
				            <td>${vo.admin_passwd}</td>
				            <td><fmt:formatDate value="${vo.start_date}" pattern="yyyy-MM-dd"/></td>
				            <td>${vo.user_status ? '사용중' : '비사용'}</td>
				            <td>${vo.user_name}</td>
				            <td>${vo.member_manage ? 'O' : 'X'}</td>
				            <td>${vo.payment_manage ? 'O' : 'X'}</td>
				            <td>${vo.notice_board_manage ? 'O' : 'X'}</td>
				            <td>${vo.movie_manage ? 'O' : 'X'}</td>
				            <td>${vo.theater_manage ? 'O' : 'X'}</td>
				            <td>${vo.vote_manage ? 'O' : 'X'}</td>
				        </tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>		
		</table>			
	</div>
	<br>
	<div id="divBottom" class="view">
		<input type="button" value="이전" 
			onclick="location.href='AdminAccountManage?pageNum=${pageInfo.pageNum - 1}'" 
			<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
		<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			<c:choose>
				<c:when test="${i eq pagInfo.pageNum}">
					<strong>${i}</strong>
				</c:when>
				<c:otherwise>
					<a href="AdminAccountManage?pageNum=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<input type="button" value="다음" onclick="location.href='AdminAccountManage?pageNum=${pageInfo.pageNum + 1}'"
		<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
	</div>
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
	<script type="text/javascript">
		$(function(){
			// id조회 창 출력
			$("#idSearch").on("click", function(){
				window.open(                
					'AdminPageIdSearch', 
		            'ID 조회',    
		            'width=300,height=150,scrollbars=no,resizable=no');
			});	
			
			// 권한 설정
		$("#setAuth").on("click", function () {
			alert("권한 설정은 개별 아이디를 클릭하여 진행해주시기 바랍니다.");
	    });
		
		// 계정 등록 폼 이동
		$("#createId").on("click", function(){
			location.href="AdminAccountRegis";
		});
		
		// 선택한 계정 삭제
		$("#deleteId").on("click", function(){
		    // 선택된 체크박스 가져오기
		    let selectedCheckbox = $(".deleteCheck:checked");
// 			console.log(selectedCheckbox);
		    // 체크된 항목이 있는지 확인
		    if (selectedCheckbox.length > 0) {
		        let selectedIds = []; // 선택된 ID들을 저장할 배열
// 		        console.log(selectedIds);
		        selectedCheckbox.each(function () {
		            selectedIds.push($(this).val());// 체크박스의 value 값 (admin_id)을 배열에 추가
		        });

		        if (confirm("해당 계정을 삭제하시겠습니까? 되돌릴 수 없습니다.")) {
		            location.href = "DeleteAdminAccount?admin_id=" + selectedIds.join(",");
		        }
		    } else {
		        alert("삭제할 계정을 선택하세요.");
		    }
		});
		
		$("#selectAll").on("click", function(){
		    let checkboxes = $(".deleteCheck");  // 체크박스 항목들을 다루기 위한 객체 생성
		    let isChecked = $(this).data("checked") || false; // 전체선택 버튼의 현재 체크 상태값 저장. 없는 경우 false 값으로 설정.
		    $(this).data("checked", !isChecked); // 체크가 안된 상태에서 클릭했으면 true로 변경
		    checkboxes.prop("checked", !isChecked); // 체크가 안된 상태에서 클릭했으면 true로 변경
		});
	});
	</script>
</body>
</html>