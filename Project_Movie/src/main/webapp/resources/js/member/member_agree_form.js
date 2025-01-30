function submitForm() {
    const termsAgree = document.getElementById("terms-agree").checked;
    const privacyAgree = document.getElementById("privacy-agree").checked;

    if (!termsAgree || !privacyAgree) {
        alert("모든 약관에 동의해야 합니다.");
        return;
    }

    // 약관 동의가 완료되면 서버로 동의 여부 전송
    fetch("MemberAgree", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ termsAgreed: true })
    })
    .then(response => {
        if (response.ok) {
            // 동의가 완료되면 MemberJoin 페이지로 이동
            window.location.href = "MemberJoin";
        } else {
            alert("약관 동의 처리 중 오류가 발생했습니다.");
        }
    })
    .catch(error => {
        console.error("Error:", error);
    });
}