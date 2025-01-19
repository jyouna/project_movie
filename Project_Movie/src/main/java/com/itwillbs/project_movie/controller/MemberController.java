package com.itwillbs.project_movie.controller;
// 250119
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Date; // SQL 날짜 타입
import java.time.LocalDate; // 날짜 처리 (ISO 표준)
import java.time.format.DateTimeParseException; // 날짜 형식 검증 예외 처리


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

//import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.service.MailService;
import com.itwillbs.project_movie.service.MemberService;
import com.itwillbs.project_movie.vo.EmailAuthVO; //*****수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
import com.itwillbs.project_movie.vo.MemberVO;


//폰 인증 api관련 
import com.itwillbs.project_movie.service.SmsService;
//import org.springframework.web.bind.annotation.*;
import java.util.Random;

//장민기
@Controller
public class MemberController {
   @Autowired
   private MemberService memberService;
   @Autowired
   private MailService mailService;
   @Autowired
    private SmsService smsService;
   
   // 회원 가입 폼 뷰페이지 포워딩 처리(MemberJoin - GET)
   // 연결된 뷰: member/member_join_form.jsp
   
   @GetMapping("MemberAgree")
   public String memberAgreeForm() {
      
      return "member/member_agree_form";
   }
   
   @PostMapping("MemberAgree")
   public String memberAgree() {
      
      return "redirect:/MemberJoin";
   }
   
   /*
   @PostMapping("MemberAgree")
   public String memberAgree(MemberVO member, Model model, BCryptPasswordEncoder passwordEncoder) {
        // 약관 동의 여부 확인
        if (!member.isTermsAgree() || !member.isPrivacyAgree()) {
            model.addAttribute("errorMsg", "모든 약관에 동의해야 합니다.");
            return "member/member_agree_form";
        }

        // 비밀번호 암호화
        String securedPasswd = passwordEncoder.encode(member.getMember_passwd());
        member.setMember_passwd(securedPasswd);

        int insertCount = 0;
        try {
            insertCount = memberService.registMember(member);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (insertCount > 0) {
            EmailAuthVO emailAuthVO = mailService.sendAuthMail(member);
            memberService.registMailAuthInfo(emailAuthVO);
            return "redirect:/MemberJoinSuccess"; // 연결된 뷰: member/member_join_success.jsp
        } else {
            model.addAttribute("msg", "회원가입 실패!");
            return "result/fail"; // 연결된 뷰: result/fail.jsp
        }
   }
   */
   
   @GetMapping("MemberJoin")
   public String memberJoinForm() {
      return "member/member_join_form";
   }
   
   // 회원 가입 비즈니스 로직 처리(MemberJoin - POST)
   // 연결된 서비스: registMember(), sendAuthMail(), registMailAuthInfo()
   @PostMapping("MemberJoin")
   public String memberJoin(MemberVO member, Model model, BCryptPasswordEncoder passwordEncoder) {
      
      //***** 수정전: passwd ----> 수정후: member_passwd *****
      String securedPasswd = passwordEncoder.encode(member.getMember_passwd());
      System.out.println("평문 : " + member.getMember_passwd());
      System.out.println("암호문 : " + securedPasswd);
      member.setMember_passwd(securedPasswd);

       // 전화번호 검증 및 NULL 방지
      /*
       if (member.getPhone() == null || member.getPhone().trim().isEmpty()) {
          System.out.println("c118) 서버에서 수신한 전화번호: " + member.getPhone());
           model.addAttribute("msg", "c119)전화번호를 입력하세요.");
           return "result/process";
       }      
       */
       
       // ***** 디버깅 코드 - 최종 SQL 데이터 확인 (DB 저장 직전) *****
       System.out.println("최종 저장 SQL 데이터 - 생년월일: " + member.getBirth_date());
       System.out.println("최종 저장 SQL 데이터 - 전화번호: " + member.getPhone());   
      
      
   int insertCount = 0;
    
    try {
       insertCount = memberService.registMember(member);
       
    } catch (Exception e) {
       e.printStackTrace();
       model.addAttribute("msg", "c134)서버 오류가 발생했습니다.");
       return "result/process";
    }
    
    // ***** 디버깅 코드 - 저장 결과 확인 (DB 저장 후) *****
    System.out.println("DB 저장 완료 여부: " + (insertCount > 0 ? "성공" : "실패"));
    
    // -------------------------------------------------------------
    // 회원가입 결과 판별하여 포워딩 처리
    // => 성공 시 : MemberJoinSuccess 서블릿 주소 리다이렉트
    // => 실패 시 : result/fail.jsp 페이지 포워딩
    if(insertCount > 0) {
      //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
      EmailAuthVO emailAuthVO = mailService.sendAuthMail(member);
      mailService.registMailAuthInfo(emailAuthVO);
      System.out.println("c149)인증메일 정보 :" + emailAuthVO );
      
      mailService.registMailAuthInfo(emailAuthVO);
      return "redirect:/";
   } else {
       // fail.jsp 페이지에서 출력할 메세지("회원가입 실패!")를 Model 객체에 저장(속성명 msg)
       model.addAttribute("msg", "c155) 회원가입 실패!");
       return "result/process";
    }
    
 }
   
   
   /* 팝업으로 전환
    
   // 회원 가입 성공 페이지 포워딩(MemberJoinSuccess - GET)
   // 연결된 뷰: member/member_join_success.jsp
   @GetMapping("MemberJoinSuccess")
   public String memberJoinSuccess() {
      return "member/member_join_success";
   }
   */
   
   
   
   
   
