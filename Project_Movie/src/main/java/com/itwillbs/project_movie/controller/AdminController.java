package com.itwillbs.project_movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
	
	@GetMapping("AccountManage")
	public String accountManagement() {
		return "adminpage/adminpage_account_manage";
	}

	@GetMapping("AccountRegis")
	public String accountRegistration() {
		return "adminpage/adminpage_account_regis";
	}
	
	@GetMapping("idSearch")
	public String idSearch() {
		return "adminpage/id_search";
	}
	
	@GetMapping("memberList")
	public String memberList() {
		return "adminpage/member_list";
	}
	
	@GetMapping("statics_visitors")
	public String statics_visitors() {
		return "adminpage/statics_visitors";
	}

	@GetMapping("statics_sales")
	public String statics_sales() {
		return "adminpage/statics_sales";
	}
	
	@GetMapping("statics_voteResult")
	public String statics_preferredMovies() {
		return "adminpage/statics_voteResult";
	}
	
	@GetMapping("statics_newMembers")
	public String statics_newMembers() {
		return "adminpage/statics_newMembers";
	}
	
	@GetMapping("specificPeriodSearch")
	public String specificPeriodSearch() {
		return "adminpage/period_search";
	}

	@GetMapping("event_board_manage")
	public String eventBoard() {
		return "adminpage/event_board_manage";
	}

	@GetMapping("coupon_board_manage")
	public String couponBoard() {
		return "adminpage/coupon_board_manage";
	}

	@GetMapping("point_board_manage")
	public String pointBoard() {
		return "adminpage/point_board_manage";
	}
	
	@GetMapping("event_board_regis")
	public String eventBoardRegis() {
		return "adminpage/event_board_regis";
	}

	@GetMapping("event_board_modify")
	public String eventBoardModify() {
		return "adminpage/event_board_modify";
	}

	@GetMapping("coupon_board_regis")
	public String couponBoardRegis() {
		return "adminpage/coupon_board_regis";
	}

	@GetMapping("point_board_regis")
	public String pointBoardRegis() {
		return "adminpage/point_board_regis";
	}
}
