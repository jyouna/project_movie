package com.itwillbs.project_movie.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.handler.AdminMenuAccessHandler;
import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.GetGiveCouponInfoVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.PageInfo;

@Controller
public class AdminSettingController {
	@Autowired
	private AdminManageService adminService;
	
	@GetMapping("AdminLogin") // 관리자 계정 로그인 폼 이동
	// 세션 admin_sId가 있을 시 바로 접속, 그렇지 않을 경우 관리자 로그인 페이지 이동
	public String adminLogigForm(HttpSession session) {
		System.out.println("관리자 로그인 세션 : " + session.getAttribute("admin_sId"));  
		
		if(session.getAttribute("admin_sId") == null) {
			return "adminpage/admin_manage/adminpage_login_form";
		} else {
			return "redirect:/AdminpageMain";
		}
	}
	
	@PostMapping("AdminLogin") // 관리자 로그인
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
	public String adminAccountManagement(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session) {
		
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
		
		int listLimit = 2;
		int startRow = (pageNum - 1) * listLimit;
		int listCount = adminService.getBoardListCount();
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		if(maxPage == 0) {
			maxPage = 1;
		}
		
		int startPage = (pageNum-1)/pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			return "";
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		System.out.println("페이지 정보 : " + pageInfo);
		List<AdminRegisVO> voList = new ArrayList<AdminRegisVO>();
		voList = adminService.queryAdminList(startRow, listLimit);
		model.addAttribute("voList", voList);
		model.addAttribute("pageInfo", pageInfo);
		
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
//		System.out.println("화면에서 받아온 값 : " + admin_id);
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
	public String memberList(HttpSession session, Model model) {
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
		return "adminpage/member_manage/member_list";
	}
	
	@GetMapping("StaticsVisitors") // 방문자 통계
	public String staticsVisitors(HttpSession session, Model model) {
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
		
		return "adminpage/statics_manage/statics_visitors";
	}

	@GetMapping("StaticsSales") // 매출 통계 
	public String staticsSales(HttpSession session, Model model) {
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
		return "adminpage/statics_manage/statics_sales";
	}
	
	@GetMapping("StaticsVoteResult") // 투표 결과(통계)
	public String staticsVoteResult(HttpSession session, Model model) {
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
		return "\"adminpage/statics_manage/statics_voteResult";
	}
	
	@GetMapping("StaticsNewMember") // 신규 가입자 통계
	public String staticsNewMembers(HttpSession session, Model model) {
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
		return "adminpage/statics_manage/statics_newMember";
	}
	
	@GetMapping("SpecificPeriodSearch") // 상세 기간 조회 버튼
	public String specificPeriodSearch() {
		return "adminpage/specific_period_search";
	}

	@GetMapping("CouponBoardManage") // 쿠폰 관리 페이지
	public String couponBoardManagement(HttpSession session, Model model) {
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("vote_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		return "adminpage/coupon_manage/coupon_board_manage";
	}
	
	@GetMapping("CouponBoardRegis") // 쿠폰 등록
	public String couponBoardRegistration() {
		
		return "adminpage/coupon_manage/coupon_board_regis";
	}

	@GetMapping("PointBoardManage") // 포인트 관리 페이지
	public String pointBoardManagement(HttpSession session, Model model) {
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("vote_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		return "adminpage/point_manage/point_board_manage";
	}
	
	@GetMapping("PointBoardRegis") // 포인트 등록
	public String pointBoardRegistration() {
		return "adminpage/point_manage/point_board_regis";
	}
	
	@GetMapping("EventBoardManage") // 이벤트 게시판 관리 + 리스트 출력
	public String eventBoardManagement(EventBoardVO eventVo, Model model, HttpSession session) {
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("vote_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		
		List<EventBoardVO> eventList = new ArrayList<EventBoardVO>();
		eventList = adminService.eventBoardList();
		model.addAttribute("eventVo", eventList);
		return "adminpage/event_manage/event_board_manage";
	}
	
	@GetMapping("EventBoardRegis") // 이벤트 게시글 등록폼
	public String eventBoardRegisForm() {
		return "adminpage/event_manage/event_board_regis";
	}
	
	@GetMapping("EventBoardRegisSubmit") // 이벤트 게시글 등록폼 제출
	public String eventBoardRegistration(EventBoardVO eventVo, HttpSession session) {
		/* 1. 시작일 > 등록일(now())
		 * 2. 종료일 > 시작일
		 * 
		 * 날짜 선택 시 위 두가지 반드시 적용되어야 함
		 * 
		 */
		String admin_sId = (String) session.getAttribute("admin_sId");
//		String sId = "admin";
		eventVo.setEvent_writer(admin_sId);
		System.out.println(eventVo);
		adminService.regisEventBoard(eventVo);
		
		return "redirect:/EventBoardManage";
	}
	
	@GetMapping("StartEvent") // 선택한 이벤트 시작 상태로 변경
	public String startEvent(@RequestParam("event_code") int[] event_codes) {
		for(int code : event_codes) {
			System.out.println("시작할 이벤트 코드 : " + code);
		}
		
		adminService.setEventStart(event_codes);
		
		return "redirect:/EventBoardManage";
	}
	
	@GetMapping("EndEvent") // 선택한 이벤트 종료 상태로 변경
	public String endEvent(@RequestParam("event_code") int[] event_code) {
		for(int code : event_code) {
			System.out.println("종료할 이벤트 코드 : " + code);
		}
		adminService.setEventEnd(event_code);
		
		return "redirect:/EventBoardManage";
	}

	@GetMapping("updateEventBoard") // 이벤트 게시글 수정폼 이동
	public String updateEventBoard(int event_code, EventBoardVO eventVo, Model model) {
		eventVo = adminService.updateEventBoard(event_code);
		model.addAttribute("eventVo", eventVo);
		
		return "adminpage/event_manage/event_board_modify";
	}
	
	@PostMapping("updateEventBoard") // 이벤트 게시글 수정폼 제출
	public String eventBoardModify(EventBoardVO eventVo) {
		return "";
	}
	
	@PostMapping("checkEventStatus") // 이벤트 종료 여부 ajax 응답
	@ResponseBody
	public Boolean checkEventStatus(int event_code) {
		EventBoardVO statusResult = adminService.selectWinner(event_code);
		Boolean checkSetWinnerStatus = statusResult.getSet_winner_status();
		int checkEventStatus = statusResult.getEvent_status();
		
		System.out.println("이벤트 코드 : " + event_code);
		System.out.println("이벤트 상태 : " + checkEventStatus);
		System.out.println("당첨 상태 : " + checkSetWinnerStatus);
		
		if(checkEventStatus == 2 && checkSetWinnerStatus == false) {
			return true;
		} else {
			return false;
		}
	}
	
	@PostMapping("checkStatusBeforeStart")
	@ResponseBody
	public Boolean checkEventStatusBeforeStart(int event_code) {
		EventBoardVO statusResult = adminService.selectWinner(event_code);
		int checkEventStatus = statusResult.getEvent_status();
		
		if(checkEventStatus == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@PostMapping("checkStatusBeforeEnd")
	@ResponseBody
	public Boolean checkEventStatusBeforeEnd(int event_code) {
		EventBoardVO statusResult = adminService.selectWinner(event_code);
		int checkEventStatus = statusResult.getEvent_status();
		
		if(checkEventStatus == 1) {
			return true;
		} else {
			return false;
		}
	}
	
	@GetMapping("ChooseEventWinner") // 이벤트 당첨자 추첨 폼 이동
	public String chooseEventWinner(int event_code, Model model) {
		System.out.println("이벤트 당첨 컨트롤러 이동");
		EventBoardVO eventVo = adminService.selectWinner(event_code);
//		System.out.println("이벤트Vo : " + eventVo);
		List<MemberVO> memberVo = adminService.getMemberList();
//		System.out.println("멤버Vo : " + memberVo);

		model.addAttribute("eventVo", eventVo);
		model.addAttribute("memberVo", memberVo);
		
		return "adminpage/event_manage/choose_event_winner";
	}
	
	@GetMapping("GiveCoupon") // 이벤트 당첨자 선택 후 쿠폰 지급 화면 이동
	public String giveCoupon(@RequestParam("member_id") List<String> member_id, int event_code, Model model) {
		for(String id : member_id) {
			System.out.println("쿠폰 증정 대상자 : " + id);
		}
		model.addAttribute("member_id", member_id);
		model.addAttribute("event_code", event_code);
		
		return "adminpage/coupon_manage/coupon_regis";
	}
	
	@PostMapping("GiveCoupon")
	public String giveCouponToWinner(GetGiveCouponInfoVO vo) {
		adminService.insertCoupon(vo);
		return "redirect:/EventWinnerManage";
	}
	
	@GetMapping("GivePoint") // 이벤트 당첨자 선택 후 포인트 지급 화면 이동
	public String givePoint(@RequestParam("member_id") List<String> member_id, int event_code, Model model) {
		for(String id : member_id) {
			System.out.println("쿠폰 증정 대상자 : " + id);
		}
		model.addAttribute("member_id", member_id);
		model.addAttribute("event_code", event_code);
		
		return "adminpage/point_manage/point_regis";
	}
	
	@PostMapping("GivePoint")
	public String givePointToWinner(int point) {
		// point 테이블 이용하여 구현하기.
//		adminService.insertPoint(point);
		return "redirect:/EventWinnerManage";
	}
	
	@GetMapping("EventWinnerManage") // 이벤트 당첨자 표시 페이지
	public String eventWinnerPage(HttpSession session, Model model) {
		// 로그인 유무 판별
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("vote_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		
		List<EventWinnerVO> winner = adminService.getEventWinnerList();
		
		model.addAttribute("event_winner", winner);
		System.out.println("이벤트 당첨자 내역 : " + winner);
		
		return "adminpage/event_manage/event_winner_manage";
	}
	

	
}

