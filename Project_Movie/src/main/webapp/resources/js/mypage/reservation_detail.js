		$(function () {
			let r_code = ""
			let r_moviename = ""
			$("table").on("click", "tr", function() {
				$(this).find("input[type='radio']").prop("checked", true);
				r_code = $(this).find("td:eq(1)").text();
			    r_moviename = $(this).find("td:eq(3)").text();
			})
			$("#detail").click(function () {
		    const radioButtons = document.getElementsByName("reservationRadio");
		    let selectedRadio = null;
		
		    // 라디오 버튼 선택 여부 확인
		    for (const radio of radioButtons) {
		        if (radio.checked) {
		            selectedRadio = radio.value; // 선택된 라디오 버튼 값 저장
		            break;
		        }
		    }
		    if (!selectedRadio) {
		        alert("영화를 선택해주세요.");
		    } else {
		        $("#reservation_detail_modal").css("display", "block");
		
		        $.ajax({
		            type: "POST",
		            url: "ReservationDetail",
		            data: {
		                r_code: r_code 
		            }
		        }).done(function (result) {
		            $("input[name='r_num']").val(result.r_num);
		            $("input[name='r_moviename']").val(result.r_moviename);
		            $("input[name='r_people']").val(result.r_people);
		            $("input[name='r_seat']").val(result.r_seat);
		            $("input[name='r_theater']").val(result.r_theater);
		            $("input[name='r_price']").val(result.r_price);
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
					alert("예매 취소하시겠습니까?")
					const reservationStartTime = result.r_dateToString;
					const currentTime = new Date();
					const timeDifference = (reservationStartTime - currentTime) / (1000 * 60);
	
					if(timeDifference > 30){
						$.ajax({
							type : "POST"
							, url : "ReservationCancel"
							, data : 
							r_code
						}).done(function(result) {
							$("input[name='r_moviename']").val(result.r_moviename);
							$("input[name='r_date']").val(result.r_dateToString);
							$("input[name='r_people']").val(result.r_people);
							$("input[name='r_price']").val(result.r_price);
						
					});
					}else{
						alert("시작 시간 30분 전까지만 취소할 수 있습니다.");
					}
				}//else
				
			});
			
		});
		
	