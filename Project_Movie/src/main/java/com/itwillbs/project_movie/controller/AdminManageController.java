package com.itwillbs.project_movie.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.handler.AdminMenuAccessHandler;
import com.itwillbs.project_movie.handler.PagingHandler;
import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.service.MemberService;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.GetGiveCouponInfoVO;
import com.itwillbs.project_movie.vo.MemberAllInfoVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.PageInfo;
import com.itwillbs.project_movie.vo.PageInfo2;
import com.itwillbs.project_movie.vo.PointVO;

import lombok.Builder.Default;

@Controller
public class AdminManageController {
	@Autowired
	private AdminManageService adminService;
	
	@Autowired
	private PagingHandler pagingHandler;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("AdminLogin") 
	// 관리자 계정 로그인 폼 이동
	// 세션 admin_sId가 있을 시 바로 접속, 그렇지 않을 경우 관리자 로그인 페이지 이동
	public String adminLogigForm(HttpSession session) {
		System.out.println("관리자 로그인 세션 : " + session.getAttribute("admin_sId"));  

		if(session.getAttribute("admin_sId") == null) {
			return "adminpage/admin_manage/adminpage_login_form";
		} else {
			return "redirect:/AdminpageMain";
		}
	}
	
	@PostMapping("AdminLogin") // 관리자 로그인 폼 제출
	public String adminLogin(AdminRegisVO adminLoginInfo, HttpSession session, Model model) {
		System.out.println("입력한 아이디 : " + adminLoginInfo.getAdmin_id());
		System.out.println("입력한 비밀번호" + adminLoginInfo.getAdmin_passwd());
		AdminRegisVO adminInfo = adminService.adminLogin(adminLoginInfo);
		
		if(adminInfo == null) {
			model.addAttribute("msg", "로그인 정보가 일치하지 않습니다.");
			return "result/process";
		} else {
			session.setAttribute("admin_sId", adminInfo.getAdmin_id());
			session.setMaxInactiveInterval(600);
			return "redirect:/AdminpageMain";
		}
	}
	
	@GetMapping("AdminLogout") // 관리자 로그아웃 -> ajax로 리턴
	public Boolean adminLogout(HttpSession session) {
		System.out.println("로그아웃 컨트롤러 호출됨");
		session.invalidate();
		
		return true;
	}
	
