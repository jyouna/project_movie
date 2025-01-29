package com.itwillbs.project_movie.controller;
//장민기 20250128
import com.itwillbs.project_movie.service.MemberService;
import com.itwillbs.project_movie.service.AdminManageService;

import java.util.HashMap;
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
   private MemberService service;
   @Autowired
   private AdminManageService adminService;
   
   
   //리뷰 관리 게시판
   @GetMapping("AdminReviewManage")
   public String review(Model model, HttpSession session, @RequestParam(defaultValue = "") String searchType,
         @RequestParam(defaultValue = "") String searchKeyword, @RequestParam(defaultValue="1") int pageNum ) {
      
      // 로그인 유무 판별
      if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
         model.addAttribute("msg", "로그인 후 이용가능");
         model.addAttribute("targetURL", "AdminLogin");
         return "result/process";
      }
      
      // 관리자 메뉴 접근권한 판별
      if(!AdminMenuAccessHandler.adminMenuAccessCheck("board_manage", session, adminService)) {
         model.addAttribute("msg", "접근 권한이 없습니다.");
         model.addAttribute("targetURL", "AdminpageMain");
         return "result/process";
      }
      
      //리뷰 관리 게시판의 게시판설정
      int listCount = service.getReviewListCount(); //id *****
      int listLimit = 10;
      int startRow = (pageNum - 1) * listLimit;
      int pageListLimit = 10;
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
         model.addAttribute("targetURL", "AdminReviewManage?pageNum=1");
         return "result/process";
      }
      PageInfo pageinfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
      model.addAttribute("pageInfo", pageinfo);
      
      List<Map<String, Object>> reviewList = service.getReviewList(startRow, listLimit, searchType, searchKeyword); //id*****
      model.addAttribute("reviewList", reviewList);
      
      return "adminpage/review_manage/admin_review_manage";
   }
   
/*
   @PostMapping("AdminReviewManage")
   public String AdminReviewManageForm() {
      return "adminpage/review_manage/admin_review_manage";
   }
*/   
   
 
	// 리뷰 수정 (review_code 기반)
   @PostMapping("AdminReviewModify")
   public String reviewModify(Model model,
       @RequestParam("review_code") String review_code,
       @RequestParam("review_content") String review_content) {

       int updateCount = service.modifyReview(review_code, review_content);

       
       if(updateCount > 0) {
           model.addAttribute("msg", "리뷰 수정 성공");
           return "redirect:/AdminReviewManage";
       } else {
           model.addAttribute("msg", "리뷰 수정 실패");
           return "result/process";
       }
   }//	@PostMapping("AdminReviewModify")

	
	// 리뷰 삭제 (review_code 기반)
   @GetMapping("AdminReviewDelete")
   public String reviewDelete(Model model, @RequestParam("review_code") String review_code) {
       int deleteCount = service.deleteReview(review_code);  // 🔹 review_code 직접 전달

	    
	    if(deleteCount > 0) {
	        model.addAttribute("msg", "리뷰 삭제 성공");
	        return "redirect:/AdminReviewManage";
	    } else {
	        model.addAttribute("msg", "리뷰 삭제 실패");
	        return "result/process";
	    }
	} //@GetMapping("AdminReviewDelete")
 
}

