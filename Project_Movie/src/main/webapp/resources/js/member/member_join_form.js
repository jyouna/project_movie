// 인증번호 전송 버튼 이벤트
document.getElementById("sendAuthCodeBtn").addEventListener("click", function (event) {
    event.preventDefault(); // 기본 폼 제출 방지
    const phone = document.getElementById("phone").value.trim();

 // if (!/^\d{10,11}$/.test(phone)) {
 //       alert("전화번호를 정확히 입력하세요.");
 //       return;
 //   }

    fetch("sendAuthCode", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: `phone=${encodeURIComponent(phone)}`
    })
    .then(response => response.json())
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
