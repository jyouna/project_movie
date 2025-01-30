package com.itwillbs.project_movie.controller;
//장민기 20250128
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date; // SQL 날짜 타입
import java.time.LocalDate; // 날짜 처리 (ISO 표준)
import java.time.format.DateTimeParseException; // 날짜 형식 검증 예외 처리


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;  //가입시 아이디 중복 찾기
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


@Controller
public class MemberController {
   @Autowired
   private MemberService memberService;
   @Autowired
   private MailService mailService;
   @Autowired
    private SmsService smsService; 
   
   //---------------------------------------------------------------------------- 회원 가입 
   
   @GetMapping("MemberAgree")
   public String memberAgreeForm() {
      
      return "member/member_agree_form";
   }
   
   @PostMapping("MemberAgree")
   public String memberAgree(HttpSession session) {
	   
       // 약관 동의가 완료되면 세션에 동의 여부 저장
       session.setAttribute("termsAgreed", true);
       return "redirect:/MemberJoin";
   }
   
   @PostMapping("checkId")
   @ResponseBody
   public ResponseEntity<Boolean> checkId(@RequestParam("member_id") String member_id) {
       // Service 계층에서 중복 여부 확인
       boolean isDuplicate = memberService.isIdDuplicate(member_id);

       // 중복 여부를 JSON 형식으로 반환 (true: 중복, false: 사용 가능)
       return ResponseEntity.ok(isDuplicate);
   }
   

   
   
   
   @GetMapping("MemberJoin")
   public String memberJoinForm(HttpSession session, Model model) {
       // 세션에서 약관 동의 여부 확인
       Boolean termsAgreed = (Boolean) session.getAttribute("termsAgreed");

       // 동의하지 않은 경우, 약관 동의 페이지로 리다이렉트
       if (termsAgreed == null || !termsAgreed) {
    	   System.out.println("url강제이동 시도 /project_movie/MemberJoin");
    	   System.out.println("redirect:/MemberAgree 했습니다.");
           return "redirect:/MemberAgree";
       }

       // 동의한 경우, 회원가입 폼 페이지로 이동
       return "member/member_join_form";
   }
   
   
   // 회원 가입 
   @PostMapping("MemberJoin")
   public String memberJoin(
       MemberVO member, 
       Model model, 
       BCryptPasswordEncoder passwordEncoder, 
       HttpSession session // 세션 객체 추가
   ) {
       // 세션에서 약관 동의 여부 확인
       Boolean termsAgreed = (Boolean) session.getAttribute("termsAgreed");

       // 약관 동의를 하지 않은 경우, 약관 동의 페이지로 리다이렉트
       //사용자가 직접 post요청 하는것을 방지
       if (termsAgreed == null || !termsAgreed) {
           model.addAttribute("msg", "약관 동의가 필요합니다.");
           return "redirect:/MemberAgree";
       }

       // 비밀번호 암호화
       String securedPasswd = passwordEncoder.encode(member.getMember_passwd());
       System.out.println("평문 : " + member.getMember_passwd());
       System.out.println("암호문 : " + securedPasswd);
       member.setMember_passwd(securedPasswd);

       // 디버깅 코드 - 최종 SQL 데이터 확인 (DB 저장 직전)
       System.out.println("최종 저장 SQL 데이터 - 생년월일: " + member.getBirth_date());
       System.out.println("최종 저장 SQL 데이터 - 전화번호: " + member.getPhone());

       int insertCount = 0;

       try {
           insertCount = memberService.registMember(member);
       } catch (Exception e) {
           e.printStackTrace();
           model.addAttribute("msg", "오류가 발생했습니다. 다시 시도해주세요");
           return "result/process";
       }

       // 디버깅 코드 - 저장 결과 확인 (DB 저장 후)
       System.out.println("DB 저장 완료 여부: " + (insertCount > 0 ? "성공" : "실패"));

       // 회원가입 결과 판별하여 포워딩 처리
       if (insertCount > 0) {
           // 이메일 인증 메일 발송
           EmailAuthVO emailAuthVO = mailService.sendAuthMail(member);
           mailService.registMailAuthInfo(emailAuthVO);
           System.out.println("c143)인증메일 정보 :" + emailAuthVO);

           // 세션에서 약관 동의 여부 초기화 (중복 가입 방지)
           session.removeAttribute("termsAgreed");

           model.addAttribute("msg", "입력하신 주소로 메일을 전송했습니다.  \\n메일은 5분내로 전송됩니다. \\n인증을 완료하신 후 로그인해주세요.");
           model.addAttribute("targetURL", "MemberLogin");
           return "result/process";
       } else {
           model.addAttribute("msg", "회원가입에 실패했습니다. 재가입을 시도해주세요 \\n문제 재발시 관리자에게 문의해주세요!");
           return "result/process";
       }
   }
   

   
   // -------------------------------------------------------------------- 아이디 찾기 시작
  
   
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
   
   
   
   
  // -------------------------------------------------------------------------------비밀번호찾기 시작
   
   @GetMapping("MemberFindPasswd")
   
   public String memberFindPasswdForm() {
      
       return "member/member_find_passwd_form"; // 뷰: member_find_form.jsp
   }
   
   
  
   
   
