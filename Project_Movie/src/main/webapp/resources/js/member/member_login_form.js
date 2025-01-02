document.getElementById("registerForm").addEventListener("submit", function(event) {
    event.preventDefault(); // 기본 제출 동작 방지

    // 검증 로직
    const username = document.getElementById("username").value;
    if (username.length < 5) {
        alert("아이디는 최소 5자 이상 입력하세요.");
        return;
    }

    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirm-password").value;
    if (password !== confirmPassword) {
        alert("비밀번호가 일치하지 않습니다.");
        return;
    }

    alert("회원가입이 완료되었습니다!");
    window.location.href = "http://localhost:8081/project_movie/"; // 메인 페이지로 이동
});

window.addEventListener('resize', () => {
  const container = document.querySelector('.container');
  // 화면 크기에 따라 최대 너비 조정
  container.style.maxWidth = window.innerWidth > 800 ? '800px' : '90%';
});

// 취소 버튼 처리
document.getElementById("cancel-btn").addEventListener("click", function() {
    window.location.href = "http://localhost:8081/project_movie/"; // 메인 페이지로 이동
});


