package com.itwillbs.project_movie.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.EventBoardVO;

@Controller
public class AdminSettingController {
	@Autowired
	private AdminManageService adminService;
	
	@GetMapping("AdminAccountManage") // 관리자 계정관리 페이지 이동
	public String adminAccountManagement(Model model) {
		List<AdminRegisVO> voList = new ArrayList<AdminRegisVO>();
		voList = adminService.queryAdminList();
		System.out.println("관리자 관리 페이지 에서 호출 : " + voList);
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
	
	@GetMapping("DeleteAdminAccount") // 관리자 계정 삭제
	public String adminAccountDelete(@RequestParam("admin_id") String[] admin_id) {
//		System.out.println("화면에서 받아온 값 : " + admin_id);
		for (String id : admin_id) {
			System.out.println(id);
		}
		
		adminService.deleteAdminAccount(admin_id);
		
		return "redirect:/AdminAccountManage";
	}
	
	@GetMapping("AdminPageIdSearch")
	public String idSearch() {
		return "adminpage/id_search";
	}
	
	@PostMapping("AdminSetAuth") // 관리자 계정 설정
	public String adminSetAuth(@RequestBody Map<String, String> authRequest) {
		System.out.println("ajax에서 관리자 계정 설정 컨트롤러 호출!");
		System.out.println("권한 요청 내역 : "+ authRequest);
		
		return "";
	}
	
	@GetMapping("MemberList")
	public String memberList() {
		return "adminpage/member_manage/member_list";
	}
	
	@GetMapping("StaticsVisitors")
	public String staticsVisitors() {
		return "adminpage/statics_manage/statics_visitors";
	}

	@GetMapping("StaticsSales")
	public String staticsSales() {
		return "adminpage/statics_manage/statics_sales";
	}
	
	@GetMapping("StaticsVoteResult")
	public String staticsVoteResult() {
		return "adminpage/statics_manage/statics_voteResult";
	}
	
	@GetMapping("StaticsNewMember")
	public String staticsNewMembers() {
		return "adminpage/statics_manage/statics_newMembers";
	}
	
	@GetMapping("SpecificPeriodSearch")
	public String specificPeriodSearch() {
		return "adminpage/specific_period_search";
	}

	@GetMapping("CouponBoardManage")
	public String couponBoardManagement() {
		return "adminpage/coupon_manage/coupon_board_manage";
	}
	
	@GetMapping("CouponBoardRegis")
	public String couponBoardRegistration() {
		return "adminpage/coupon_manage/coupon_board_regis";
	}

	@GetMapping("PointBoardManage")
	public String pointBoardManagement() {
		return "adminpage/point_manage/point_board_manage";
	}
	
	@GetMapping("PointBoardRegis")
	public String pointBoardRegistration() {
		return "adminpage/point_manage/point_board_regis";
	}
	
	@GetMapping("EventBoardManage") // 이벤트 게시판 관리 + 리스트 출력
	public String eventBoardManagement(EventBoardVO eventVo, Model model) {
		List<EventBoardVO> eventList = new ArrayList<EventBoardVO>();
		eventList = adminService.eventBoardList();
		model.addAttribute("eventVo", eventList);
		return "adminpage/event_manage/event_board_manage";
	}
	
	@GetMapping("EventBoardRegis")
	public String eventBoardRegisForm() {
		return "adminpage/event_manage/event_board_regis";
	}
	
	@GetMapping("EventBoardRegisSubmit")
	public String eventBoardRegistration(EventBoardVO eventVo, HttpSession session) {
//		String sId = session.getId();
		String sId = "admin";
		eventVo.setEvent_writer(sId);
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

	@GetMapping("updateEventBoard")
	public String updateEventBoard(int event_code, EventBoardVO eventVo, Model model) {
		eventVo = adminService.updateEventBoard(event_code);
		model.addAttribute("eventVo", eventVo);
		
		return "adminpage/event_manage/event_board_modify";
	}
	
	@PostMapping("updateEventBoard")
	public String eventBoardModify(EventBoardVO eventVo) {
		return "";
	}
	
	@GetMapping("ChooseEventWinner") // 이벤트 당첨자 추첨 - 이벤트 관리 페이지에서 선택
	public String chooseEventWinner(@RequestParam("event_code") int[] event_code) {
//		for(int code : event_code) {
//			System.out.println("당첨자 : " + code);
//		}
//		
//		adminService.selectWinner(event_code);
		return "";
	}
	
	@GetMapping("GivePrizeForm") // 이벤트 당첨자에게 경품 지급 버튼 클릭 시 해당 폼으로 이동. 이벤트 당첨자 관리 페이지에서 선택
	public String givePrizeForm() {
	
		return "";
	}
	
	@GetMapping("EventWinnerManage")
	public String eventWinnerPage() {
		
		return "adminpage/event_manage/event_winner_manage";
	}
}

