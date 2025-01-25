package com.itwillbs.project_movie.controller;

import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.binding.MapperMethod.ParamMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.service.BookService;
import com.itwillbs.project_movie.service.MypageService;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.PageInfo;
import com.itwillbs.project_movie.vo.PaymentVO;
import com.itwillbs.project_movie.vo.ScheduleVO;
import com.itwillbs.project_movie.vo.SeatVO;
import com.itwillbs.project_movie.vo.TicketVO;

import retrofit2.http.GET;



@Controller
public class BookController {
	@Autowired private BookService bookService;
	@Autowired private MypageService myPageService;
	
	@GetMapping("MovieScheduleInfo")
	public String movieScheduleInfo(Model model, @RequestParam Map<String, String> conditionMap, HttpSession session) {
		
		
		return "book_tickets/movie_schedule_info";
	}
	
	// 예매하기 페이지 매핑
	@GetMapping("BookTickets")
	public String bookTickets(Model model) {
		
		// 상영중인 영화 목록 조회
		List<MovieVO> movieList = bookService.getMovieList();
		model.addAttribute("movieList", movieList);

		return "book_tickets/book_tickets";
	}
	
	@ResponseBody
	@PostMapping("BookTickets")
	public List<Map<String, Object>> bookTicketsList(Model model, @RequestParam Map<String, String> conditionMap) {
		// 스케줄에 등록된 영화 정보 가져오는 List
		List<Map<String, Object>> schWithMovie = bookService.getSchWithMovie(conditionMap);
		model.addAttribute("schWithMovie", schWithMovie);
		
		// 상영 시작시간 형식 변환
		for(Map<String, Object> map : schWithMovie) {
			
			SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm");
			
			String start_time = timeFormatter.format(map.get("start_time"));
			String end_time = timeFormatter.format(map.get("end_time"));
			
			map.put("start_time", start_time);
			map.put("end_time", end_time);
		}

		return schWithMovie;
	}
	
	@ResponseBody
	@GetMapping("GetMovieListScheduleToBooking")
	public List<MovieVO> getMovieListScheduleToBooking(@RequestParam Map<String, String> conditionMap, Model model) {
		List<MovieVO> movieList = bookService.getMovieList2(conditionMap);
		model.addAttribute("movieList", movieList);
		
		return movieList;
	}
	
	@ResponseBody
	@GetMapping("GetScheduleListToBooking")
	public List<ScheduleVO> getScheduleListToBooking(@RequestParam Map<String, String> conditionMap) {
		List<ScheduleVO> scheduleList = bookService.getScheduleList(conditionMap);
		
		// 시작, 끝 시간 형식변환
		for(ScheduleVO schedule: scheduleList) {
			SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm");
			schedule.setStr_start_time(timeFormatter.format(schedule.getStart_time()));
			schedule.setStr_end_time(timeFormatter.format(schedule.getEnd_time()));
		}
		
		return scheduleList;
	}
	
	// ajax로 예매 완료된 좌석 보내기
	@ResponseBody
	@GetMapping("GetAvailSeatFromSchedule")
	public List<Map<String, Object>> getAvailSeatFromSchedule(String schedule_code) {
		List<Map<String, Object>> disabledSeatList = bookService.getDisabledSeat(schedule_code);
		System.out.println("예매된 좌석 : " + disabledSeatList);
		
		return disabledSeatList;
	}
	
	
	
