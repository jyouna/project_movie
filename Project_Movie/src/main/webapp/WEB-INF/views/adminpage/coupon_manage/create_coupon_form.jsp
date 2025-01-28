<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>쿠폰 발급</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
</head>
<body>
<!-- 	<form id="CreateCouponForm"> -->
	<div id="tableDiv" class="view" style="overflow-x: auto;">
	<h3>쿠폰 발급</h3>
		<fieldset> <!--  할인쿠폰 / 금액쿠폰 선택 영역  -->
			<table class="mainTable"> 
				<tr class="tr01" id="tr02">
					<th>만료일</th>
					<th>수량</th>
					<th>쿠폰타입</th>
					<th id="thForDiscount"></th>
				</tr>
				<tr>
					<td><input type="date" name="expired_date" id="expired_date" required></td>
					<td><button id="sub">-</button><input type="text" name="coupon_count" id="coupon_count" value="1" maxlength="1" readonly><button id="add">+</button></td>
					<td> <!--  할인율/금액할인 선택 -->
						<select id="coupon_type" name="coupon_type" required>
							<option>선택</option>
							<option>금액할인</option>
							<option>할인율</option>
						</select>
					</td>
					<td> <!-- 할인율 혹은 할인금액 입력!! -->
						<select id="discount_rate" name="discount_rate" class="discount_rate" hidden>
							<option value="0" selected>선택</option>
							<option>10</option>
							<option>20</option>
							<option>30</option>
							<option>40</option>
							<option>50</option>
							<option>60</option>
							<option>70</option>
							<option>80</option>
							<option>90</option>
							<option>100</option>
						</select>
						<input type="text" maxlength="5" id="discount_amount" name="discount_amount" value="0" placeholder="1~99999입력" class="discount_amount" hidden>
					</td>
				</tr>
			</table>			
		</fieldset>
		<div id="couponSet">
			<input type="button" value="지급하기" id="CreateCouponForm">
			<input type="button" value="돌아가기" id="closeForm">
		</div>
		<br>
		<h3>쿠폰 지급 대상자</h3>
		<fieldset> <!--  지급 대상자 출력 항목 -->
			<table id="mainTable" class="mainTable">
				<tr align="center" id="tr01" class="tr01">
					<th>순서</th>
					<th>아이디</th>
				</tr>
				<c:choose>
					<c:when test="${empty member_id}">
						<tr>
							<th colspan="3">"선택된 대상자가 없습니다"</th>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="id" items="${member_id}" varStatus="status">
							<tr>
								<td>${status.count}</td>
								<td class="getIdList">${id}</td>
							</tr>	
						</c:forEach>
					</c:otherwise>
				</c:choose> 
			</table>
		</fieldset>
	</div>
<!-- 	</form> -->
<script type="text/javascript">
$(function(){
	let time = new Date();
	time.setHours(time.getHours() + 9); // UTC+9 적용
	let today = time.toISOString().split('T')[0];
// 	let today2 = time.toLocaleString();
	console.log("today : " + today);
// 	console.log("today2 : " + today2);
	$("#expired_date").attr("min", today);
	
	$("#coupon_type").on("change", function(){
		let coupon_type = $("#coupon_type").val();
		console.log("쿠폰 타입 : " + coupon_type);
		
	    if (coupon_type === "금액할인") {
	        $("#thForDiscount").text("할인금액");
	        $("#discount_amount").removeAttr("hidden"); // hidden 속성 제거
	        $("#discount_rate").attr("hidden", true); // 다른 항목 숨기기
	    
	    } else if (coupon_type === "할인율") {
	        $("#thForDiscount").text("할인율");
	        $("#discount_rate").removeAttr("hidden");
	        $("#discount_amount").attr("hidden", true);
	    
	    } else {
	        $("#thForDiscount").text(""); // 기본값 초기화
	        $("#discount_amount").attr("hidden", true);
	        $("#discount_rate").attr("hidden", true);
	    }
	});
	
	$("#CreateCouponForm").on("click", function(){
		
		if(!confirm("해당 쿠폰을 지급하시겠습니까?")) {
			return;
		}
		// 지급 대상자
		const member_id = $(".getIdList").map(function() {
			return $(this).text();
	    }).get();
		
		// 만료일
		let expired_date = $("#expired_date").val();
		// 쿠폰타입
		let coupon_type = $("#coupon_type").val();
		// 금액
		let discount_amount = $("#discount_amount").val().trim();
		// 할인율
		let discount_rate = $("#discount_rate").val();
		// 수량
		let coupon_count = $("#coupon_count").val();
		
		// 2. 필수요소 입력 여부 검증
		// 2-1) 날짜 
		if(expired_date === "") {
			event.preventDefault();
			alert("날짜를 입력해 주세요");
			$("#expired_date").focus();
			return;
		}
		
		// 2-2) 쿠폰타입 선택
		if(coupon_type === "선택") {
			event.preventDefault();
			alert("쿠폰 타입을 선택해 주세요");
			$("#coupon_type").focus();
			return;
		}
		
		// 2-3) 할인금액
		if(coupon_type === "금액할인") {
			if(parseInt(discount_amount, 10) <= 0 || discount_amount === "") {
				event.preventDefault();
				alert("금액(1~99,999)을 입력해 주세요");
				$("#discount_amount").focus();
				return;
			}
		}

		// 2-4) 할인율
		if(coupon_type === "할인율") {
			if(discount_rate === "0") {
				event.preventDefault();				
				alert("할인율을 선택해주세요");
				$("#discount_rate").focus();
				return;
			}
		}
		
		$.ajax({
			url: "CreateCoupon",
			type: "post",
			traditional: true, // 배열 데이터를 단순 키-값 형태로 전송. 없으면 전달 안됨 
			data: {
				member_id : member_id,
				expired_date : expired_date,
				coupon_type : coupon_type,
				discount_amount : discount_amount,
				discount_rate : discount_rate,
				coupon_count : coupon_count
			}
		}).done(function(response){
			if(response){
				alert("쿠폰이 지급되었습니다");
				window.opener.location.replace("MemberList");
				window.close();
			} else {
				alert("쿠폰 등록 실패");
			}
		});
	});	
	
	$("#closeForm").on("click", function(){
		window.close();
	});
	
	
	$("#sub").on("click", function(){
		let val = $("#coupon_count").val();
		if(val > 1 && val <= 10) {
			val--;
			$("#coupon_count").val(val);
		} else {
			alert("1~10개만 선택 가능합니다");
		}
	});
	
	$("#add").on("click", function(){
		let val = $("#coupon_count").val();
		if(val >= 1 && val < 10) {
			val++;
			$("#coupon_count").val(val);
		} else {
			alert("1~10개만 선택 가능합니다");
		}
	});
})
</script>
</body>
</html>