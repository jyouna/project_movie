package com.itwillbs.project_movie.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_movie.service.MypageService;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.PageInfo;
import com.itwillbs.project_movie.vo.ReservationCancelVO;
import com.itwillbs.project_movie.vo.ReservationDetailVO;
import com.itwillbs.project_movie.vo.WatchedMovieVO;

@Controller
public class MypageController {
	@Autowired
	private MypageService service;
	//1.결제내역 - 예매 내역
	@GetMapping("ReservationDetail")
	public String reservationDetail(@RequestParam (defaultValue="1") int pageNum, Model model) {
		int listCount = service.getReservationDetailCount();
		int listLimit = 10; 
		int startRow = (pageNum - 1) * listLimit; 
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1 : 0);
		if (maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum -1) / pageListLimit * pageListLimit +1;
		int endPage = startPage + pageListLimit -1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "ReservationDetail?pageNum=1");
			return "result/fail";
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageInfo);
		
		List<ReservationDetailVO> reservationDetail = service.getReservationDetail(startRow, listLimit);
		model.addAttribute("reservationDetail", reservationDetail);
		
		return "mypage/reservation/mypage_reservation_detail";
	}
	//1-1 상세정보 버튼 클릭시 창 띄우기
	@GetMapping("detail")
	public String detail() {
		return "mypage/reservation/detail";
	}
	//2. 결제내역 - 예매 취소내역 
	@GetMapping("ReservationCancel")
	public String reservationCancel(@RequestParam (defaultValue="1") int pageNum, Model model) {
		int listCount = service.getReservationCancelCount();
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1: 0);
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum -1) / pageListLimit * pageListLimit +1;
		int endPage = startPage + pageListLimit -1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "ReservationCancel?pageNum=1");
			return "result/fail";
		}
		PageInfo pageinfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageinfo);
		
		List<ReservationCancelVO> reservationCancel = service.getReservationCancel(startRow, listLimit);
		model.addAttribute("reservationCancel", reservationCancel);
		return "mypage/reservation/mypage_reservation_cancel";
	}
	//3. 무비로그 - 내가 본 영화
	@GetMapping("WatchedMovie")
	public String watchedMovie(@RequestParam(defaultValue="1") int pageNum, Model model) {
		int listCount = service.getWatchedMovieCount();
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1: 0);
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum -1) / pageListLimit * pageListLimit +1;
		int endPage = startPage + pageListLimit -1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "WatchedMovie?pageNum=1");
			return "result/fail";
		}
		PageInfo pageinfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageinfo);
		
		List<WatchedMovieVO> watchedMovie = service.getWatchedMovie(startRow, listLimit);
		model.addAttribute("watchedMovie", watchedMovie);
		
		return "mypage/movie_log/mypage_watched_movie";
	}
	//3-1. 리뷰 등록창 
	@GetMapping("reviewRegister")
	public String reviewRegister() {
		return "mypage/movie_log/review_register";
	}
	
	//4. 무비로그 - 관람평 
	@GetMapping("Review")
	public String review() {
		return "mypage/movie_log/mypage_review";
	}
	
	//4-1. 리뷰 수정 버튼
	@GetMapping("reviewModify")
	public String reviewModify() {
		return "mypage/movie_log/review_modify";
	}
	//5. 쿠폰 - 쿠폰 등록 
	@GetMapping("MycouponRegistration")
	public String mycouponRegistration() {
		return "mypage/mycoupon/mycoupon_registration";
	}
	
	@GetMapping("couponRegister")
	public String couponRegister() {
		return "mypage/mycoupon/coupon_register";
	}
	// 포인트
	@GetMapping("MypointReward")
	public String mypointReward() {
		return "mypage/mypoint/mypoint_reward";
	}
	//1:1 문의 - 글 목록
	@GetMapping("InquiryList")
	public String inquiryList(@RequestParam(defaultValue = "1") int pageNum, Model model) {
		int listCount = service.getInquiryListCount();
		int listLimit = 10;
		int startRow = (pageNum - 1) * listLimit; 
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1 : 0);
		if (maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum -1) / pageListLimit * pageListLimit +1;
		int endPage = startPage + pageListLimit -1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "InquiryList?pageNum=1");
			return "result/fail";
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageInfo);
		
		List<InquiryVO> inquiryList = service.getInquiryList(startRow, listLimit);
		model.addAttribute("inquiryList", inquiryList);
		return "mypage/inquiry/inquiry_list";
	}
	// 1:1문의 - 글 보기
	@GetMapping("InquiryPost")
	public String inquiryPost(Model model, int inquiry_code, InquiryVO inquiry) {
		inquiry = service.getInquiry(inquiry_code);
		if(inquiry == null) {
			model.addAttribute("msg", "존재하지 않는 게시물입니다.");
			return "result/fail";
		}
		model.addAttribute("inquiry", inquiry);
		return "mypage/inquiry/inquiry_post";
	}
	//1:1문의 - 글 작성 폼
	@GetMapping("InquiryWrite")
	public String inquiryWrite() {
		return "mypage/inquiry/inquiryWrite";
	}
	//1:1문의 - 글 수정 폼
	@GetMapping("InquiryModify")
	public String inquiryModify() {
		return "mypage/inquiry/inquiryModify";
	}
	
	
	//top에 있는 마이페이지 연결
	@GetMapping("MypageMain")
	public String MypageMain() {
		return"mypage/mypage_main";
	}
	
	
}