   // 아이디 및 비밀번호 찾기 폼 페이지 포워딩(MemberFindForm - GET)
  
   /*
   @GetMapping("MemberFindId")
   public String memberFindIdForm() {
       return "member/member_find_form"; // 뷰: member_find_form.jsp
   }
   
   @PostMapping("MemberFindId")
   public String memberFindId(MemberVO member, Model model) {
       String name = member.getMember_name();
       Date birthDate = member.getBirth_date(); // String 타입
       String email = member.getEmail();

       String memberId = memberService.findMemberId(name, birthDate, email);

       if (memberId != null) {
           model.addAttribute("memberId", memberId);
           System.out.println(name + birthDate + email);
       } else {
           model.addAttribute("errorMsg", "입력한 정보로 등록된 계정이 없습니다.");
       }

       return "member/member_find_form";
   }
   */
   
   // --------------------------------------------------------------------------- 아이디 찾기 시작
  
   
   @GetMapping("MemberFind")
   public String memberFindIdForm() {
       return "member/member_find_form";
   }  
   
   @PostMapping("MemberFind")
   public String memberFindId(MemberVO member, Model model) {
       String member_name = member.getMember_name();
       Date birth_date = member.getBirth_date(); // String 타입
       String email = member.getEmail();

       String member_id = memberService.findMemberId(member_name, birth_date, email);
       
       
       System.out.println("0) member_id: " + member_id);
       System.out.println("0) errorMsg: " + (member_id == null ? "입력한 정보로 등록된 계정이 없습니다." : ""));
       
       
       
       if (member_id != null) {
    	   System.out.println("찾는 아이디는 " + member_id);
           model.addAttribute("member_id", member_id);
           System.out.println("===============================");
           System.out.println(member_name +" " + birth_date +" "+ email);
           
       } else {
           model.addAttribute("errorMsg", "입력한 정보로 등록된 계정이 없습니다.");
       }

       return "member/member_find_form";
   }   
   
   
   
   
  // -------------------------------------------------------------------------비밀번호찾기 시작
   
   @GetMapping("MemberFindPasswd")
   
   public String memberFindPasswdForm() {
	   
       return "member/member_find_passwd_form"; // 뷰: member_find_form.jsp
   }
   
   
  
   
   
   @PostMapping("MemberFindPasswd")
   public String memberFindPasswd(MemberVO member, Model model) {
       // 입력받은 정보 추출
       String member_name = member.getMember_name();
       Date birth_date = member.getBirth_date();
       String email = member.getEmail();

       // 1. 입력된 정보로 회원 인증
       email = memberService.findMemberPasswd(member_name, birth_date, email); // 인증용 서비스 호출
       System.out.println("비밀번호를 찾기위해 입력한 이메일이 인증됐고 " + email +" 인증된 이메일 주소");
       
       
       
       
       if ( email == null) {
           // 인증 실패
           model.addAttribute("errorMsg", "입력한 정보와 일치하는 계정이 없습니다.");
           return "member/member_find_passwd_form";
       }

       // 2. 인증 성공 시, 임시 비밀번호 생성 및 이메일 전송
       boolean isTemporaryPasswordSent = mailService.sendTemporaryPassword(member,email);
       if (!isTemporaryPasswordSent) {
           // 임시 비밀번호 생성 또는 이메일 전송 실패
           model.addAttribute("errorMsg", "임시 비밀번호 발급 중 오류가 발생했습니다. 관리자에게 문의하세요.");
           return "member/member_find_passwd_form";
       }

       // 3. 성공 메시지 전달
       System.out.println("임시 비밀번호가 이메일로 발송되었습니다. 이메일을 확인하세요.");
       
       model.addAttribute("email",email);
       return "member/member_find_passwd_form";
     
   }
  
