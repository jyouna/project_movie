package com.itwillbs.project_movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminSettingController {
	
	@GetMapping("AdminAccountManage")
	public String adminAccountManagement() {
		return "adminpage/admin_manage/adminpage_account_manage";
	}

	@GetMapping("AdminAccountRegis")
	public String adminAccountRegistration() {
		return "adminpage/admin_manage/adminpage_account_regis";
	}
	
	@GetMapping("IdSearch")
	public String idSearch() {
		return "adminpage/id_search";
	}
	
	@GetMapping("MemberList")
	public String memberList() {
		return "adminpage/member_manage/member_list";
	}
	
	@GetMapping("StaticsVisitors")
	public String staticsVisitors() {
		return "adminpage/statics_manage/statics_visitors";
	}

	@GetMapping("StaticsSales")
	public String staticsSales() {
		return "adminpage/statics_manage/statics_sales";
	}
	
	@GetMapping("StaticsVoteResult")
	public String staticsVoteResult() {
		return "adminpage/statics_manage/statics_voteResult";
	}
	
	@GetMapping("StaticsNewMembers")
	public String staticsNewMembers() {
		return "adminpage/statics_manage/statics_newMembers";
	}
	
	@GetMapping("SpecificPeriodSearch")
	public String specificPeriodSearch() {
		return "adminpage/specific_period_search";
	}

	@GetMapping("CouponBoardManage")
	public String couponBoardManagement() {
		return "adminpage/coupon_manage/coupon_board_manage";
	}
	
	@GetMapping("CouponBoardRegis")
	public String couponBoardRegistration() {
		return "adminpage/coupon_manage/coupon_board_regis";
	}

	@GetMapping("PointBoardManage")
	public String pointBoardManagement() {
		return "adminpage/point_manage/point_board_manage";
	}
	
	@GetMapping("PointBoardRegis")
	public String pointBoardRegistration() {
		return "adminpage/point_manage/point_board_regis";
	}
	
	@GetMapping("EventBoardManage")
	public String eventBoardManagement() {
		return "adminpage/event_manage/event_board_manage";
	}
	
	@GetMapping("EventBoardRegis")
	public String eventBoardRegistration() {
		return "adminpage/event_manage/event_board_regis";
	}

	@GetMapping("EventBoardModify")
	public String eventBoardModify() {
		return "adminpage/event_manage/event_board_modify";
	}

}

