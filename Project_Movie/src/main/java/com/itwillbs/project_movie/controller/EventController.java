package com.itwillbs.project_movie.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_movie.service.EventService;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.PageInfo;

@Controller
public class EventController {
	@Autowired
	private EventService service;
	// 이벤트 - 글 목록
	@GetMapping("EventList")
	public String eventList(@RequestParam(defaultValue="") String searchType,
			@RequestParam(defaultValue ="") String searchKeyword,
			@RequestParam(defaultValue="1") int pageNum, Model model) {
		int listLimit = 10;
		int startRow = (pageNum - 1) * listLimit;
		int listCount = service.getEventListCount(searchType, searchKeyword);
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 :0);
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit -1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "EventList?pagenum=1");
			return "result/fail";
		}
		
		PageInfo pageinfo = new PageInfo (listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		model.addAttribute("pageInfo", pageinfo);
		List<EventBoardVO> eventList = service.getEventList(startRow, listLimit, searchType, searchKeyword);
		model.addAttribute("eventList", eventList);
		return "event/event_list";
	}
	// 이벤트 - 글 내용
	@GetMapping("EventPost")
	public String eventPost(EventBoardVO event, int event_code, Model model) {
		event = service.getEvent(event_code, true);
		if(event == null) {
			model.addAttribute("msg", "존재하지 않는 게시물입니다.");
			return "result/fail";
		}
		model.addAttribute("event", event);
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
