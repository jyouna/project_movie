		$(function () {
			let payment_code = "";
			let movie_name = "";
			let start_time = "";
			let total_payment = "";
			$("table").on("click", "tr", function() {
				$(this).find("input[type='radio']").prop("checked", true);
				payment_code = $(this).find("td:eq(1)").text();
			    movie_name = $(this).find("td:eq(2)").text();
			    start_time = $(this).find("td:eq(6)").text().trim();
			    total_payment = parseInt($(this).find("td:eq(7)").text().trim());
				console.log(total_payment + ", " + typeof(total_payment));
			})
			$("#detail").click(function () {
			    if (payment_code == "") {
			        alert("영화를 선택해주세요.");
			    } else {
			        $("#reservation_detail_modal").css("display", "block");
					console.log("payment_code" + payment_code);
			        $.ajax({
			            type: "POST",
			            url: "ReservationDetail",
			            data: {
			                payment_code: payment_code 
			            }
			        }).done(function (result) {
			            $("input[name='payment_code']").val(result.payment_code);
			            $("input[name='movie_name']").val(result.movie_name);
			            $("input[name='ticket_count']").val(result.ticket_count);
			            $("input[name='total_seat_code']").val(result.total_seat_code);
			            $("input[name='theater_code']").val(result.theater_code);
			            $("input[name='total_amount']").val(result.total_amount);
			            $("input[name='r_date']").val(result.r_dateToString);
			        }).fail(function () {
			            alert("상세 정보를 가져오는 데 실패하였습니다.");
			        });
			    }
		});

			$(".close_modal").click(function() {
				location.reload();
			})
			
			$("#cancel").on("click", function(){
				const radioButtons = document.getElementsByName("reservationRadio");
				let selectedRadio = null;
				for(const radio of radioButtons){
					if(radio.checked){
						selectedRadio = radio.value;
						break;
					}
				}
				if(!selectedRadio){
					alert("영화를 선택해주세요.");
				}else{
					if(confirm("예매 취소하시겠습니까?")) {
//						const paymentEndTimeValue = document.getElementsByName("start_time").value; 
//						const reservationStartTime = new Date(paymentEndTimeValue); // datetime-local 값을 Date 객체로 변환
//						const currentTime = new Date();
//						const timeDifference = (reservationStartTime - currentTime) / (1000 * 60);
//						console.log(reservationStartTime,currentTime, timeDifference );
							$.ajax({
								type : "POST"
								, url : "ReservationCancel"
								, data : {
									payment_code : payment_code,
									start_time : start_time,
									total_payment : total_payment
								}
								, dataType : "JSON"
							}).done(function(result) {
								alert("예매가 취소되었습니다");
//								$("input[name='movie_name']").val(result.movie_name);
//								$("input[name='start_time']").val(result.start_time);
//								$("input[name='r_people']").val(result.r_people);
//								$("input[name='r_price']").val(result.r_price);
						}).fail(function(){
							alert("예매 취소에 실패하였습니다.\n다시 시도해주세요");
						});
					
					}else{
						location.reload();
					}
				}//else
				
			});
			
		});
		
	