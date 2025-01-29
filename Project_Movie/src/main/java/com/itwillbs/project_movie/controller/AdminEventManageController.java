package com.itwillbs.project_movie.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.handler.AdminMenuAccessHandler;
import com.itwillbs.project_movie.handler.PagingHandler;
import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.GetGiveCouponInfoVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.PageInfo;
import com.itwillbs.project_movie.vo.PageInfo2;
import com.itwillbs.project_movie.vo.PointVO;

import retrofit2.http.GET;

@Controller
public class AdminEventManageController {
	@Autowired
	private AdminManageService adminService;
	@Autowired
	private PagingHandler pagingHandler;
	@GetMapping("EventBoardManage") // 이벤트 게시판 관리 + 이벤트 목록 출력
	public String eventBoardManagement(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session,
										@RequestParam(defaultValue = "") String searchKeyword,
										@RequestParam(defaultValue = "") String searchContent,
										@RequestParam(defaultValue = "") String eventStatus,
										@RequestParam(defaultValue = "") String eventWinnerStatus) {
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
		
		System.out.println("이벤트 상태값 : " + eventStatus);
		System.out.println("이벤트 위너 상태값 : " + eventWinnerStatus);
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "eventBoardList", searchKeyword, searchContent, eventStatus, eventWinnerStatus);
		List<EventBoardVO> eventList = adminService.eventBoardList(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent, eventStatus, eventWinnerStatus);
		model.addAttribute("eventVo", eventList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/event_manage/event_board_manage";
	}
	
	@GetMapping("EventBoardRegis") // 이벤트 게시글 등록폼
	public String eventBoardRegisForm() {
		return "adminpage/event_manage/event_board_regis";
	}
	
