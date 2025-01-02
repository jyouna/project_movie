document.addEventListener("DOMContentLoaded", () => {
    // 탭 전환 기능
    const idTab = document.getElementById("find-id-tab");
    const pwTab = document.getElementById("find-pw-tab");
    const idForm = document.getElementById("find-id-form");
    const pwForm = document.getElementById("find-pw-form");

    // 기본 설정: 아이디 찾기 폼 보이기
    idForm.classList.remove("hidden");
    pwForm.classList.add("hidden");
    idTab.classList.add("active");
    pwTab.classList.remove("active");

    idTab.addEventListener("click", () => {
      idTab.classList.add("active");
      pwTab.classList.remove("active");
      idForm.classList.remove("hidden");
      pwForm.classList.add("hidden");
    });

    pwTab.addEventListener("click", () => {
      pwTab.classList.add("active");
      idTab.classList.remove("active");
      pwForm.classList.remove("hidden");
      idForm.classList.add("hidden");
    });

    // 아이디 찾기
    document.getElementById("find-id-btn").addEventListener("click", () => {
      const name = document.getElementById("id-name").value;
      const phone = document.getElementById("id-phone").value;

      if (!name || !phone) {
        alert("이름과 휴대폰 번호를 입력하세요.");
        return;
      }

      alert(`입력된 정보로 아이디를 찾습니다.\n이름: ${name}, 휴대폰: ${phone}`);
    });

    // 비밀번호 찾기
    document.getElementById("find-pw-btn").addEventListener("click", () => {
      const name = document.getElementById("pw-name").value;
      const email = document.getElementById("pw-email").value;

      if (!name || !email) {
        alert("이름과 이메일을 입력하세요.");
        return;
      }

      alert(`입력된 정보로 비밀번호를 찾습니다.\n이름: ${name}, 이메일: ${email}`);
    });

    // 인증번호 발송
    document.getElementById("send-code-btn").addEventListener("click", () => {
      alert("인증번호가 발송되었습니다.");
    });
});
