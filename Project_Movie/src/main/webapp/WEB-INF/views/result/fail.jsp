<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<script>
   // 컨트롤러에서 Model 객체를 통해 저장한 msg 속성값을 alert() 함수를 통해 출력
   alert("${msg}"); // \${msg} 부분은 서버측에서 뷰페이지 렌더링 시 실제 값으로 치환되어 전송됨
   
   // 서버로부터 전송된 targetURL 속성값이 [비어있을 경우] 이전 페이지로 돌아가기 처리하고
   // 아니면, targetURL 속성에 지정된 페이지로 이동 처리
//    if("${targetURL}" == "") { // targetURL 이 비어있을 경우
//       // 이전 페이지로 돌아가기
//       history.back();
//    } else { // targetURL 이 비어있지 않을 경우
//       // 지정된 페이지로 이동
//       location.href = "${targetURL}";
//    }
   // -----------------------------------------------------
   // JSTL 사용할 경우(실제 수행하는 이동처리 코드만 보이고 if 문은 클라이언트측에서 보이지 않음)
   <!-- targetURL 속성값이 비어있는지 판별(EL 로 직접 판별 = empty 활용) -->
   <c:choose>
      <c:when test="${empty targetURL}">
         history.back();
      </c:when>
      <c:otherwise>
         location.href = "${targetURL}";
      </c:otherwise>
   </c:choose>
</script>









