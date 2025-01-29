$(function() {
    let movie_code = "";
    let movie_name = "";
    let review_content = "";
    let review_recommend = "";

    // 테이블에서 tr 클릭 시 라디오 버튼 선택
    $("table").on("click", "tr", function() {
        $(this).find("input[type=radio]").prop("checked", true);  // 해당 tr의 radio 선택
        movie_name = $(this).find("td:eq(1)").text();  // 영화 이름 가져오기
        review_content = $(this).find("td:eq(2)").text();  // 리뷰 내용 가져오기
        review_recommend = $(this).find("td:eq(3)").val();  // 리뷰 추천 값 가져오기
        console.log("movie_code 선택됨:", $(this).find("input[type=radio]:checked").val());  // 선택된 movie_code 값 확인
    });

    // 리뷰 수정 모달에서 제출 버튼 클릭 시
    $(".submit_modal").click(function() {
        let movie_code = $("input[name='movie_code']:checked").val();  // 체크된 라디오 버튼 값 가져오기
        let review_content = $("textarea").val().trim();  // 리뷰 내용 가져오기
        let review_recommend = $("input[name='review_recommend']:checked").val();  // 추천 여부 가져오기

        console.log("movie_code: ", movie_code);  // movie_code 값 확인
        console.log("라디오 버튼 전체: ", $("input[name='movie_code']"));  // 라디오 버튼 전체 출력
        console.log("체크된 라디오 버튼: ", $("input[name='movie_code']:checked"));  // 체크된 라디오 버튼 출력
        console.log("movie_code 값: ", movie_code);  // 선택된 movie_code 출력

        if (!movie_code) {
            alert("영화 코드가 선택되지 않았습니다!");  // 영화 코드가 없을 경우 alert
            return;
        }

        if (review_content === "") {
            alert("리뷰를 작성해 주세요");  // 리뷰 내용이 없으면 alert
            return;
        }

        // AJAX 요청
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/ReviewModify",  // 경로 확인
            data: {
                movie_code: movie_code,
                review_content: review_content,
                review_recommend: review_recommend
            }
        }).done(function(result) {
            alert("리뷰 등록 완료되었습니다.");
            location.reload(true);
        }).fail(function(xhr, status, error) {
            alert("리뷰 제출 중 오류가 발생했습니다: " + error);
            console.error("AJAX 실패:", xhr, status, error);
        });
    });

    // 취소 버튼 클릭 시
    $(".cancel_modal").click(function() {
        location.reload(true);
    });

    // 삭제 버튼 클릭 시
    $("#delete").on("click", function () {
        const movie_code = $(".movie_code:checked").val();  // 체크된 영화 코드 가져오기
        // 영화 선택 안 했을 때
        if (!movie_code) {
            alert("삭제할 리뷰의 영화를 선택해주세요.");
            return;
        }
        
        if (confirm("관람평을 삭제하시겠습니까?")) {
            $.ajax({
                type: "GET",
                url: "ReviewDelete",  // 삭제 요청
                data: { movie_code: movie_code }
            })
            .done(function (result) {
                window.location.href = "Review";  // 삭제 후 페이지 이동
            })
            .fail(function () {
                alert("삭제에 실패했습니다. 다시 시도해 주세요.");
            });
        }
    });

});