   /*
   int updateCount = memberService.modifyMembcer(map);
   if(updateCount > 0) { // 성공
       return "redirect:/MemberInfo";
   } else { // 실패
       model.addAttribute("msg", "회원정보 수정 실패!");
       return "result/process";
   }
   */
   
   
   
      
   // 회원 로그인 폼 페이지 포워딩(MemberLogin - GET)
   // 연결된 뷰: member/member_login_form.jsp
//   @GetMapping("MemberLogin")
//   public String memberloginForm() {
//      
//      return "member/member_login_form";
//   }
//   
   
   
   // 240105 1900i ######################################################## 로그인 + 쿠키로 아이디 저장
   // 추가: 쿠키값을 읽어 로그인 폼에 전달
   @GetMapping("MemberLogin")
   public String memberLoginForm(@CookieValue(value = "rememberId", required = false)
      String rememberId, Model model) {
       // 쿠키에서 아이디 값을 가져와 모델에 저장 (자동 입력 처리)
       model.addAttribute("rememberId", rememberId);
       return "member/member_login_form"; // 로그인 폼으로 이동
   }

   
   
   // 회원 로그인 비즈니스 로직 처리(MemberLogin - POST)
   // 연결된 서비스: getMember()
   @PostMapping("MemberLogin")
   public String memberLogin(
         MemberVO member,
         String rememberId,
         HttpSession session,Model model,
         BCryptPasswordEncoder passwordEncoder,
         HttpServletResponse response) {
   
   // MemberService - loginMember() 메서드 호출하여 로그인 여부 판별 요청
   // => 파라미터 : MemberVO 객체   리턴타입 : String(조회 성공 시 아이디 리턴)
   //            String result = service.loginMember(member);
   //            System.out.println("로그인 판별 결과 : " + result);
   // ==========================================================================
   // [ BCryptPasswordEncoder 클래스를 활용하여 패스워드 비교 ]
   // MemberService - getMember() 메서드 호출하여 암호화 된 패스워드 조회
   //    (회원 상세정보 조회 재사용)
   //    => 파라미터 : 아이디   리턴타입 : MemberVO(dbMember)
   //    => 기존 MemberVO 객체에 덮어써도 되지만, 기존 패스워드를 유지하여 비교하기 위해 별도의 변수 선언
      
      
      //***** 수정전: passwd ----> 수정후: member_passwd *****
      MemberVO dbMember = memberService.getMember(member.getMember_id());
      
      /*
       * [ BCryptPasswordEncoder 객체를 활용한 패스워드 비교 ]
       * - 입력받은 패스워드(= 평문)와 DB에 저장된 패스워드(= 암호문) 간의 
       *   직접적인 문자열 비교 시 무조건 두 문자열은 다름
       * - 일반적인 해싱의 경우 새 패스워드도 해싱을 통해 암호문으로 변환하여 비교하면 되지만
       *   현재, BCryptPasswordEncoder 객체를 통해 기존 패스워드를 암호화했기 때문에
       *   솔팅값에 의해 두 암호는 서로 다른 문자열이 되어 
       *   DB 에서 WHERE 절로 두 패스워드 비교 또는 String 클래스의 equals() 로 비교가 불가능하다!
       * - BCryptPasswordEncoder 객체의 matches() 메서드를 활용하여 비교 필수!
       *   (내부적으로 암호문으로부터 솔팅값을 추출하여 평문을 암호화하여 암호문끼리 비교)
       * 
       * < 기본 문법 >
       * 객체명.matches(평문, 암호문) 호출 시 boolean 타입 결과 리턴
       * ------------------------------------------------------------------------
       * 검색 아이디가 존재하지 않을 경우 리턴되는 결과값 : null
       * => MemberVO 객체(dbMember)가 null 일 경우(= 아이디 없음) 또는 
       *    패스워드 일치하지 않을 경우(matches() 메서드 리턴값 false)
       *    "result/fail.jsp" 페이지 포워딩(전달 메세지 : "로그인 실패!")
       */
      // 로그인을 위한 회원 상세정보 조회했을 때 처리 작업
      // 1) 로그인 실패(아이디 또는 패스워드 틀렸을 경우) 판별
      // 2) 로그인 불가능한 회원 상태(휴면(생략) or 탈퇴) 판별
      // 3) 위의 모든 조건이 false 일 경우 로그인 성공 처리
      
      
      if(dbMember == null || !passwordEncoder.matches(member.getMember_passwd(), dbMember.getMember_passwd())) {
         model.addAttribute("msg", "로그인 실패!");
         return "result/process"; // 연결된 뷰: result/fail.jsp
         
      } else if(dbMember.getMember_status() == 3) {
         model.addAttribute("msg", "탈퇴한 회원입니다!");
         return "result/process"; // 연결된 뷰: result/fail.jsp
      
//      } else if(dbMember.getEmail_auth_status().equals("N")) { 
         //***** 수정전: mail_auth_status ----> 수정후: email_auth_status *****
         
      }else if(!dbMember.isEmail_auth_status()) {
         //db가 bollean 타입으로 바뀜. 추가 수정 ***************************************************
         
            model.addAttribute("msg", "이메일 인증 후 로그인 가능합니다!");
         return "result/process"; // 연결된 뷰: result/fail.jsp

         
         
//         =================================================================================
//         이름관련  오류가 생겨 gpt의견 듣고 수정한 부분 바로 아래 ********
//         =================================================================================

         
//      } else if(!dbMember.isEmail_auth_status()) { 
//         //***** 수정전: getEmail_auth_status() ----> 수정후: isEmail_auth_status() *****
//         model.addAttribute("msg", "이메일 인증 후 로그인 가능합니다!");
//          return "result/fail"; // 연결된 뷰: result/fail.jsp
            
         
      } else {
         //***** 수정전: sId ----> 수정후: sMemberId *****
         session.setAttribute("sMemberId", member.getMember_id());
         session.setMaxInactiveInterval(1800*10); // 1800초 = 30분 (기본값이므로 생략 가능) X10 
         
         // **************************************************************************************************250103
                  // [ 로그인 폼에서 "아이디 기억하기" 항목 체크박스에 대한 쿠키 처리 ]
                  System.out.println("아이디 저장하기 체크박스값 : " + rememberId);
                  // 파라미터로 전달받은 "rememberId" 값 null 여부 판별
//                  if(rememberId != null) { // 변수값이 null 이 아닐 때(= 아이디 기억하기 체크박스 체크)
//                     // 1. javax.servlet.http.Cookie 타입 객체 생성
//                     // => 파라미터 : 쿠키명("rememberId"), 쿠키값(로그인에 성공한 아이디)
//                     Cookie cookie = new Cookie("rememberId", member.getId());
//                     
//                      // 2. 쿠키 유효기간(만료기간) 설정(초 단위)
//                     // => Cookie 객체의 setMaxAge() 메서드 활용
//                     cookie.setMaxAge(60 * 60 * 24 * 30); // 30일 = (60초 * 60분 * 24시간 * 30일)
//                     
//                     // 3. 클라이언트측으로 쿠키 정보를 전송하기 위해서
//                     // 응답 정보를 관리하는 HttpServletResponse 객체의 addCookie() 메서드를 호출하여
//                     // 응답 정보에 쿠키 정보 추가
//                     // => memberLogin() 메서드 선언부에 HttpServletResponse 객체 자동 주입 필요
//                     response.addCookie(cookie);
//                  } else { // 변수값이 null 일 때(= 아이디 기억하기 체크박스 체크해제(미체크))
//                     // 기존 쿠키 중 "rememberId" 라는 이름의 쿠키 삭제
//                     // => 쿠키는 삭제의 개념을 MaxAge 값(만료시간)을 0 으로 설정 후 전송하여 처리
//                     // => 이 때, 쿠키 이름은 반드시 삭제해야할 쿠키의 이름을 정확하게 설정
//                     //    (저장되는 쿠키값은 상관없음 = null 값 또는 아무값이나 가능)
//                     Cookie cookie = new Cookie("rememberId", null); // 아무값이나 전달 가능
//                     
//                     // 쿠키의 유효기간을 반드시 0 으로 설정
//                     // => 이 쿠키를 수신한 클라이언트는 해당 쿠키를 즉시 삭제
//                     //    (이 때, 동일한 이름의 쿠키를 원래 가지고 있었을 경우 해당 쿠키가 삭제됨)
//                     cookie.setMaxAge(0);
//                     
//                     // 응답 데이터에 쿠키 포함시키기
//                     response.addCookie(cookie);
//                  }
                  
                  // --------- 쿠키 생성 코드 중복 제거 ----------
                  // 생성/삭제 관계없이 쿠키값을 무조건 로그인 한 아이디로 설정
                  Cookie cookie = new Cookie("rememberId", member.getMember_id()); //getId())에서 수정
                  
                  // 쿠키 만료기간은 저장 시 30일, 삭제 시 0 으로 설정
                  if(rememberId != null) {
                     cookie.setMaxAge(60 * 60 * 24 * 30);
                  } else {
                     cookie.setMaxAge(0);
                  }
                  
                  response.addCookie(cookie);
                  
                  // ---------------------------------------------------------------------------
                  // 메인페이지로 리다이렉트
         
         return "redirect:/"; // 연결된 뷰: main.jsp
      } //else
   } //memberLogin
   

