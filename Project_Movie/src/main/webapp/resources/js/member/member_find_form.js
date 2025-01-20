// 페이지 로드 시 데이터 확인 및 알림 표시




window.onload = function () {

    console.log("JavaScript js 동작확인 ");



    // 숨겨진 필드에서 데이터 가져오기
    const memberId = document.getElementById("member_id").value;
    const errorMsg = document.getElementById("error_msg").value;



    // 디버깅 로그 출력
    console.log("찾으시는 아이디는 ", memberId," 입니다.");
    console.log("errorMsg: ", errorMsg ," 정보를 확인하여 다시 진행해주세요");


     // 데이터에 따른 알림 표시
    if (memberId) {
   	    alert("찾으신 아이디는:\n" + "\n"+ memberId + "\n"+"\n입니다.");
    } else if (errorMsg) {
        alert("에러 메시지: " + errorMsg + " 정보를 확인하여 다시 진행해주세요.");
    }
    
    
};
