package com.itwillbs.project_movie.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.project_movie.service.BookService;
import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.SeatVO;
import com.itwillbs.project_movie.vo.TheaterVO;
import com.itwillbs.project_movie.vo.TicketVO;

@Controller
public class BookController {
	@Autowired private BookService service;
	
	@GetMapping("MovieScheduleInfo")
	public String movieScheduleInfo() {
		return "book_tickets/movie_schedule_info";
	}
	
	@GetMapping("BookTickets")
	public String bookTickets(Model model) {
		
		// 영화 목록 조회
		List<MovieVO> movieList = service.getMovieList();
		model.addAttribute("movieList", movieList);
		
//		System.out.println("movieList : " + movieList);
		
		
		return "book_tickets/book_tickets";
	}
	
	
	
	
	
	@GetMapping("BookSeat")
	public String bookSeatPage(HttpSession session, Model model) {

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
		
		return "book_tickets/book_seat";
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










