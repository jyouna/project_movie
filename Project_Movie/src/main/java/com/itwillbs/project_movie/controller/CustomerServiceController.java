package com.itwillbs.project_movie.controller;

import java.net.http.HttpClient.Redirect;
import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_movie.service.CustomerServiceService;
import com.itwillbs.project_movie.vo.FaqBoardVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;
import com.itwillbs.project_movie.vo.PageInfo;

@Controller
public class CustomerServiceController {
	@Autowired 
	private CustomerServiceService service;
	// 공지사항 - 글 목록
	@GetMapping("NoticeList")
	public String noticeList(Model model, @RequestParam(defaultValue = "1") int pageNum ) {
		int listLimit = 5; // 한 페이지 당 표시할 게시물 수
		int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 DB 행 번호
		int listCount = service.getNoticeListCount();
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1 : 0);
		if (maxPage == 0) {
			maxPage = 1;
		}
		
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; 
		int endPage = startPage + pageListLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}		
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다");
			model.addAttribute("targetURL", "NoticeList?pageNum=1");
			return "result/fail";
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		model.addAttribute("pageInfo", pageInfo);
		List<NoticeBoardVO> noticeList = service.getNoticeList(startRow, listLimit);
		model.addAttribute("noticeList", noticeList);
		return "customer_service/notice_list";
	}
	
	// 공지사항 - 글 내용
	@GetMapping("NoticePost")
	public String noticePost(NoticeBoardVO notice, int notice_code, Model model) {
		notice = service.getNotice(notice_code, true);
		if(notice == null) {
			model.addAttribute("msg", "존재하지 않는 게시물입니다.");
			return "result/fail";
		}
		model.addAttribute("notice", notice);
		
		return "customer_service/notice_post";
	}

	// 자주하는 문의 - 글 목록
	@GetMapping("FaqList")
	public String faqList(Model model, @RequestParam(defaultValue = "1") int pageNum ) {
		int listLimit = 5; // 한 페이지 당 표시할 게시물 수
		int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 DB 행 번호
		int listCount = service.getNoticeListCount();
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1 : 0); // 최대 페이지
		if (maxPage == 0) {
			maxPage = 1;
		}
		//현재 페이지에서 보여줄 시작 페이지 번호 (하단의 번호임)
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; 
		//현재 페이지에서 보여줄 끝 페이지 번호 (하단의 번호) 
		int endPage = startPage + pageListLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}		
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다");
			model.addAttribute("targetURL", "FaqList?pageNum=1");
			return "result/fail";
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		model.addAttribute("pageInfo", pageInfo);
		List<FaqBoardVO> faqList = service.getFaqList(startRow, listLimit);
		model.addAttribute("faqList", faqList);
		return "customer_service/faq_list";
	}
	// 자주하는 문의 - 글 내용
	@GetMapping("FaqPost")
	public String faqPost(Model model, FaqBoardVO faq, int faq_code ) {
		faq = service.getFaq(faq_code, true);
		if(faq == null) {
			model.addAttribute("msg", "존재하지 않는 게시물입니다.");
			return "result/fail";
		}
		model.addAttribute("faq", faq);
		return "customer_service/faq_post";
	}
	
}