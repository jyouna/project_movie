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
	
	let getMovieCode="";
	
	$(".get_movie_code").on("click", function(){
		getMovieCode = $(this).val();
		console.log("영화코드 : " + getMovieCode);
	})
	
	$(".submit_modal").click(function(){
		getMovieCode = $(".get_movie_code:checked").val();

		console.log("ajax 영화코드 : " + getMovieCode);
		
		let reviewContent = $("textarea").val().trim();
		let reviewRecommend = $("input[name='review_recommend']:checked").val();
		
		if (reviewContent == ""){ 
			alert("리뷰 내용을 작성해주세요."); 
			return; 
		} 
		
		if(!reviewRecommend){
			alert("추천 또는 비추천을 선택해주세요.")
			return;
		}
	
	    $.ajax({
	        type: "POST",
	        url: "reviewRegister", 
	        data: {
	            moviename: $("input[name='movie_name']").val(),
	            review_content: reviewContent,
	            review_recommend: reviewRecommend,
				movie_code : getMovieCode
			}
	        }).done(function(result) {
				alert("리뷰 등록 완료!");
				location.reload(true);
	        }).error(function() {
	            alert("리뷰 제출 중 오류가 발생했습니다. 다시 시도해주세요.");
	    });

		}
	);

    $(".cancel_modal").click(function() {
        location.reload(true);
    });
});
