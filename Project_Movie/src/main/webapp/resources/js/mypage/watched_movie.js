$(function(){
	// 필요한 변수를 생성하고 널값을 준다.
	//table의 tr부분을 클릭하면 함수가 동작하도록
	// 선택한 부분에서 input type 라디오를 찾아 checked를 true로 조작
	// 선택한 부분에서 몇번째 찾아서 택스트를 가져와 변수에 집어넣는다
	// -- 테이블 클릭 함수 종료
	
	// 리뷰등록 버튼 reviewRegister을 누르면 함수가 실행되도록
	// 라디오 버튼을 안 누르고 진행했을때를 거르기 위해 
	// document에서 이름요소인 watchedMovie 가져와서 const 변수 radioButtons에 넣는다
	// 일단 선택된 라디오 버튼은 없도록 null값을 준다 변수명 selectedRadio
	// 향상된 for문을 사용해서 라디오 선택 여부를 확인 
	// 라디오 버튼을 const radio에 넣어 만약 라디오가 체크되었다면,
	// 라디오의 값을 selectedRadio에 넣고 break를 건다.
	
	//만약 영화선택이 안됐다면 영화를 선택해주세요 라는 알림창 띄우고, 
	// 그렇지 않으면, watched_movie_review_modal의 css display block으로 하고
	//ajax를  
	let r_moviename = "";
	let r_date = "";
	$("table").on("click", "tr", function(){
		$(this).find("input[type='radio']").prop(checked, "true")       
		r_moviename = $(this).find("td:eq(1)").text();
		r_date = $(this).find("td:eq(2)").text();
	})
	$("#reviewRegister").on("click", function(){
		const radioButtons = document.getElementsByName("watchedMovie");
		let selectedRadio = null;
		for(const radio of radioButtons){
			if(radio.checked){
				selectedRadio = radio.value;
				break;
			}
		}//for
		if(!selectedRadio){
			alert("리뷰 작성할 영화를 선택해주세요.");
		}else{
			
		}
		
	})
}); //function의 끝