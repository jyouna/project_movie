document.getElementById("registerForm").addEventListener("submit", function(event) {
  event.preventDefault(); // 기본 제출 동작 방지

  // 아이디 검증
  const username = document.getElementById("username").value;
  if (username.length < 5) {
      alert("아이디는 최소 5자 이상 입력하세요.");
      return;
  }

  // 비밀번호 검증
  const password = document.getElementById("password").value;
  const confirmPassword = document.getElementById("confirm-password").value;
  if (password !== confirmPassword) {
      alert("비밀번호가 일치하지 않습니다.");
      return;
  }

  // 이메일 검증
  const email = document.getElementById("email").value;
  const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailPattern.test(email)) {
      alert("올바른 이메일을 입력하세요.");
      return;
  }

  // 전화번호 검증
  const phone = document.getElementById("phone").value;
  if (!/^\d+$/.test(phone)) {
      alert("전화번호는 숫자만 입력하세요.");
      return;
  }

  const gender = document.querySelector('input[name="gender"]:checked');
  if (!gender) {
      alert("성별을 선택하세요.");
      return;
  }

  // 검증 통과 시 메인 페이지로 이동
  alert("회원가입이 완료되었습니다!");
  window.location.href = "http://localhost:8081/project_movie";
});

// 취소 버튼 클릭 이벤트 추가
document.getElementById("cancel-btn").addEventListener("click", function() {
  window.location.href = "http://localhost:8081/project_movie";
});
