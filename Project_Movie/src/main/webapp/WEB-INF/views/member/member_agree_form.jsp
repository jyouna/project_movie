<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>가입동의</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/member_agree_form.css" /></head>
<body>
  <div class="container">
    <h1 class="title">회원가입</h1>

   <div class="form-section">
  <h2 class="section-title">회원 가입 약관</h2>
  <textarea class="terms-box" readonly>
    ProjectMovie 영화관 회원가입 약관
    
    ProjectMovie 영화관(이하 ‘회사’)은 회원에게 더 나은 서비스와 혜택을 제공하기
    위해 다음과 같은 약관에 따라 회원 정보를 수집 및 이용합니다. 회원가입을 통해
    회사의 서비스를 이용함으로써 본 약관에 동의한 것으로 간주됩니다.

    1. 수집하는 개인정보 항목 및 목적
    회사는 회원 식별, 본인 확인, 서비스 제공, 고객 상담 등을 위해 아래의 정보를
    수집합니다.
    - 필수 항목: 이름, 아이디, 비밀번호, 연락처(이메일, 휴대전화번호)
    - 선택 항목: 생년월일, 성별, 주소

    2. 개인정보 보유 및 이용 기간
    회사는 회원 탈퇴 시까지 회원의 개인정보를 보유 및 이용하며, 회원이 동의 철회
    요청하거나 보유 기간이 경과한 경우 즉시 파기합니다.

    3. 개인정보 제공 및 공유
    회사는 회원의 동의 없이 제3자에게 개인정보를 제공하지 않습니다. 다만, 법적 
    요구 또는 회원의 별도 동의가 있는 경우 예외로 합니다.

    4. 기타 사항
    회원은 언제든지 개인정보 열람, 수정, 삭제를 요청할 수 있으며, 회사는 이를 
    성실히 처리합니다.

    본 약관은 회원가입일로부터 적용됩니다람쥐
  </textarea>
  <label class="checkbox-label">
    <input type="checkbox" id="terms-agree" /> 동의합니다
  </label>
</div>


    <div class="form-section">
  <h2 class="section-title">개인정보처리방침안내</h2>
  <textarea class="privacy-box" readonly>
    이용자 식별 및 본인여부 확인
    아이디, 이름, 비밀번호: 회원 탈퇴 시까지 보유
    고객서비스 이용에 관한 통지 및 CS 대응을 위한 이용자 식별
    연락처(이메일, 휴대전화번호): 회원 탈퇴 시까지 보유

    추가로, 서비스 개선 및 맞춤형 정보 제공을 위해 다음 정보를 수집 및 보관합니다:
    - 이용자의 서비스 이용 기록
    - 접속 IP 정보

    이러한 정보는 보안 목적과 더불어 통계 분석에도 활용됩니다
  </textarea>
  <label class="checkbox-label">
    <input type="checkbox" id="privacy-agree" /> 동의합니다
  </label>
</div>


   <div class="button-section">
      <button class="btn naver" onclick="location.href='naverSignup.jsp'">네이버 가입</button>
      <button class="btn kakao" onclick="location.href='kakaoSignup.jsp'">카카오톡 가입</button>
      <button class="btn normal" id="submit-btn" onclick="submitForm()">일반 회원가입</button>
    </div>
  </div>

<script>
    function submitForm() {
      const termsAgree = document.getElementById("terms-agree").checked;
      const privacyAgree = document.getElementById("privacy-agree").checked;

      if (!termsAgree || !privacyAgree) {
        alert("모든 약관에 동의해야 합니다.");
        return;
      }

      // 체크박스가 모두 체크된 경우 페이지 이동
      window.location.href = "http://localhost:8081/project_movie/MemberJoin";
    }
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/member/member_agree_form.js"></script>
</body>
</html>
