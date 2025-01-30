function submitForm() {
    const termsAgree = document.getElementById("terms-agree").checked;
    const privacyAgree = document.getElementById("privacy-agree").checked;

    if (!termsAgree || !privacyAgree) {
        alert("모든 약관에 동의해야 합니다.");
        return; // 약관 동의가 안 되어 있으면 함수 종료
    }

    // 약관 동의가 완료되면 서버로 동의 여부 전송
    fetch("MemberAgree", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "termsAgreed=true" // 서버에 약관 동의 여부 전송
    })
    .then(response => {
        if (response.redirected) {
            // 서버에서 리다이렉트를 요청한 경우, 해당 URL로 이동
            window.location.href = response.url;
        } else {
            alert("약관 동의 처리 중 오류가 발생했습니다.");
        }
    })
    .catch(error => {
        console.error("Error:", error);
        alert("네트워크 오류가 발생했습니다. 다시 시도해주세요.");
    });
}