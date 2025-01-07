package com.itwillbs.project_movie.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.project_movie.service.BookService;
import com.itwillbs.project_movie.vo.MovieVO;

@Controller
public class BookController {

	@Autowired private BookService service;
	
	@GetMapping("MovieScheduleInfo")
	public String movieScheduleInfo() {
		return "book_tickets/movie_schedule_info";
	}
	
	@GetMapping("BookTickets")
	public String bookTickets(Model model) {
		
		List<MovieVO> movieList = service.getMovieList();
		model.addAttribute("movieList", movieList);
		
		System.out.println("movieList : " + movieList);
		
		
		
		return "book_tickets/book_tickets";
	}
	
	
	
	
	
	@GetMapping("BookSeat")
	public String bookSeat() {
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










