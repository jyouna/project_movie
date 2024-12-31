document.getElementById("submit-btn").addEventListener("click", function () {
    const termsAgree = document.getElementById("terms-agree").checked;
    const privacyAgree = document.getElementById("privacy-agree").checked;

    if (!termsAgree || !privacyAgree) {
        alert("모든 약관에 동의해야 합니다.");
        return;
    }

  	
});