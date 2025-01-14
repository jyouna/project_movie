package com.itwillbs.project_movie.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
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

import com.itwillbs.project_movie.service.BookService;
import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.ScheduleVO;
import com.itwillbs.project_movie.vo.SeatVO;
import com.itwillbs.project_movie.vo.TicketVO;

@Controller
public class BookController {
	@Autowired private BookService service;
	
	@GetMapping("MovieScheduleInfo")
	public String movieScheduleInfo() {
		return "book_tickets/movie_schedule_info";
	}
	
	// 예매하기 페이지 매핑
	@GetMapping("BookTickets")
	public String bookTickets(Model model) {
		
		// 상영중인 영화 목록 조회
		List<MovieVO> movieList = service.getMovieList();
		model.addAttribute("movieList", movieList);

		return "book_tickets/book_tickets";
	}
	
	@ResponseBody
	@PostMapping("BookTickets")
	public List<Map<String, Object>> bookTicketsList(Model model,@RequestParam Map<String, String> conditionMap) {
		// 스케줄에 등록된 영화 정보 가져오는 List
		List<Map<String, Object>> schWithMovie = service.getSchWithMovie(conditionMap);
		model.addAttribute("schWithMovie", schWithMovie);
//		System.out.println("schWithMovie : " + schWithMovie);
		
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
	public List<MovieVO> getMovieListScheduleToBooking(@RequestParam Map<String, String> conditionMap) {
		List<MovieVO> movieList = service.getMovieList(conditionMap);
		return movieList;
	}
	
	@ResponseBody
	@GetMapping("GetScheduleListToBooking")
	public List<ScheduleVO> getScheduleListToBooking(@RequestParam Map<String, String> conditionMap) {
		List<ScheduleVO> scheduleList = service.getScheduleList(conditionMap);
		
		// 시작, 끝 시간 형식변환
		for(ScheduleVO schedule: scheduleList) {
			SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm");
			schedule.setStr_start_time(timeFormatter.format(schedule.getStart_time()));
			schedule.setStr_end_time(timeFormatter.format(schedule.getEnd_time()));
		}
		
		return scheduleList;
	}
	
	// ========================= 좌석페이지 컨트롤러 =========================
	@GetMapping("BookSeat")
	public String bookSeatPage(HttpSession session, Model model, TicketVO ticket) {

		// 로그인 후 좌석 선택 가능
		// 미로그인 시 로그인 폼으로 이동
//		String id = (String)session.getAttribute("sId");
//		
//		if(id == null) {
//			model.addAttribute("msg", "로그인 후 이용 가능합니다");
//			model.addAttribute("targetURL", "MemberLogin");
//			return "result/fail";
//		}
		
		// 좌석 정보 조회
		List<SeatVO> seatList = service.getSeat();
		
		
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
		
		
		List<TicketVO> ticketType = service.getTicketType();
		model.addAttribute("ticketType", ticketType);
		
		System.out.println(ticketType);
		
		
		
		return "book_tickets/book_seat";
	}
	
	@ResponseBody
	@PostMapping("BookSeatPayInfo")
	public List<TicketVO> bookSeatPayInfo() {
		List<TicketVO> ticketList = service.getTicketType();
		return ticketList;
	}
	

	@GetMapping("BookPay")
	public String bookPay() {
		return "book_tickets/book_pay";
	}

	@GetMapping("BookFinish")
	public String bookFinish() {
		return "book_tickets/book_finish";
	}

	
	
	
	
	
	
	
	
	
	
}










