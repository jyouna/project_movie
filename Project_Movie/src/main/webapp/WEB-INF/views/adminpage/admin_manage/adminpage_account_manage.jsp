<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<h3>관리자 계정관리</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
			<input type="button" value="ID조회" id="idSearch">
		</div>	
		<div id="divTopRight">
			<input type="button" value="권한설정" class="topRight" id="setAuth">
			<input type="button" value="계정생성" class="topRight" id="createId">
			<input type="button" value="계정삭제" class="topRight" id="deleteId">
		</div>	
	</div>
	<div id="tableDiv" class="view">
		<table id="mainTable">
			<tr align="center" id="tr01">
				<th width="70">번호</th>
				<th width="50">선택</th>
				<th width="90">ID</th>
				<th width="90">비밀번호</th>
				<th width="150">등록일</th>
				<th width="80">상태</th>
				<th width="80">담당자</th>
				<th width="90">회원목록관리</th>
				<th width="80">결제관리</th>
				<th width="80">게시판관리</th>
				<th width="80">영화관리</th>
				<th width="80">상영관관리</th>
				<th width="80">투표관리</th>
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
				            <td>${status.count}</td>
				            <td><input type="checkbox" class="deleteCheck" value="${vo.admin_id}"></td>
				            <td>${vo.admin_id}</td>
				            <td>${vo.admin_passwd}</td>
				            <td>${vo.start_date}</td>
				            <td><input type="checkbox" ${vo.user_status ? 'checked' : ''}></td>
				            <td>${vo.user_name}</td>
				            <td><input type="checkbox" class="setAuthCheckBox" ${vo.member_manage ? 'checked' : ''}></td>
				            <td><input type="checkbox" class="setAuthCheckBox" ${vo.payment_manage ? 'checked' : ''}></td>
				            <td><input type="checkbox" class="setAuthCheckBox" ${vo.notice_board_manage ? 'checked' : ''}></td>
				            <td><input type="checkbox" class="setAuthCheckBox" ${vo.movie_manage ? 'checked' : ''}></td>
				            <td><input type="checkbox" class="setAuthCheckBox" ${vo.theater_manage ? 'checked' : ''}></td>
				            <td><input type="checkbox" class="setAuthCheckBox" ${vo.vote_manage ? 'checked' : ''}></td>
				        </tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
	<br>
	<div id="divBottom" class="view">
		<a href="#">1</a>
		<a href="#">2</a>
		<a href="#">3</a>
		<a href="#">4</a>
		<a href="#">5</a>
	</div>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
	
	<script type="text/javascript">
	$(function(){
		// id조회 창 출력
		$("#idSearch").on("click", function(){
			window.open(                
				'AdminPageIdSearch', // 팝업 창에 로드할 파일
	            'ID 조회',    // 팝업 창 이름
	            'width=300,height=150,scrollbars=no,resizable=no');
		});	
		
		// 권한 설정
	  $("#setAuth").on("click", function () {
  			const selectedAuth = $(".setAuthCheckBox").map(function () {
  			// 모든 체크박스의 체크 상태를 저장
  			// 해당 ID에 속하는 체크박스 체크 상태를 인덱스로 구분하여 저장.
		        return {
		            id: $(this).closest("tr").find(".deleteCheck").val(), // 해당 계정 ID
		            field: $(this).closest("td").index(), // 체크박스 필드 인덱스
		            checked: $(this).is(":checked") // 체크 상태
	        	};	
	        }).get();
		console.log(selectedAuth);
  			
        if (confirm("권한을 설정하시겠습니까?")) {
            // 권한 설정 정보를 서버로 전송
            $.ajax({
                url: "AdminSetAuth", // 권한 설정을 처리할 서버 URL
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(selectedAuth),
            }). success(function (response) {
                    alert("권한이 성공적으로 설정되었습니다.");
                    // 필요하면 페이지를 새로고침하거나 UI를 업데이트
                }).error(function (response) {
                    alert("권한 설정에 실패했습니다.");
                });
        }
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
// 		        	console.log(selectedIds.push($(this).val()));
		        });

		        if (confirm("해당 계정을 삭제하시겠습니까? 되돌릴 수 없습니다.")) {
		            // 선택된 ID를 서버로 전송
		            location.href = "DeleteAdminAccount?admin_id=" + selectedIds.join(",");
		        }
		    } else {
		        alert("삭제할 계정을 선택하세요.");
		    }
		});
	
	});
	</script>
</body>
</html>