	// ========================= 좌석페이지 컨트롤러 =========================
	@GetMapping("BookSeat")
	public String bookSeatPage(String schedule_code, MemberVO member, HttpSession session, Model model) {
		// 스케줄 코드 세션에 저장
		session.setAttribute("schedule_code", schedule_code);
		
		// 미 로그인 시 접근 불가
		String id = (String)session.getAttribute("sMemberId");
		if(id == null) {
			model.addAttribute("msg", "로그인 후 이용 가능합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/process";
		}
		
		// 스케줄 코드 없을 시 접근 불가
		String schCode = (String)session.getAttribute("schedule_code");
		System.out.println(schCode);
		if(schCode == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "BookTickets");
			return "result/process";
		}
		
		// 좌석 정보 조회
		List<SeatVO> seatList = bookService.getSeat();
		int rowCount = 0;
		int colCount = 0;
		
		for(SeatVO seat : seatList) {
			// 열 개수 판별
			if(seat.getSeat_code().contains("A")) {
				colCount ++;
			}
			
			// 행 개수 판별
			if(seat.getSeat_code().contains("2")) {
				rowCount ++;
			}
		}
		
		model.addAttribute("seatList", seatList);
		model.addAttribute("rowCount", rowCount);
		model.addAttribute("colCount", colCount);
		System.out.println(seatList);
		
		List<TicketVO> ticketType = bookService.getTicketType();
		model.addAttribute("ticketType", ticketType);
		System.out.println(ticketType);
		
		
		Map<String, Object> schedule = bookService.getScheduleInfoByScheduleCode(schedule_code);
		model.addAttribute("schedule", schedule);
		System.out.println(schedule);
		
		// 예매 완료된 좌석
		List<Map<String, Object>> disabledSeatList = bookService.getDisabledSeat(schedule_code);
		System.out.println("좌석코드 : " + disabledSeatList);
		model.addAttribute("disabledSeatList", disabledSeatList);
		
		
		return "book_tickets/book_seat";
	}
	
	@ResponseBody
	@PostMapping("BookSeatPayInfo")
	public List<TicketVO> bookSeatPayInfo() {
		List<TicketVO> ticketList = bookService.getTicketType();
		return ticketList;
	}
	
	// 결제 페이지로 이동
	@GetMapping("BookPay")
	public String bookPayPage(String schedule_code, Model model, HttpSession session) {
		// 미 로그인 시 접근 불가
		String id = (String)session.getAttribute("sMemberId");
		if(id == null) {
			model.addAttribute("msg", "로그인 후 이용 가능합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/process";
		}
		
		// 스케줄 코드 없을 시 접근 불가
		String schCode = (String)session.getAttribute("schedule_code");
		if(schCode == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "BookTickets");
			return "result/process";
		}
		
		return "book_tickets/book_pay";
	}
	
	@PostMapping("BookPay")
	public String bookPay(String schedule_code, HttpSession session, Model model, @RequestParam Map<String, String> map) {
		// 미 로그인 시 접근 불가
		String id = (String)session.getAttribute("sMemberId");
		if(id == null) {
			model.addAttribute("msg", "로그인 후 이용 가능합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/process";
		}
		
		// 스케줄 코드 없을 시 접근 불가
		String schCode = (String)session.getAttribute("schedule_code");
		if(schCode == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "BookTickets");
			return "result/process";
		}
		
		// 회원 정보(이름, 메일, 전화번호) 세션에 저장
		// 결제 정보에 필요
		MemberVO member = bookService.getMemberWhoPayTicket(id);
		session.setAttribute("sName", member.getMember_name());
		session.setAttribute("sEmail", member.getEmail());
		session.setAttribute("sPhone", member.getPhone());

		
		// 선택한 영화 스케줄 정보 조회
		Map<String, Object> schedule = bookService.getScheduleInfoByScheduleCode(schedule_code);
		model.addAttribute("schedule", schedule);
		
		String totalSeat = map.get("totalSeat").replace(" ,", ", ").trim();
		
		map.put("theater_code", (String)schedule.get("theater_code"));
		map.put("member_id", id);
		map.put("totalSeat", totalSeat);

		SecureRandom sr = new SecureRandom();
		String payment_code = (String)schedule.get("theater_code") + sr.nextInt((int) Math.pow(10, 11));
		map.put("payment_code", payment_code);
		model.addAttribute("payment_code", payment_code);
		
		int insertCount = bookService.registBookingTicket(map);
		model.addAttribute("totalSeat", totalSeat);
		System.out.println("좌석수 : " + insertCount);
		
		PaymentVO paymentInfo = bookService.getPaymentInfo(payment_code);
		model.addAttribute("paymentInfo", paymentInfo);
		System.out.println(paymentInfo);
		
		// ================== [ 포인트, 쿠폰 ] =====================
		int myPoint = bookService.getMyPoint(id);
		model.addAttribute("myPoint", myPoint);
		
		List<Map<String, Object>> myCouponList = bookService.getMyCouponList(id);
		for(Map<String, Object> myCoupon : myCouponList) {
			String discount_amount = !myCoupon.get("discount_amount").toString().equals("0") ?  myCoupon.get("discount_amount") + "원 할인권" : "";
			String discount_rate = !myCoupon.get("discount_rate").toString().equals("0") ?  myCoupon.get("discount_rate") + "% 할인권" : "";
			String coupon_name = myCoupon.get("event_subject") + " " + discount_amount + discount_rate;
			myCoupon.put("coupon_name", coupon_name);
		}
		model.addAttribute("myCouponList", myCouponList);

		
		return "book_tickets/book_pay";
	}
	