	@GetMapping("EventBoardRegisSubmit") // 이벤트 게시글 등록폼 제출
	public String eventBoardRegistration(EventBoardVO eventVo, HttpSession session) {
		String admin_sId = (String) session.getAttribute("admin_sId");
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
	public String eventBoardModify(EventBoardVO eventVo, Model model) {
		System.out.println("폼 파라미터 : " + eventVo);
		
		int updateCount = adminService.modifyEventBoard(eventVo);
		
		if(updateCount > 0) {
			System.out.println("이벤트 게시글 수정 성공");
			return "redirect:/EventBoardManage";
		} else {
			model.addAttribute("msg", "게시글 수정 실패");
			model.addAttribute("targetURL", "EventBoardManage");
			return "result/process";			
		}
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
	
	// 이벤트 당첨자 추첨
	// 결제일이 이벤트 시작일과 이벤트 종료일 사이에 있는 회원들 중 50명을 랜덤으로 추첨
	@GetMapping("ChooseEventWinner") 
	public String chooseEventWinner(int event_code, Model model) {
		System.out.println("이벤트 당첨 컨트롤러 이동");
		 // 라디오 버튼으로 선택한 이벤트 정보 저장
		EventBoardVO eventVo = adminService.selectWinner(event_code);
		// 이벤트 당첨자 목록 조회 (이벤트 시작일 ~ 종료일 사이 예매한 대상 조회)
		List<String> winnerIdList = adminService.getBookingEventWinnerList(eventVo.getEvent_start_date(), eventVo.getEvent_end_date());
		// 해당 기간 내 예매자 중 50명을 선별하여 저장
		List<String> winnerList = new ArrayList<>(); 
		Random r = new Random(); 
		// 경품 추첨 대상자 수
		int winnerCount = winnerIdList.size();		
		System.out.println("winnerCount : " + winnerCount);
		// 만약 해당 기간 내 결제한 인원이 한 명도 없을 경우 오류 메세지 창 출력 및 이벤트 자동종료
		if(winnerCount == 0) {
			adminService.endEventWithoutWinner(eventVo.getEvent_code());
			model.addAttribute("msg", "해당 기간 내 예매한 회원이 없습니다.");
			model.addAttribute("targetURL", "EventBoardManage");
			return "result/process";			
		}
		// 만약 해당 기간 내 결제한 인원이 50명보다 적을 경우, 조회된 인원 수 만큼만 반복수행
		if((winnerCount < 50) && (winnerCount > 0)) {
			for(int i = 0; i < winnerCount; i++) {
				String id = winnerIdList.get(r.nextInt(winnerCount));
				// 리스트에 포함되어 있지 않은 아이디만 당첨자 리스트에 추가
				if(!winnerList.contains(id)) {
					winnerList.add(id);
				}
			}
		// 해당 기간 내 결제한 인원이 50명 초과일 경우, 50회 반복
		} else {
			while(winnerList.size() != 50) {
				String id = winnerIdList.get(r.nextInt(winnerCount));
				// 해당 기간에 예매한 인원 중 랜덤으로 50명 추첨 
				// 만약 동일한 아이디가 나올 시 재추첨
				if(!winnerList.contains(id)) {
					winnerList.add(id);
				} 
			}
		}
		System.out.println("리스트 객체에 저장된 값 개수 : " + winnerList.size());
		model.addAttribute("eventVo", eventVo);
		model.addAttribute("winnerList", winnerList); // 기존에 memberVo로 이름을 설정하여 그대로 유지 
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
		return "redirect:/EventAllWinnerList";
	}
	
	// 이벤트 당첨자 선택 후 포인트 지급 화면 이동
	@GetMapping("GivePoint") 
	public String givePoint(@RequestParam("member_id") List<String> member_id, int event_code, Model model) {
		model.addAttribute("member_id", member_id);
		model.addAttribute("event_code", event_code);
		return "adminpage/point_manage/point_regis";
	}
	
	// 회원 관리 메뉴에서 ID 선택 후 포인트 지급 버튼 클릭 시 팝업 창
	@GetMapping("CreditPoint")
	public String creditPointForm(@RequestParam("member_id") List<String> member_id, Model model) {
		model.addAttribute("member_id", member_id);
		return "adminpage/point_manage/point_credit_regis";
	}

	@GetMapping("CreateCoupon")
	public String createCouponForm(@RequestParam("member_id") List<String> member_id, Model model) {
		model.addAttribute("member_id", member_id);
		return "adminpage/coupon_manage/create_coupon_form";
	}
	
	// 관리자가 직접 쿠폰 지급
	@PostMapping("CreateCoupon")
	@ResponseBody
	public Boolean createCoupon(
	    @RequestParam("expired_date") Date expiredDate,
	    @RequestParam("coupon_type") String couponType,
	    @RequestParam(value = "discount_rate", required = false, defaultValue = "0") int discountRate, // 기본값 0
	    @RequestParam(value = "discount_amount", required = false, defaultValue = "0") int discountAmount, // 기본값 0
	    @RequestParam(value = "member_id") List<String> memberId,
	    @RequestParam("coupon_count") int coupon_count,
	    Model model) {
		
		System.out.println("쿠폰 타입 : " + couponType);
		// 문자열로 입력된 쿠폰타입을 DB 데이터 타입에 맞게 변경
		if(couponType.equals("금액할인")) {
			couponType = "0";
		} else if(couponType.equals("할인율")){
			couponType = "1";
		} else {
			return false;
		}
		int insertCount = adminService.createCoupon(expiredDate, couponType, discountRate, discountAmount, memberId, coupon_count);
		System.out.println("쿠폰 등록 횟수 : " + insertCount);
		if(insertCount < (memberId.size() * coupon_count)) {
	    	return false;
	    } else {
	    	return true;
	    }
	}
	
	// 포인트 지급 폼 제출
	@PostMapping("CreditPoint")
	@ResponseBody
	public Boolean creditPoint(@RequestParam("member_id") List<String> member_id, @RequestParam("point_amount") int point_amount) {
		int insertCount = adminService.creditPoint(member_id, point_amount);
		// 지급 한 회원 수 보다 처리된 경우의 수가 적을 경우
		if(insertCount < member_id.size()) { 
			return false;
		} else {
			return true;
		}
	}
	
	@PostMapping("GivePoint")
	public String givePointToWinner(@RequestParam("member_id") List<String> member_id, int point_amount, int event_code, Model model) {
		System.out.println("지급 대상자 : " + member_id);
		System.out.println("이벤트 코드 : " + event_code);
		System.out.println("지급할 포인트 : " + point_amount);
		int updateCount = adminService.GivePointToWinner(member_id, event_code, point_amount);
		if(updateCount < member_id.size()) {
			model.addAttribute("msg", "포인트 지급 실패");
			model.addAttribute("targetURL", "ChooseEventWinner");
			return "result/process";
		} else {
			return "redirect:/EventAllWinnerList";
		}
	}
	
	@GetMapping("CouponWinnerManage") // 이벤트 당첨자 표시 페이지
	public String couponWinnerPage(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session,
									@RequestParam(defaultValue = "") String searchKeyword,
									@RequestParam(defaultValue = "") String searchContent) {
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
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "couponWinnerList", searchKeyword, searchContent);
		List<EventWinnerVO> coupon_winner = adminService.getEventWinnerList(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		model.addAttribute("coupon_winner", coupon_winner);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/coupon_manage/coupon_winner_manage";
	}

	@PostMapping("CouponWinnerManage") // 이벤트 당첨자 표시 페이지
	public String couponWinnerSearchForm(Model model, HttpSession session,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "") String searchContent) {
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
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(1, "couponWinnerList", searchKeyword, searchContent);
		List<EventWinnerVO> coupon_winner = adminService.getEventWinnerList(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		model.addAttribute("coupon_winner", coupon_winner);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/coupon_manage/coupon_winner_manage";
	}

	@GetMapping("PointWinnerManage") // 이벤트 당첨자 표시 페이지
	public String pointWinnerPage(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session,
									@RequestParam(defaultValue = "") String searchKeyword,
									@RequestParam(defaultValue = "") String searchContent) {
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
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "pointWinnerList", searchKeyword, searchContent);
		List<EventWinnerVO> point_winner = adminService.getPointWinnerList(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		
		
		model.addAttribute("point_winner", point_winner);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/point_manage/point_winner_manage";
	}

	@GetMapping("CouponBoardManage") // 쿠폰 관리 페이지
	public String couponBoardManagement(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session,
										@RequestParam(defaultValue = "") String searchKeyword,
										@RequestParam(defaultValue = "") String searchContent) {
		System.out.println("컨트롤러 pageNum : " + pageNum);
		
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
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "couponList", searchKeyword, searchContent);
		System.out.println("pageInfo 값 : " + pageInfo);
		
		List<CouponVO> couponVo = adminService.getCouponList(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		model.addAttribute("couponVo", couponVo);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/coupon_manage/coupon_board_manage";
	}
	
	// 쿠폰 관리 페이지 상단 검색바
	@PostMapping("CouponBoardManage")
	public String couponBoardSearchForm(Model model, HttpSession session,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "") String searchContent) {
		
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
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(1, "couponList", searchKeyword, searchContent);
		System.out.println("pageInfo 값 : " + pageInfo);
		
		List<CouponVO> couponVo = adminService.getCouponList(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		model.addAttribute("couponVo", couponVo);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/coupon_manage/coupon_board_manage";
	}
	
	 // 포인트 내역
	@GetMapping("PointBoardManage")
	public String pointBoardManagement(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session,
										@RequestParam(defaultValue = "") String searchKeyword,
										@RequestParam(defaultValue = "") String searchContent) {
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
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "pointList", searchKeyword, searchContent);
		List<PointVO> pointVo = adminService.getPointRecord(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		model.addAttribute("pointVo", pointVo);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/point_manage/point_board_manage";
	}
	
	// 포인트 내역 검색바
	@PostMapping("PointBoardManage")
	public String pointBoardSearchForm(Model model, HttpSession session,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "") String searchContent) {
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
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(1, "pointList", searchKeyword, searchContent);
		List<PointVO> pointVo = adminService.getPointRecord(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		model.addAttribute("pointVo", pointVo);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/point_manage/point_board_manage";
	}
	
	@GetMapping("DeleteEventBoard") // 이벤트 게시물 삭제
	@ResponseBody
	public Boolean deleteEventBoard(int event_code) {
		System.out.println("컨트롤러 호출됨 : " + event_code);
		
		int deleteCount = adminService.deleteEvent(event_code);
		
		if(deleteCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@GetMapping("countMember") // 전체 회원 수 조회 -> 통계 사용 
	@ResponseBody
	public int count_member(String searchKeyword, String searchContent) {
		
		System.out.println("멤버 카운트 컨트롤러 호출");
		System.out.println(searchKeyword);
		System.out.println(searchContent);
		
		int member = adminService.getMemberCount(searchKeyword, searchContent);
		return member;
	}

	// 이벤트 당첨자 표시 (쿠폰 + 포인트)
	@GetMapping("EventAllWinnerList") 
	public String eventWinnerList(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "") String searchContent) {
		
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
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "eventWinnerList", searchKeyword, searchContent);
		List<EventWinnerVO> voList = adminService.getAllEventWinnerList(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		
		System.out.println("이벤트 당첨자 : " + voList);
		model.addAttribute("voList", voList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/event_manage/event_allWinner_list";
	}	
	
	@GetMapping("GetWinnerCount")
	@ResponseBody
	public int getWinnerCount(String searchKeyword, String searchContent) {
		System.out.println("당첨자 수 조회 컨트롤러 호출됨");
		int winnerCount = adminService.getWinnerCount(searchKeyword, searchContent);
		System.out.println("당첨자 수 : " + winnerCount);
		return winnerCount;
	}
	
	@GetMapping("EventWinnerManage")
	public String EventWinnerManage(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "") String searchContent) {

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
		
		return "adminpage/event_manage/event_winner_manage";
	}
	
	// 이벤트 페이지 당첨자 표시
	@GetMapping("ShowEventWinnerList")
	public String showEventWinnerList(int event_code, Model model) {
		System.out.println("당첨자 컨트롤러 호출됨");
		
		List<EventWinnerVO> voList = adminService.getWinnerList(event_code);
		System.out.println("당첨자 수 : " + voList.size());
		System.out.println("당첨자 : " + voList);
		model.addAttribute("voList", voList);
		model.addAttribute("count", voList.size());
		return "adminpage/event_manage/event_winner_list_toShow";
	}
	
	@GetMapping("CheckEventStatusForShowing")
	@ResponseBody
	public Boolean getWinnerCount(int event_code) {
		System.out.println("당첨자 수 출력 컨트롤러 호출");
		EventBoardVO event = adminService.checkEventStatus(event_code);
//		int winnerCount = adminService.getSingEventWinnerCount(event_code);
//		System.out.println(winnerCount);
		System.out.println("이벤트 상태 : " + event.getEvent_status());
		System.out.println("이벤트당첨자 추첨 상태 : " + event.getSet_winner_status());
		if(event.getEvent_status() == 2 && event.getSet_winner_status() == true) {
			return true;
		} else {
			return false;
		}
	}
	
}

