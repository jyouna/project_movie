package com.itwillbs.project_movie.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_movie.service.MailService;
import com.itwillbs.project_movie.service.MemberService;
import com.itwillbs.project_movie.vo.EmailAuthVO; //*****수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
import com.itwillbs.project_movie.vo.MemberVO;
//민기
@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private MailService mailService;
	
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
		member.setMember_passwd(securedPasswd);

		int insertCount = 0;
		try {
			insertCount = memberService.registMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(insertCount > 0) {
			//***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
			EmailAuthVO emailAuthVO = mailService.sendAuthMail(member);
			memberService.registMailAuthInfo(emailAuthVO);
			return "redirect:/"; // 연결된 뷰: main
		} else {
			model.addAttribute("msg", "회원가입 실패!");
			return "result/fail"; // 연결된 뷰: result/fail.jsp
		}
	}
	
	/*
	// 회원 가입 성공 페이지 포워딩(MemberJoinSuccess - GET)
	// 연결된 뷰: member/member_join_success.jsp
	@GetMapping("MemberJoinSuccess")
	public String memberJoinSuccess() {
		return "member/member_join_success";
	}
	*/
	
	
	// 회원 로그인 폼 페이지 포워딩(MemberLogin - GET)
	// 연결된 뷰: member/member_login_form.jsp
	@GetMapping("MemberLogin")
	public String memberloginForm() {
		return "member/member_login_form";
	}
	
	// 아이디 및 비밀번호 찾기 폼 페이지 포워딩(MemberFindForm - GET)
	@GetMapping("MemberFindForm")
	public String memberFindForm() {
	    return "member/member_find_form"; // 뷰: member_find_form.jsp
	}

	
	/*
	// 회원 로그인 비즈니스 로직 처리(MemberLogin - POST)
	// 연결된 서비스: getMember()
	@PostMapping("MemberLogin")
	public String memberLogin(MemberVO member, HttpSession session, Model model, BCryptPasswordEncoder passwordEncoder) {
		//***** 수정전: passwd ----> 수정후: member_passwd *****
		MemberVO dbMember = memberService.getMember(member.getMember_id());

		if(dbMember == null || !passwordEncoder.matches(member.getMember_passwd(), dbMember.getMember_passwd())) {
			model.addAttribute("msg", "로그인 실패!");
			return "result/fail"; // 연결된 뷰: result/fail.jsp
		} else if(dbMember.getMember_status() == 3) {
			model.addAttribute("msg", "탈퇴한 회원입니다!");
			return "result/fail"; // 연결된 뷰: result/fail.jsp
		/*	
		} else if(dbMember.getEmail_auth_status() == 0) { //***** 수정전: mail_auth_status ----> 수정후: email_auth_status *****
			model.addAttribute("msg", "이메일 인증 후 로그인 가능합니다!");
			return "result/fail"; // 연결된 뷰: result/fail.jsp
	
			
			
			=================================================================================
			이름관련 오류가 생겨 gpt의견 듣고 수정한 부분 바로 아래 ********
			=================================================================================

	 
			
		} else if(!dbMember.isEmail_auth_status()) { 
			//***** 수정전: getEmail_auth_status() ----> 수정후: isEmail_auth_status() *****
			model.addAttribute("msg", "이메일 인증 후 로그인 가능합니다!");
		    return "result/fail"; // 연결된 뷰: result/fail.jsp
				
			
		} else {
			//***** 수정전: sId ----> 수정후: sMemberId *****
			session.setAttribute("sMemberId", member.getMember_id());
			return "redirect:/"; // 연결된 뷰: main.jsp
		}
	}
	
	*/

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
			return "result/fail"; // 연결된 뷰: result/fail.jsp
		}
		MemberVO member = memberService.getMember(id);
		model.addAttribute("member", member);
		return "member/member_info"; // 연결된 뷰: member/member_info.jsp
	}
}
