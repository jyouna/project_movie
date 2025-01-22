package com.itwillbs.project_movie.controller;

import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.binding.MapperMethod.ParamMap;
import org.springframework.beans.factory.annotation.Autowired;
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
			return "result/fail";
		}
		
		// 스케줄 코드 없을 시 접근 불가
		String schCode = (String)session.getAttribute("schedule_code");
		System.out.println(schCode);
		if(schCode == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "BookTickets");
			return "result/fail";
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
			return "result/fail";
		}
		
		// 스케줄 코드 없을 시 접근 불가
		String schCode = (String)session.getAttribute("schedule_code");
		if(schCode == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "BookTickets");
			return "result/fail";
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
			return "result/fail";
		}
		
		// 스케줄 코드 없을 시 접근 불가
		String schCode = (String)session.getAttribute("schedule_code");
		if(schCode == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "BookTickets");
			return "result/fail";
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
//	@GetMapping("BookFinish")
//	public String bookFinishPage() {
//		return "book_tickets/book_finish";
//	}
	
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

	
	
	@ResponseBody
	@PostMapping("ReservationCancel")
	public String reservationCancel(@RequestParam Map<String, Object> map, HttpSession session) {

		int totalDiscount =  bookService.getTotalDiscount(map);
		map.put("total_discount", totalDiscount);
		
		int updateCount = bookService.modifyRefundPayment(map);
		System.out.println("map : " + map);
		System.out.println("updateCount : " + updateCount);
		
		return "";
	}
	
	
	
	
	
	
}