	@ResponseBody
	@GetMapping("GetMyCouponDetailInfo")
	public CouponVO getMyCouponDetailInfo(String coupon_code) {
		CouponVO coupon = bookService.getMyCoupon(coupon_code);
		return coupon;
	}
	
	// ================= [ 결제 완료 페이지 ] ==================
	
	@PostMapping("BookFinish")
	public String bookFinish(@RequestParam Map<String, String> map, HttpSession session, Model model, String schedule_code) {
		// 미 로그인 시 접근 불가
		String id = (String)session.getAttribute("sMemberId");
		if(id == null) {
			model.addAttribute("msg", "로그인 후 이용 가능합니다");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/process";
		}
		
		// 스케줄 코드 없을 시 접근 불가
		String schCode = (String)session.getAttribute("schedule_code");
		if(schCode == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "BookTickets");
			return "result/process";
		}
		
		System.out.println(schCode);
		
		// point_discount 값 없을 시 null로 변환
		if(map.get("point_discount") != null && map.get("point_discount").trim().isEmpty()) {
			map.put("point_discount", null);
		}
		
		
		Map<String, Object> schedule = bookService.getScheduleInfoByScheduleCode(schedule_code);
		model.addAttribute("schedule", schedule);
		
		// 결제 완료 시 payment 테이블에 정보 업데이트
		int updateCount = bookService.addBookingTicket(map, id);
		System.out.println(map);
		
		if(updateCount == 0) {
			model.addAttribute("msg", "결제에 실패했습니다");
			return "result/process";
		}
		System.out.println("결제 완료 : " + updateCount);
		

		
		