   // 회원 로그아웃 처리(MemberLogout - GET)
   // 뷰 포워딩 없음, 메인페이지로 리다이렉트
   @GetMapping("MemberLogout")
   public String memberLogout(HttpSession session) {
      //***** 수정전: sId ----> 수정후: sMemberId *****
      session.invalidate();
      return "redirect:/"; // 연결된 뷰: main.jsp
   }

   // 회원 상세정보 조회(MemberInfo - GET)
   // 연결된 서비스: getMember()
   @GetMapping("MemberInfo")
   public String memberInfo(HttpSession session, Model model) {
      //***** 수정전: sId ----> 수정후: sMemberId *****
      String id = (String)session.getAttribute("sMemberId");
      if(id == null) {
         model.addAttribute("msg", "접근 권한이 없습니다!");
         model.addAttribute("targetURL", "MemberLogin");
         return "result/process"; // 연결된 뷰: result/fail.jsp
      }
      MemberVO member = memberService.getMember(id);
      model.addAttribute("member", member);
      return "member/member_info"; // 연결된 뷰: member/member_info.jsp
      
      
   }
   

   // 240105 1900i ####################
   // 회원 정보 수정 폼 - GET
   @GetMapping("MemberModify")
   public String memberModifyForm(HttpSession session, Model model) {
       String id = (String)session.getAttribute("sMemberId");
       if(id == null) {
           model.addAttribute("msg", "로그인 필수!");
           model.addAttribute("targetURL", "MemberLogin");
           return "result/process";
       }
       // 회원 정보 조회
       MemberVO member = memberService.getMember(id);
       model.addAttribute("member", member);
       return "member/member_modify_form"; // 수정 폼 페이지 이동
   }

   
   // 240105 1900i ####################
   //---------------------------------------------------------------------------------------- 회원 정보 수정 처리 - POST
   @PostMapping("MemberModify")
   public String memberModify(
       @RequestParam Map<String, String> map, 
       String hobby,
       BCryptPasswordEncoder passwordEncoder,
       HttpSession session, Model model) {

       // 로그인 여부 확인
       String id = (String)session.getAttribute("sMemberId");
       if(id == null) {
           model.addAttribute("msg", "접근 권한이 없습니다!");
           model.addAttribute("targetURL", "MemberLogin");
           return "result/process";
       }
       
       
       // 비밀번호 검증
       MemberVO dbMember = memberService.getMember(id);
       if(dbMember == null || !passwordEncoder.matches(map.get("oldPasswd"), dbMember.getMember_passwd())) {
           model.addAttribute("msg", "수정 권한이 없습니다!");
           return "result/process";
       }

       // 새 비밀번호 암호화 처리
       if(!map.get("passwd").isEmpty()) {
           map.put("passwd", passwordEncoder.encode(map.get("passwd")));
       }

       // 회원 정보 수정 요청
       int updateCount = memberService.modifyMember(map);
       if(updateCount > 0) { // 성공
           return "redirect:/MemberInfo";
       } else { // 실패
           model.addAttribute("msg", "회원정보 수정 실패!");
           return "result/process";
       }
   }

   
   
   
   // 250105
   
//   휴대폰번호 인증 api   *************************************************************
   
