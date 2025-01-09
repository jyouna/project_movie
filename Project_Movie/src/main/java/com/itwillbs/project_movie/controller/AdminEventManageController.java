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
import com.itwillbs.project_movie.vo.PointVO;

@Controller
public class AdminEventManageController {
	@Autowired
	private AdminManageService adminService;
	
	@GetMapping("EventBoardManage") // 이벤트 게시판 관리 + 리스트 출력
	public String eventBoardManagement(EventBoardVO eventVo, Model model, HttpSession session) {
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
		
		// 이벤트 게시판 전체 목록조회 후 뷰페이지로 전달
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
		 * 날짜 선택 시 위 두가지 반드시 적용되어야 함
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
		return "redirect:/CouponWinnerManage";
	}
	
	@GetMapping("GivePoint") // 이벤트 당첨자 선택 후 포인트 지급 화면 이동
	public String givePoint(@RequestParam("member_id") List<String> member_id, int event_code, Model model) {
//		for(String id : member_id) {
//			System.out.println("쿠폰 증정 대상자 : " + id);
//		}
		model.addAttribute("member_id", member_id);
		model.addAttribute("event_code", event_code);
		
		return "adminpage/point_manage/point_regis";
	}
	
	@PostMapping("GivePoint")
	public String givePointToWinner(@RequestParam("member_id") List<String> member_id, int point_amount, int event_code) {
		System.out.println("지급 대상자 : " + member_id);
		System.out.println("이벤트 코드 : " + event_code);
		System.out.println("지급할 포인트 : " + point_amount);
		
		// point 테이블 이용하여 구현하기.
		adminService.GivePointToWinner(member_id, event_code, point_amount);
		
		return "redirect:/PointWinnerManage";
	}
	
	@GetMapping("CouponWinnerManage") // 이벤트 당첨자 표시 페이지
	public String couponWinnerPage(HttpSession session, Model model) {
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
		
		List<EventWinnerVO> coupon_winner = adminService.getEventWinnerList();
		System.out.println("쿠폰 당첨자 내역 : " + coupon_winner);

		model.addAttribute("coupon_winner", coupon_winner);
		
		return "adminpage/event_manage/coupon_winner_manage";
	}

	@GetMapping("PointWinnerManage") // 이벤트 당첨자 표시 페이지
	public String pointWinnerPage(HttpSession session, Model model) {
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
		
		List<EventWinnerVO> point_winner = adminService.getPointWinnerList();
		System.out.println("포인트 당첨자 내역 : " + point_winner);
		
		model.addAttribute("point_winner", point_winner);
		
		return "adminpage/event_manage/point_winner_manage";
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
		
		List<CouponVO> couponVo = adminService.getCouponList();
		model.addAttribute("couponVo", couponVo);
		
		return "adminpage/coupon_manage/coupon_board_manage";
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
		
		List<PointVO> pointVo = adminService.getPointRecord();
		System.out.println("포인트 내역 : " + pointVo);
		model.addAttribute("pointVo", pointVo);
		
		return "adminpage/point_manage/point_board_manage";
	}

}

