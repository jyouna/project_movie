$(function(){
    let movie_name = ""
    $("table").on("click", "tr", function(){
        $(this).find("input[type=radio]").prop("checked", true);      
        movie_name = $(this).find("td:eq(1)").text();
        start_time = $(this).find("td:eq(2)").text().trim();
    });
    $("#reviewRegister").click(function(){
        if(movie_name == ""){
            alert("리뷰 작성할 영화를 선택해주세요.");
//        }else if(isRegist == 1){
//			alert("이미 리뷰를 작성한 영화입니다.");
		}else{
            $("#watched_movie_review_modal").css("display","block");
            $(".watched_movie_review input[name='movie_name']").val(movie_name);
        }
    });
    $(".close_modal").click(function() {
        location.reload();
    });
	$(".submit_modal").click(function(){
		var reviewContent = $("textarea").val().trim();
		var reviewRecommend = $("input[name='review_recommend']:checked").val();
		if (reviewContent == ""){ 
			alert("리뷰 내용을 작성해주세요."); 
			return; 
		}else if(!reviewRecommend){
			alert("추천 또는 비추천을 선택해주세요.")
			return;
		}
//		else{
//			
//		    $.ajax({
//		        type: "POST",
//		        url: "Review", 
//		        data: {
//		            moviename: $("input[name='movie_name']").val(),
//		            reviewContent: reviewContent,
//		            review_recommend: reviewRecommend
//				}
//		        }).done(function(result) {
//		            alert("리뷰가 성공적으로 제출되었습니다.");
//					// isRegist 값 변경 0에서 1로
//		            location.reload(); 
//		        }).error(function() {
//		            alert("리뷰 제출 중 오류가 발생했습니다. 다시 시도해주세요.");
//		    });
//		}
	});

    $(".cancel_modal").click(function() {
        location.reload(true);
    });
});
