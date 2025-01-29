// 페이지 로드 시 데이터 확인 및 알림 표시



window.onload = function () {

    console.log("JavaScript js 동작확인 (비밀번호찾기) ");



    // 숨겨진 필드에서 데이터 가져오기
    const email = document.getElementById("email").value;
    const errorMsg = document.getElementById("error_msg").value;


    // 디버깅 로그 출력
    console.log("찾으려는 계정의 이메일 번호는  ", email," 입니다. \n  임시비밀번호를 메일로 발송했습니다.");
    console.log("errorMsg: ", errorMsg ," 정보를 확인하여 다시 진행해주세요");


     // 데이터에 따른 알림 표시
    if (email) {
   	    alert("찾으려는 계정의 이메일 : " + "\n"+ email +"로" + "\n"+"임시비밀번호가 5분내 발송됩니다.");
    } else if (errorMsg) {
        alert("에러 메시지: " + errorMsg + " 정보를 확인하여 다시 진행해주세요.");
    }
    
    
};
