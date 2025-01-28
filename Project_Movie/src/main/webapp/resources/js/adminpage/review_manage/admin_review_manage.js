$(function() {
    let movie_code = "";
    let movie_name = "";
    let review_content = "";
    let review_recommend = "";

    // 테이블에서 행을 클릭했을 때 이벤트 처리
    $("table").on("click", "tr", function() {
        // 선택한 행의 라디오 버튼 체크
        $(this).find("input[type=radio]").prop("checked", true);
        
        // 영화 코드 가져오기
        movie_code = $(this).find("input[type=radio]").val();
        
        // 영화명 가져오기 (두 번째 열)
        movie_name = $(this).find("td:eq(2)").text();
        
        // 리뷰 내용 가져오기 (세 번째 열)
        review_content = $(this).find("td:eq(3)").text();
        
        // 추천 여부 가져오기 (네 번째 열)
        review_recommend = $(this).find("td:eq(4)").text().trim() === "추천" ? 0 : 1;
    });

    // 수정 버튼 클릭 시 모달 창 열기
    $("#Modify").on("click", function() {
        if (movie_name === "") {
            alert("수정할 리뷰의 영화를 선택해주세요.");
        } else {
            // 모달 창 표시
            $("#watched_movie_modify_modal").css("display", "block");
            
            // 모달 창에 데이터 바인딩
            $(".watched_movie_modify input[name='movie_name']").val(movie_name); // 영화명
            $(".watched_movie_modify textarea[name='review']").val(review_content); // 리뷰 내용
            $(".watched_movie_modify input[name='review_recommend'][value='" + review_recommend + "']").prop("checked", true); // 추천 여부
        }
    });

    // 모달 창 닫기 (취소 버튼)
    $(".close_modal").click(function() {
        location.reload();
    });

    // 수정 완료 버튼 클릭 시 AJAX 요청
    $(".submit_modal").click(function() {
        movie_code = $(".movie_code:checked").val();
        review_content = $("textarea").val().trim();
        review_recommend = $("input[name='review_recommend']:checked").val();

        if (review_content === "") {
            alert("리뷰를 작성해 주세요");
            return;
        }

        // AJAX로 리뷰 수정 요청
        $.ajax({
            type: "POST",
            url: "AdminReviewModify",
            data: {
                movie_code: movie_code,
                review_content: review_content,
                review_recommend: review_recommend,
            }
        }).done(function(result) {
            alert("리뷰 수정 완료되었습니다.");
            location.reload(true);
        }).error(function() {
            alert("리뷰 수정 중 오류가 발생했습니다.");
        });
    });

    // 취소 버튼 클릭 시 페이지 새로고침
    $(".cancel_modal").click(function() {
        location.reload(true);
    });

    // 삭제 버튼 클릭 시 리뷰 삭제
    $("#delete").on("click", function() {
        movie_code = $(".movie_code:checked").val();
        if (confirm("관람평을 삭제하시겠습니까?")) {
            $.ajax({
                type: "GET",
                url: "AdminReviewDelete",
                data: {
                    movie_code: movie_code
                }
            }).done(function(result) {
                window.location.href = "AdminReviewManage";
            }).error(function() {
                alert("삭제에 실패했습니다. 다시 시도해 주세요.");
            });
        } else {
            return;
        }
    });
});