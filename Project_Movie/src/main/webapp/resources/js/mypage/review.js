$(function() {
    let movie_code = "";
    let movie_name = "";
    let review_content = "";
    let review_recommend = "";

    $("table").on("click", "tr", function() {
        $(this).find("input[type=radio]").prop("checked", true);
        movie_name = $(this).find("td:eq(1)").text();
        review_content = $(this).find("td:eq(2)").text();
        review_recommend = $(this).find("td:eq(3)").val();
    });

    $("#Modify").on("click", function() {
        if (movie_name === "") {
            alert("수정할 리뷰의 영화를 선택해주세요.");
        } else {
            $("#watched_movie_modify_modal").css("display", "block");
            $(".watched_movie_modify input[name='movie_name']").val(movie_name);
            $(".watched_movie_modify textarea[name='review']").val(review_content);
        }
    });

    $(".close_modal").click(function() {
        location.reload();
    });

    $(".movie_code").on("click", function() {
        movie_code = $(this).val();
    });

    $(".submit_modal").click(function() {
        movie_code = $(".movie_code:checked").val();
        review_content = $("textarea").val().trim();
        review_recommend = $("input[name='review_recommend']:checked").val();

        if (review_content === "") {
            alert("리뷰를 작성해 주세요");
            return;
        }

        $.ajax({
            type: "POST",
            url: "ReviewModify",
            data: {
                movie_code: movie_code,
                review_content: review_content,
                review_recommend: review_recommend,
            }
        }).done(function(result) {
            alert("리뷰 등록 완료되었습니다.");
            location.reload(true);
        }).error(function() {
            alert("리뷰 제출 중 오류가 발생했습니다.");
        });
    });

    $(".cancel_modal").click(function() {
        location.reload(true);
    });

    $("#delete").on("click", function() {
        movie_code = $(".movie_code:checked").val();
        if (confirm("관람평을 삭제하시겠습니까?")) {
            $.ajax({
                type: "GET",
                url: "ReviewDelete",
                data: {
                    movie_code: movie_code
                }
            }).done(function(result) {
                window.location.href = "Review";
            }).error(function() {
                alert("삭제에 실패했습니다. 다시 시도해 주세요.");
            });
        }else{
			return;
		}
    });
});
