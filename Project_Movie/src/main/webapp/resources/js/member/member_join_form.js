$(document).ready(function() {
    const csrfToken = $("#_csrf").val(); // CSRF 토큰 가져오기
    const contextPath = "/project_movie"; // 서버 contextPath
	

    $("#id").on("blur", function() {
        let id = $("#id").val().trim();
        console.log("입력된 아이디: " + id);

		if (id.length === 0) {
         $("#id-check-result").text("아이디를 입력하세요").css("color", "skyblue");
         return;
        }

        let regex = /^[A-Za-z0-9][A-Za-z0-9_]{4,15}$/;

        
        if (regex.test(id)) {
            // 서버에 아이디 중복 확인 요청
            $.ajax({
           	    url: contextPath + "/checkId", // 전달받은 contextPath 사용
                type: "POST",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                data: {
                 member_id: id,
                 _csrf: csrfToken // CSRF 토큰 추가
              
                 },
                success: function(response) {
                    if (response) {
                        $("#id-check-result").text("중복된 아이디입니다").css("color", "red");
                    } else {
                        $("#id-check-result").text("사용가능한 아이디입니다").css("color", "blue");
                    }
                },
                error: function() {
                    $("#id-check-result").text("예외발생 js38)서버 오류 발생").css("color", "red");
                }
            });
        } else {
            $("#id-check-result").text("형식이 올바르지 않습니다").css("color", "red");
        }
    });
        
        
         
   
});
















$(function() {
    $("#password").on("blur", function() {
        let passwd = $("#password").val();
        console.log("입력된 비밀번호: " + passwd);

        // 정규표현식: 영문자, 숫자, 특수문자(!@#$%) 포함, 8~16글자
        let lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;

        if (lengthRegex.test(passwd)) {
            let count = 0;

            // 복잡도 검사
            if (/[A-Z]/.test(passwd)) count++; // 대문자
            if (/[a-z]/.test(passwd)) count++; // 소문자
            if (/\d/.test(passwd)) count++;    // 숫자
            if (/[!@#$%]/.test(passwd)) count++; // 특수문자

            let msg = "";
            let color = "";

            switch (count) {
                case 4:
                    msg = "안전도 : 안전";
                    color = "blue";
                    break;
                case 3:
                    msg = "안전도 : 보통";
                    color = "green";
                    break;
                case 2:
                    msg = "안전도 : 취약";
                    color = "orange";
                    break;
                default:
                    msg = " 사용불가";
                    color = "red";
            }

            $("#password-check-result").text(msg).css("color", color);
        } else {
            $("#password-check-result").text("영문자,숫자,(!@#$%) 포함, 8~16글자->규칙을 준수해주세요").css("color", "red");
        }
    });




    // 비밀번호 확인
    $("#confirm-password").on("blur", function() {
        let passwd = $("#password").val();
        let confirmPasswd = $("#confirm-password").val();

        if (passwd === confirmPasswd) {
            $("#confirm-password-check-result").text("비밀번호일치").css("color", "blue");
        } else {
            $("#confirm-password-check-result").text("비밀번호불일치").css("color", "red");
        }
    });
});





// 인증번호 전송 버튼 이벤트
document.getElementById("sendAuthCodeBtn").addEventListener("click", function (event) {
    event.preventDefault(); // 기본 폼 제출 방지
    const phone = document.getElementById("phone").value.trim();

	 if (!/^\d{10,11}$/.test(phone)) {
       alert("전화번호를 정확히 입력하세요.");
       return;
   	 }

    fetch("sendAuthCode", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: `phone=${encodeURIComponent(phone)}`
    })
    .then(response =>  {
	
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
    })
    .then(data => {
        if (data.status === "success") {
            alert("인증번호가 발송되었습니다.");
        } else {
            alert(data.message || "인증번호 발송에 실패했습니다.");
        }
    })
    .catch(error => {
        console.error("Error:", error);
        alert("오류가 발생했습니다. 다시 시도하세요.");


    });
});

// 인증번호 확인 버튼 이벤트
document.getElementById("verifyAuthCodeBtn").addEventListener("click", function (event) {
    event.preventDefault(); // 기본 폼 제출 방지
    const authCode = document.getElementById("authCode").value.trim();

    if (!authCode) {
        alert("인증번호를 입력하세요.");
        return;
    }

    fetch("verifyAuthCode", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: `code=${encodeURIComponent(authCode)}`
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === "success") {
            alert("인증에 성공했습니다.");
        } else {
            alert(data.message || "인증에 실패했습니다.");
        }
    })
    .catch(error => {
        console.error("Error:", error);
        alert("오류가 발생했습니다. 다시 시도하세요.");
    });
});
