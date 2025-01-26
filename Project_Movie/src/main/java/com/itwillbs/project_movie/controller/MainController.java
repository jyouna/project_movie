package com.itwillbs.project_movie.controller;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.service.CustomerServiceService;
import com.itwillbs.project_movie.service.EventService;
import com.itwillbs.project_movie.service.MovieService;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.FaqBoardVO;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;


@Controller
public class MainController {
	@Autowired
	private MovieService movieService;
	
	@Autowired
	private AdminManageService adminService;
	
	@Autowired
	private CustomerServiceService customerService;
	
	@Autowired
	private EventService eventService;
	
	// main페이지 맵핑
	@GetMapping("/")
	public String home(Model model) {
		// 공지사항 리스트 조회
		List<NoticeBoardVO> noticeList = customerService.getNoticeList(0, 5, "", "");
		// 자주하는 질문 리스트 조회
		List<FaqBoardVO> faqList = customerService.getFaqList(0, 5);
		// 이벤트 리스트 조회
		List<EventBoardVO> eventList = eventService.getEventList(0, 5, "", "");
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("faqList", faqList);
		model.addAttribute("eventList", eventList);
		
		return "main";
	}
	
	// 관리자 메인페이지 공지사항, 1:1문의 미답변 내역 조회
	@GetMapping("AdminpageMain")
	public String AdminpageMain(HttpSession session, Model model) {
		// 관리자 계정 로그인 판별
		if(session.getAttribute("admin_sId") == null) {
			return "adminpage/admin_manage/adminpage_login_form";
		} 
		
		List<NoticeBoardVO> noticeVo = adminService.getNoticeBoardList();
		List<InquiryVO> inquiryVo = adminService.getInquiryBoardList();
		model.addAttribute("noticeVo", noticeVo);
		model.addAttribute("inquiryVo", inquiryVo);

		return "adminpage/adminpage_main";
	}
	
	// 메인페이지 현재상영작 리스트 조회
	@ResponseBody
	@GetMapping("mainGetCurrentMovie")
	public List<MovieVO> mainGetCurrentMovie() {
		List<MovieVO> movieList = movieService.getCurrentlyMovieList();
		return movieList;
	}
	
	
}
