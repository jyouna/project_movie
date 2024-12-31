package com.itwillbs.project_movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CustomerServiceController {
	// 공지사항 - 글 목록
	@GetMapping("NoticeList")
	public String noticeList() {
		return "customer_service/notice_list";
	}
	// 공지사항 - 글 내용
	@GetMapping("NoticePost")
	public String noticePost() {
		return "customer_service/notice_post";
	}
	// 자주하는 문의 - 글 목록
	@GetMapping("FaqList")
	public String faqList() {
		return "customer_service/faq_list";
	}
	// 자주하는 문의 - 글 내용
	@GetMapping("FaqPost")
	public String faqPost() {
		return "customer_service/faq_post";
	}
}