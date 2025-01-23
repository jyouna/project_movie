package com.itwillbs.project_movie.controller;
//장민기 20250123
import com.itwillbs.project_movie.service.AdminReviewService;

import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.handler.AdminMenuAccessHandler;
import com.itwillbs.project_movie.handler.PagingHandler;
import com.itwillbs.project_movie.service.MypageService;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.GetGiveCouponInfoVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.PageInfo;
import com.itwillbs.project_movie.vo.PageInfo2;
import com.itwillbs.project_movie.vo.PointVO;

import retrofit2.http.GET;

@Controller
public class AdminReviewController {

	// service는 MypageService의 
	// 마이페이지 리뷰관리 서비스와 매핑 
	// 65번행부터~
	@Autowired
	//private MypageService service;
	private AdminReviewService service;
	
	
	
	//리뷰 관리 게시판
	@GetMapping("AdminReviewManage")
	public String review(Model model, HttpSession session,@RequestParam(defaultValue="1") int pageNum ) {
		
		/*
		String id = (String)session.getAttribute("sMemberId");
		if(session.getAttribute("admin_sId") == null) {
		if(id == null) {
			model.addAttribute("msg", "관리자 로그인 후 이용가능합니다.");
			return "result/process";
		}
		*/
		String id = (String)session.getAttribute("admin_sId");
		
		
		// 관리자아이디로 로그인 됐는지 확인
		if(id == null) {
			model.addAttribute("msg", "관리자 로그인 후 이용가능합니다.");
			return "result/process";
		}
		
		//리뷰 관리 게시판의 게시판설정
		int listCount = service.getReviewListCount(); //id *****
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
			model.addAttribute("targetURL", "Review?pageNum=1");
			return "result/process";
		}
		PageInfo pageinfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageinfo);
		
		List<Map<String, Object>> reviewList = service.getReviewList(startRow, listLimit); //id*****
		model.addAttribute("reviewList", reviewList);
		
		return "adminpage/review_manage/admin_review_manage";
	}
	
/*
	@PostMapping("AdminReviewManage")
	public String AdminReviewManageForm() {
		return "adminpage/review_manage/admin_review_manage";
	}
*/	
	
	//리뷰 수정
	@PostMapping("AdminReviewModify")
	public String reviewModify(Model model,@RequestParam Map<String, String> map) {
		System.out.println("리뷰수정-map 정보" + map); 
		int updateCount = service.getReviewModify(map);
		if(updateCount > 0) {
			model.addAttribute("msg", "리뷰 수정 1");
			return "redirect:/AdminReviewManage";
		}else {
			model.addAttribute("msg", "리뷰 수정 2");
			return "result/process";
		}

	}
	//리뷰 삭제 
	@GetMapping("AdminReviewDelete")
	public String reviewDelete(Model model,@RequestParam Map<String, String> map) {
		System.out.println("리뷰삭제-map 정보" + map); 
		int deleteCount = service.removeReview(map);
		if(deleteCount > 0) {
			model.addAttribute("msg", "리뷰 삭제 1.");
			return "redirect:/AdminReviewManage";
		}else {
			model.addAttribute("msg", "리뷰 삭제 2.");
			return "result/process";
		}
		
	}
}