   // 인증번호 전송
   @PostMapping("sendAuthCode")
   @ResponseBody
   public Map<String, String> sendAuthCode(@RequestParam("phone") String phone, HttpSession session) {
       // 전화번호 형식 검증 (추가된 코드)
       if (phone == null || !phone.matches("^\\d{10,11}$")) {
           return Map.of("status", "fail", "message", "전화번호 형식이 올바르지 않습니다.");
       }

       // 인증번호 생성
       String authCode = String.format("%04d", new Random().nextInt(10000)); 
       boolean isSent = smsService.sendSms(phone, "인증번호: " + authCode); 

       if (isSent) {
           session.setAttribute("smsAuthCode", authCode); // 인증번호 세션 저장
           session.setMaxInactiveInterval(300); // 세션 유지 시간 설정 (5분, 추가된 코드)
           return Map.of("status", "success", "message", "인증번호가 발송되었습니다.");
       } else {
           return Map.of("status", "fail", "message", "인증번호 전송에 실패했습니다.");
       }
   }



   @PostMapping("verifyAuthCode")
   @ResponseBody
   public Map<String, String> verifyAuthCode(@RequestParam("code") String code, HttpSession session) {
       String storedCode = (String) session.getAttribute("smsAuthCode");

       if (storedCode != null && storedCode.equals(code)) {
           session.removeAttribute("smsAuthCode"); // 인증 성공 시 세션에서 인증번호 제거 (추가된 코드)
           return Map.of("status", "success");
       } else {
           return Map.of("status", "fail", "message", "인증번호가 일치하지 않습니다.");
       }
   }


//   ======================================================================================= 이메일인증
   
   
   @GetMapping("MemberEmailAuth")
   public String memberEmailAuth(
           @RequestParam("email") String email,
           @RequestParam("auth_code") String authCode,
           Model model) {

       EmailAuthVO emailAuthVO = new EmailAuthVO(email, authCode);
       System.out.println("emailAuthVO : " + emailAuthVO);

       boolean isAuthSuccess = mailService.requestEmailAuth(emailAuthVO);

       if (!isAuthSuccess) {
           model.addAttribute("msg", "메일 인증 실패! 코드 불일치 또는 만료.");
           return "result/process";
       } else {
           model.addAttribute("msg", "메일 인증 성공!\\n로그인 페이지로 이동합니다.");
           model.addAttribute("targetURL", "MemberLogin");
           return "result/process";
       }
   }

   
   
