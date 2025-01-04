package com.itwillbs.project_movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {
	//1.결제내역 - 예매 내역
	@GetMapping("ReservationDetail")
	public String reservationDetail() {
		return "mypage/reservation/mypage_reservation_detail";
	}
	//1-1 상세정보 버튼 클릭시 창 띄우기
	@GetMapping("detail")
	public String detail() {
		return "mypage/reservation/detail";
	}
	//2.결제내역 - 예매 취소내역 
	@GetMapping("ReservationCancel")
	public String reservationCancel() {
		return "mypage/reservation/mypage_reservation_cancel";
	}
	//3. 무비로그 - 내가 본 영화
	@GetMapping("WatchedMovie")
	public String watchedMovie() {
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
	// 1:1문의 - 글 보기
	@GetMapping("InqueryPost")
	public String inqueryPost() {
		return "mypage/inquery/inquery_post";
	}
	//1:1 문의 - 글 목록
	@GetMapping("InqueryList")
	public String inqueryList() {
		return "mypage/inquery/inquery_list";
	}
	//1:1문의 - 글 작성 폼
	@GetMapping("InqueryWriteForm")
	public String inqueryWriteForm() {
		return "mypage/inquery/inquery_write_form";
	}
	//top에 있는 마이페이지 연결
	@GetMapping("MypageMain")
	public String MypageMain() {
		return"mypage/mypage_main";
	}
	
	
}
