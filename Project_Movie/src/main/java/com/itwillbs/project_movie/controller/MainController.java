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

import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.vo.FaqBoardVO;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;


@Controller
public class MainController {
	@Autowired
	AdminManageService adminService;
	
	// main페이지 맵핑
	@GetMapping("/")
	public String home() {
		return "main";
	}
	
	// 관리자 메인페이지
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
	
}
