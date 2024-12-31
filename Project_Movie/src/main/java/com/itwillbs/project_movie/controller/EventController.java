package com.itwillbs.project_movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EventController {
	// 이벤트 - 글 목록
	@GetMapping("EventList")
	public String eventList() {
		return "event/event_list";
	}
	// 이벤트 - 글 내용
	@GetMapping("EventPost")
	public String eventPost() {
		return "event/event_post";
	}
	
	// 이벤트 - 당첨자 목록
	@GetMapping("EventWinner")
	public String eventWinner() {
		return "event/event_winner";
	}
	// 이벤트 - 당첨자 글 내용
	@GetMapping("EventWinnerPost")
	public String eventWinnerPost() {
		return "event/event_winner_post";
	}
}
