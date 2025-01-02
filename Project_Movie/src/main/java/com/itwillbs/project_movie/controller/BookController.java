package com.itwillbs.project_movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.project_movie.service.BookService;

@Controller
public class BookController {
	@Autowired private BookService service;
	
	@GetMapping("MovieScheduleInfo")
	public String movie_schedule_info() {
		return "book_tickets/movie_schedule_info";
	}
	
	@GetMapping("BookTickets")
	public String book_tickets() {
		return "book_tickets/book_tickets";
	}
	
	@GetMapping("BookSeat")
	public String book_seat() {
		return "book_tickets/book_seat";
	}

	@GetMapping("BookPay")
	public String book_pay() {
		return "book_tickets/book_pay";
	}

	@GetMapping("BookFinish")
	public String book_finish() {
		return "book_tickets/book_finish";
	}

	
	
	
	
	
	
	
	
	
	
}










