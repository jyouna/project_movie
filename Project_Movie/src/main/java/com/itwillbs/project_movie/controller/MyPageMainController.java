package com.itwillbs.project_movie.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.project_movie.service.MemberService;
import com.itwillbs.project_movie.service.MypageService;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.MemberVO;
@Controller
public class MyPageMainController {
	@Autowired
	private MypageService service;
	@Autowired
	private MemberService memberService;
	
	@GetMapping("MypageMain")
	public String MypageMain( Model model, HttpSession session) {
		//로그인 여부 확인
		String id = (String)session.getAttribute("sMemberId");
		if(id == null) {
			model.addAttribute("msg", "로그인 후 이용해주세요.");
			return "result/process";
		}
		List<Map<String, Object>> reservationList = service.getReservationList(id);
		model.addAttribute("reservationList", reservationList);
		List<Map<String, String>> couponList = service.getCouponList(id);
		model.addAttribute("couponList", couponList);
		List<Map<String, String>> pointList = service.getPointList(id);
		model.addAttribute("pointList", pointList);
		List<InquiryVO> inquiryList = service.getInquiryList(id);
		model.addAttribute("inquiryList", inquiryList);
		MemberVO member = memberService.getMember(id);
		model.addAttribute("member", member);
		return "mypage/mypage_main";
	}
}
