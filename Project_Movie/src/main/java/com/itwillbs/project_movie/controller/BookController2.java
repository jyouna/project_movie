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
import com.itwillbs.project_movie.service.BookService2;
import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.ScheduleVO;
import com.itwillbs.project_movie.vo.SeatVO;
import com.itwillbs.project_movie.vo.TicketVO;

@Controller
public class BookController2 {
	@Autowired private BookService2 service;
	
	@ResponseBody
	@GetMapping("A")
	public List<MovieVO> a(@RequestParam Map<String, String> conditionMap) {
		List<MovieVO> movieList = service.getMovieList(conditionMap);
		return movieList;
	}
	
	@ResponseBody
	@GetMapping("B")
	public List<ScheduleVO> b(@RequestParam Map<String, String> conditionMap) {
		List<ScheduleVO> scheduleList = service.getScheduleList(conditionMap);
		
		// 시작, 끝 시간 형식변환
		for(ScheduleVO schedule: scheduleList) {
			SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm");
			schedule.setStr_start_time(timeFormatter.format(schedule.getStart_time()));
			schedule.setStr_end_time(timeFormatter.format(schedule.getEnd_time()));
		}
		
		return scheduleList;
	}
}