   @GetMapping("MemberWithdraw")
   public String memberWithdrawForm(HttpSession session, Model model) {
       // 로그인 여부 확인
       String id = (String)session.getAttribute("sMemberId");
       if(id == null) {
           model.addAttribute("msg", "로그인 필수!\\n로그인 페이지로 이동합니다.");
           model.addAttribute("targetURL", "MemberLogin");
           return "result/process";
       }
       return "member/member_withdraw_form"; // 탈퇴 폼 페이지로 이동
   }
   
   
   
   // 회원 탈퇴 처리 - POST
   @PostMapping("MemberWithdraw")
   public String memberWithdraw(String passwd, BCryptPasswordEncoder passwordEncoder, HttpSession session, Model model) {
       // 세션에서 로그인 아이디 확인
       String id = (String)session.getAttribute("sMemberId");

       // DB에서 패스워드 조회
       String dbPasswd = memberService.getMemberPasswd(id);

       // 패스워드 검증
       if(dbPasswd == null || !passwordEncoder.matches(passwd, dbPasswd)) {
           model.addAttribute("msg", "비밀번호가 일치하지 않습니다!");
           return "result/process"; // 실패 페이지 이동
       }

       // 탈퇴 처리
       int withdrawResult = memberService.withdrawMember(id);
       if(withdrawResult > 0) { // 성공
           session.invalidate(); // 세션 초기화
           model.addAttribute("msg", "탈퇴 처리가 완료되었습니다.");
           model.addAttribute("targetURL", "./");
           return "result/success"; // 성공 페이지 이동
       } else { // 실패
           model.addAttribute("msg", "탈퇴 실패!\\n관리자에게 문의 바랍니다.");
           return "result/process"; // 실패 페이지 이동
       }
   }
   
   
   

   
   
   
   
}