	@GetMapping("AdminAccountManage") // 관리자 계정관리 페이지 이동
	public String adminAccountManagement(@RequestParam(defaultValue = "1") int pageNum, 
			Model model, HttpSession session) {
		
		// 관리자 로그인 판별
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("member_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "adminList");		
		
		List<AdminRegisVO> voList = adminService.queryAdminList(pageInfo.getStartRow(), pageInfo.getListLimit());
		
//		Map<String, Object> pagingMap = pagingHandler.pagingProcess(pageNum, "adminList");
//		PageInfo pageInfo = (PageInfo)pagingMap.get("pageInfo");
//		List<AdminRegisVO> voList = (List<AdminRegisVO>)pagingMap.get("voList");
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("voList", voList);
		
		return "adminpage/admin_manage/adminpage_account_manage";
	}	

	@GetMapping("AdminAccountRegis") // 관리자 계정 생성 폼으로 이동
	public String adminAccountRegistration() {
		return "adminpage/admin_manage/adminpage_account_regis";
	}
	
	@PostMapping("AdminAccountRegis") // 관리자 계정 생성 처리
	public String adminAccountCreate(AdminRegisVO adminVo) {
		int insertCount = adminService.createAccount(adminVo);
		System.out.println("관리자 계정 등록 완료 : " + insertCount);
		return "redirect:/AdminAccountManage";
	}
	
	@GetMapping("AdminIdCheck") // 아이디 중복체크 ajax 응답
	@ResponseBody // 리턴문을 포워딩이 아닌 원하는 데이터로 전달하기 위한 어노테이션
	public Map<String, String> adminIdCheck(String id) {
		String checkId = adminService.checkAdminId(id);
		Map<String, String> map = new HashMap<String, String>();
		map.put("checkIdResult", checkId);
		return map;
	}
	
	@GetMapping("DeleteAdminAccount") // 관리자 계정 삭제
	public String adminAccountDelete(@RequestParam("admin_id") String[] admin_id, Model model) {
		int  deleteCount = 0;
		
		for (String id : admin_id) {
			adminService.deleteAdminAccount(id);
			deleteCount++;
		}
		
		if(deleteCount > 0) {		
			return "redirect:/AdminAccountManage";
		} else {
			return "";
		}
	}
	
	@GetMapping("AdminPageIdSearch") // 아이디 조회 버튼
	public String idSearch() {
		return "adminpage/id_search";
	}
	
	@GetMapping("AdminAccountModify") // 관리자 계정 수정
	public String adminAccountModifyForm(String admin_id, Model model) {
		System.out.println("계정 수정 페이지 요청됨!! + " + admin_id);
		
		AdminRegisVO modifyVo = adminService.accountModifyForm(admin_id);
		model.addAttribute("voList", modifyVo);
		
		return "adminpage/admin_manage/adminpage_account_modifyForm";
	}
	
	@PostMapping("AdminAccountModify") // 관리자 계정 수정폼 전송
	public String adminAccountModify(AdminRegisVO modifyVo) {
		System.out.println("수정 폼 전송 완료 : " + modifyVo);
		adminService.accountModify(modifyVo);
		
		return "redirect:/AdminAccountManage";
	}
	
	@GetMapping("MemberList") // 회원 리스트 조회
	public String memberList(@RequestParam(defaultValue = "1") int pageNum, 
			HttpSession session, Model model, 
			@RequestParam(defaultValue = "") String searchKeyword, 
			@RequestParam(defaultValue = "") String searchContent) {
		
		// 관리자 로그인 판별
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("member_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}

		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "memberList", searchKeyword, searchContent);
		List<MemberAllInfoVO> voList = adminService.queryMemberList(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("voList", voList);
		
		return "adminpage/member_manage/member_list";
	}
	
	// 마이페이지 회원 정보란 이동
	@GetMapping("ShowMyInfo")
	public String showMyInfo(HttpSession session, Model model) {
		String sMemberId = (String) session.getAttribute("sMemberId");
		System.out.println("회원정보 로그인 세션 아이디 : " + sMemberId);
		if(sMemberId == null) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		MemberVO member = adminService.getMyInfo(sMemberId);
		System.out.println("member에 저장된 값 : " + member);
		String gender =  Character.toString(member.getGender()); // char 타입이라 jstl에서 비교 안되어 별도 전달

		model.addAttribute("member", member);
		model.addAttribute("gender", gender);
		return "mypage/myprofile/myprofile_correction";
	}
	
	// 마이페이지 회원정보 수정 폼 제출 시
	@GetMapping("UpdateMyInfo")
	public String updateMyInfo(MemberVO member, BCryptPasswordEncoder passwordEncoder, Model model) {
//		System.out.println("변경할 회원 정보 : " + member);
	      String securedPasswd = passwordEncoder.encode(member.getMember_passwd());
//	      System.out.println("비밀번호 : " + member.getMember_passwd());
//	      System.out.println("암호화 : " + securedPasswd);
	      member.setMember_passwd(securedPasswd);
//	      System.out.println("암호화 후 정보 : " + member);
	      
	      int updateCount = adminService.updateMyInfo(member); 
	      
	      if(updateCount > 0) {
	    	  return "redirect:/MypageMain";
	      }	else {
				model.addAttribute("msg", "회원정보 수정 실패");
				model.addAttribute("targetURL", "MypageMain");
				return "result/process";
	      }
	}
	
	// 회원정보 변경 비밀번호 확인 ajax
	@GetMapping("checkOldPasswd")
	@ResponseBody
	public Boolean checkOldPasswd(String passwd, String member_id, BCryptPasswordEncoder passwordEncoder) {
//		System.out.println("비밀번호 체크 컨트롤러 호출 : " + passwd + " " + member_id);
		 String dbPasswd = adminService.getDbPasswd(member_id);
//		 System.out.println("DB 비번 : " + dbPasswd);
		 System.out.println("일치여부 확인 : " + (passwordEncoder.matches(passwd, dbPasswd)));
		 
		 if(passwordEncoder.matches(passwd, dbPasswd)) {
			 return true;
		 } else {
			 return false;
		 }
	}
}