		return "book_tickets/book_finish";
	}

	
	// 예매 취소
	@ResponseBody
	@PostMapping("ReservationCancel")
	public ResponseEntity<Map<String, Object>> reservationCancel(@RequestParam Map<String, Object> map, HttpSession session, Model model) {

		int totalDiscount =  bookService.getTotalDiscount(map);
		map.put("total_discount", totalDiscount);
		
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		
		String startTimeStr = (String)map.get("start_time");
		LocalDateTime start_time = LocalDateTime.parse(startTimeStr, formatter);
		
		LocalDateTime now = LocalDateTime.now();
		
		// 상영시간과 현재시간 비교해서 20분차 이하일 때만 예매 취소 가능
		long minutesUntilStart = ChronoUnit.MINUTES.between(now, start_time);
		
		
		Map<String, Object> response = new HashMap<>();
		if(minutesUntilStart > 20) {
			int updateCount = bookService.modifyRefundPayment(map);
			
			if(updateCount > 0) {
				response.put("status", "success");
				response.put("msg", "예매가 취소되었습니다");
			} 
			
		} else {
			response.put("status", "timeOut");
			response.put("msg", "상영시간 20분 전까지만 취소 가능합니다.");
		}
		
		session.setAttribute("minutesUntilStart", minutesUntilStart);
		
		return ResponseEntity.ok(response);
	}
	
	// ============================= [ 관리자 페이지 예매/취소 내역 ] ====================================
	@GetMapping("AdminPaymentList")
	public String adminPaymentList(@RequestParam(defaultValue = "1") int pageNum, Model model,
			@RequestParam(defaultValue="") String howSearch, @RequestParam(defaultValue="") String searchKeyword) {
		
		
		int listCount = bookService.getpaymentListCount(howSearch, searchKeyword); //총결제 목록(검색된 결제 목록)수 조회
		
		//페이징 처리 메서드
		if(!pagingMethod(1, model, pageNum, 10, listCount, howSearch, searchKeyword)) {
			return "result/process";
		}
		
		return "adminpage/payment_manage/reservation_info_board";
	}
	
	@GetMapping("AdminRefundList")
	public String adminRefundList(@RequestParam(defaultValue = "1") int pageNum, Model model,
	@RequestParam(defaultValue="") String howSearch, @RequestParam(defaultValue="") String searchKeyword) {
		
		
		int listCount = bookService.getRefundListCount(howSearch, searchKeyword);
		
		// 페이징처리 메서드 
		if(!pagingMethod(2, model, pageNum, 10, listCount, howSearch, searchKeyword)) {
			return "result/process";
		}
		
		return "adminpage/payment_manage/reservation_cancel_board";
	}
	
	@GetMapping("getpaymentList")
	public String getpaymentList(PaymentVO payment, ScheduleVO schedule, Model model) {
//		List<PaymentVO> paymentList = bookService.getAllPaymentList();
		
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime startTime = schedule.getStart_time().toLocalDateTime();
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String start_time = formatter.format(startTime);
		
//		long minutesUntilStart = ChronoUnit.MINUTES.between(now, start_time);
		
//		model.addAttribute("minutesUntilStart", minutesUntilStart);
		
		return "adminpage/payment_manage/reservation_info_board";
	}
	
	
	// ==================== [ 페이징 메서드 ] ======================
	private Boolean pagingMethod(int index, Model model, int pageNum, int listLimit, int listCount, String howSearch, String searchKeyword) {
		int startRow = (pageNum - 1) * listLimit; // 조회할 결제테이블의 DB 행 번호(= row 값)
		int pageListLimit = 10; // 한페이지당 페이지번호 수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); // 최대 페이지번호
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; //각 페이지의 첫번째 페이지 번호
		int endPage = startPage + pageListLimit - 1; // 각 페이지의 마지막 페이지번호
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// url 파라미터 조작 방지
		if(index == 1) {
			if(pageNum < 1 || (maxPage > 0 && pageNum > maxPage)) {
				model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
				model.addAttribute("targetURL", "AdminPaymentList?pageNum=1");
				return false;
			}
		} else if(index == 2) {
			if(pageNum < 1 || (maxPage > 0 && pageNum > maxPage)) {
				model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
				model.addAttribute("targetURL", "AdminRefundList?pageNum=1");
				return false;
			}
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		model.addAttribute("pageInfo", pageInfo);
		
		if(index == 1) {
			// 조건에 맞는 결제내역 리스트 조회
			List<Map<String, Object>> paymentList = bookService.getpaymentList(startRow, listLimit, howSearch, searchKeyword);
			model.addAttribute("paymentList", paymentList);
		} else if(index == 2) {
			// 조건에 맞는 환불내역 리스트 조회
			List<Map<String, Object>> refundList = bookService.getRefundList(startRow, listLimit, howSearch, searchKeyword);
			model.addAttribute("refundList", refundList);
		}

		
		return true;
	}
	
}










