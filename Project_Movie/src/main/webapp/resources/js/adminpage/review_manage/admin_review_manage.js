$(function() {
    let movie_code = "";  // 현재 선택된 영화 코드
    let movie_name = "";  // 현재 선택된 영화 이름
    let review_code = "";  // 현재 선택된 리뷰 코드
    let review_content = "";  // 현재 선택된 리뷰 내용

    // 📌 테이블에서 행을 클릭했을 때 실행되는 이벤트 처리
    $("table").on("click", "tr", function() {
        // 1️⃣ 선택한 행의 `radio` 버튼을 체크 (영화 선택)
        $(this).find("input[type=radio]").prop("checked", true);
        
        // 2️⃣ `radio` 버튼에서 movie_code 값 가져오기 (영화 코드)
        movie_code = $(this).find("input[type=radio]").val();
        
        // 3️⃣ 해당 행의 `hidden input`에서 review_code 가져오기
        review_code = $(this).closest("tr").find(".review_code").val();
        
        // 4️⃣ 해당 행의 영화명 가져오기 (세 번째 열)
        movie_name = $(this).find("td:eq(2)").text();
        
        // 5️⃣ 해당 행의 리뷰 내용 가져오기 (네 번째 열)
        review_content = $(this).find("td:eq(3)").text();
        
        // 6️⃣ 콘솔에서 값 확인 (디버깅)
        console.log("선택된 리뷰 - movie_code:", movie_code, "review_code:", review_code);
    });

    // 📌 수정 버튼 클릭 시 모달 창 열기
    $("#Modify").on("click", function() {
        // 1️⃣ 리뷰를 선택하지 않았을 경우 알림창 표시
        if (movie_name === "") {
            alert("수정할 리뷰의 영화를 선택해주세요.");
        } else {
            // 2️⃣ 모달 창 표시
            $("#watched_movie_modify_modal").css("display", "block");
            
            // 3️⃣ 모달 창 내의 영화명 필드에 데이터 설정 (수정 불가능한 필드)
            $(".watched_movie_modify input[name='movie_name']").val(movie_name);

            // 4️⃣ 모달 창 내의 리뷰 내용 필드에 데이터 설정 (수정 가능 필드)
            $(".watched_movie_modify textarea[name='review']").val(review_content);
        }
    });

    // 📌 모달 창 닫기 (취소 버튼 클릭 시)
    $(".close_modal").click(function() {
        location.reload();  // 페이지 새로고침
    });

    // 📌 수정 완료 버튼 클릭 시 AJAX 요청
    $(".submit_modal").click(function() {
        // 1️⃣ 텍스트 입력 필드에서 리뷰 내용 가져오기
        review_content = $("textarea").val().trim();

        // 2️⃣ 리뷰가 입력되지 않았을 경우 알림창 표시
        if (review_content === "") {
            alert("리뷰를 작성해 주세요");
            return;
        }

        // 3️⃣ 콘솔에서 수정 요청 확인 (디버깅)
        console.log("리뷰 수정 요청 - review_code:", review_code, "review_content:", review_content);

        // 4️⃣ AJAX를 이용한 리뷰 수정 요청
        $.ajax({
            type: "POST",  // HTTP POST 요청
            url: "AdminReviewModify",  // 요청 URL
            data: {
                review_code: review_code,  // `review_code`만 전송
                review_content: review_content  // 새로운 리뷰 내용 전송
            }
        }).done(function(result) {
            // 5️⃣ 수정 성공 시 알림창 표시 및 페이지 새로고침
            alert("리뷰 수정 완료되었습니다.");
            location.reload(true);
        }).fail(function() {
            // 6️⃣ 수정 실패 시 알림창 표시
            alert("리뷰 수정 중 오류가 발생했습니다.");
        });
    });

    // 📌 취소 버튼 클릭 시 페이지 새로고침
    $(".cancel_modal").click(function() {
        location.reload(true);
    });

    // 📌 삭제 버튼 클릭 시 리뷰 삭제 요청
    $("#delete").on("click", function() {
        // 1️⃣ 현재 선택된 `radio` 버튼에서 해당 행의 `review_code` 가져오기
        review_code = $("input[type=radio]:checked").closest("tr").find(".review_code").val();

        // 2️⃣ 리뷰가 선택되지 않은 경우 알림창 표시
        if (!review_code) {
            alert("삭제할 리뷰를 선택해주세요.");
            return;
        }

        // 3️⃣ 콘솔에서 삭제 요청 확인 (디버깅)
        console.log("삭제 요청 - review_code:", review_code);

        // 4️⃣ 사용자가 삭제를 확정했을 경우 AJAX 요청 실행
        if (confirm("관람평을 삭제하시겠습니까?")) {
            $.ajax({
                type: "GET",  // HTTP GET 요청
                url: "AdminReviewDelete",  // 요청 URL
                data: {
                    review_code: review_code  // `review_code`만 전송
                }
            }).done(function(result) {
                // 5️⃣ 삭제 성공 시 알림창 표시 및 페이지 새로고침
                alert("리뷰가 삭제되었습니다.");
                window.location.href = "AdminReviewManage";
            }).fail(function() {
                // 6️⃣ 삭제 실패 시 알림창 표시
                alert("삭제에 실패했습니다. 다시 시도해 주세요.");
                window.location.href = "AdminReviewManage";
            });
        }
    });
});