   @PostMapping("MemberFindPasswd")
   public String memberFindPasswd(MemberVO member, Model model) {
       // 입력받은 정보 추출
      
      String member_id = member.getMember_id();
      String member_name = member.getMember_name();
       Date birth_date = member.getBirth_date();
       String email = member.getEmail();
       

       // 1. 입력된 정보로 회원 인증
       email = memberService.findMemberPasswd(member_id,member_name, birth_date, email); // 인증용 서비스 호출
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
           model.addAttribute("errorMsg", "가입을 다시 시도해주세요. 오류 재발생시 관리자에게 문의하세요.");
           return "member/member_find_passwd_form";
       }

       // 3. 성공 메시지 전달
       System.out.println("임시 비밀번호가 이메일로 발송됨 이메일을 확인하세요.");
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
   
   
   // ------------------------------------------------------------------ 로그인 + 쿠키로 아이디 저장
   // 추가: 쿠키값을 읽어 로그인 폼에 전달
   @GetMapping("MemberLogin")
   public String memberLoginForm(@CookieValue(value = "rememberId", required = false)
      String rememberId, Model model) {
       // 쿠키에서 아이디 값을 가져와 모델에 저장 (자동 입력 처리)
       model.addAttribute("rememberId", rememberId);
       return "member/member_login_form"; // 로그인 폼으로 이동
   }

   @PostMapping("MemberLogin")
   public String memberLogin(
         MemberVO member,
         String rememberId,
         HttpSession session,Model model,
         BCryptPasswordEncoder passwordEncoder,
         HttpServletResponse response) {
      
      
      //***** 수정전: passwd ----> 수정후: member_passwd *****
      MemberVO dbMember = memberService.getMember(member.getMember_id());
      
      
      if(dbMember == null || !passwordEncoder.matches(member.getMember_passwd(), dbMember.getMember_passwd())) {
         model.addAttribute("msg", "로그인 실패! 아이디 비밀번호를 다시 확인후 시도해주세요");
         return "result/process"; // 연결된 뷰: result/fail.jsp
         
      }
      // 회원 상태가 3인 경우 (비활성화된 회원)
      else if (dbMember.getMember_status() == 3) {
          model.addAttribute("msg", "이미 탈퇴한 회원입니다.");
          return "result/process"; // 연결된 뷰: result/fail.jsp
          
      }else if(!dbMember.isEmail_auth_status()) {
         //db가 bollean 타입으로 바뀜. 추가 수정 ******
         
            model.addAttribute("msg", "이메일 인증 후 로그인 가능합니다!");
         return "result/process"; // 연결된 뷰: result/fail.jsp

         
         
//         이름관련  오류가 생겨 gpt의견 듣고 수정한 부분 바로 아래 ********
       
//      } else if(!dbMember.isEmail_auth_status()) { 
//         //***** 수정전: getEmail_auth_status() ----> 수정후: isEmail_auth_status() *****
//         model.addAttribute("msg", "이메일 인증 후 로그인 가능합니다!");
//          return "result/fail"; // 연결된 뷰: result/fail.jsp
            
         
      } else {
         //***** 수정전: sId ----> 수정후: sMemberId *****
         session.setAttribute("sMemberId", member.getMember_id());
         session.setMaxInactiveInterval(1800*10); // 1800초 = 30분 (기본값이므로 생략 가능) X10 
         
                  // [ 로그인 폼에서 "아이디 기억하기" 항목 체크박스에 대한 쿠키 처리 ]
                  System.out.println("아이디 저장하기 체크박스값 : " + rememberId);
                  
                  
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
                           
         return "redirect:/"; // 연결된 뷰: main.jsp
      } //else
      
   } //memberLogin
   
   
 // --------------------------------------------------------------------------------------로그아웃  
   // 뷰 포워딩 x, 메인페이지로 리다이렉트
   @GetMapping("MemberLogout")
   public String memberLogout(HttpSession session) {
      //***** 수정전: sId ----> 수정후: sMemberId *****
      session.invalidate();
      return "redirect:/"; // 연결된 뷰: main.jsp
   }

   // 회원 상세정보 조회
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
   
   // 회원 정보 수정 폼 
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

   
   //회원 정보 수정 처리 
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

   
   
   
 
   
//   ----------------------------------------------------------------------------휴대폰번호 인증 api   
   
   // 인증번호 전송
   @PostMapping("sendAuthCode")
   @ResponseBody
   public Map<String, String> sendAuthCode(@RequestParam("phone") String phone, HttpSession session) {
       // 전화번호 형식 검증 (추가된 코드)
    //   if (phone == null || !phone.matches("^\\d{10,11}$")) {
    //       return Map.of("status", "fail", "message", "전화번호 형식이 올바르지 않습니다.");
    //   }

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


//   ========================================================================= 이메일인증
   
   
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
           model.addAttribute("msg", "메일 인증 성공! \\n로그인 페이지로 이동합니다.");
           model.addAttribute("targetURL", "MemberLogin");
           return "result/process";
       }
   }

 // ================================================================================ 
   
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
   
   
   
   // 회원 탈퇴 처리 
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
