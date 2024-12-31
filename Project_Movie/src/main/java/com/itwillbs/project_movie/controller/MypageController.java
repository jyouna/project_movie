package com.itwillbs.project_movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {
	//결제내역 - 예매 취소내역 
	@GetMapping("ReservationCancel")
	public String reservationCancel() {
		return "mypage/reservation/mypage_reservation_cancel";
	}
	//결제내역 - 예매 내역
	@GetMapping("ReservationDetail")
	public String reservationDetail() {
		return "mypage/reservation/mypage_reservation_detail";
	}
	//무비로그 - 관람평 
	@GetMapping("Review")
	public String review() {
		return "mypage/movie_log/mypage_review";
	}
	//무비로그 - 내가 본 영화
	@GetMapping("WatchedMovie")
	public String watchedMovie() {
		return "mypage/movie_log/mypage_watched_movie";
	}
	// 포인트
	@GetMapping("MypointReward")
	public String mypointReward() {
		return "mypage/mypoint/mypoint_reward";
	}
	//쿠폰 - 쿠폰 등록 
	@GetMapping("MycouponRegistration")
	public String mycouponRegistration() {
		return "mypage/mycoupon/mycoupon_registration";
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
	
	
	
}
