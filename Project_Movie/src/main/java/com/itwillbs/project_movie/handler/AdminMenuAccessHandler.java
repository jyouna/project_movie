package com.itwillbs.project_movie.handler;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.vo.AdminRegisVO;

/* 로그인 및 관리자 페이지 좌측 메뉴별 접근 권한 처리
* ex) 이벤트 등록 페이지로 이동 시 해당 권한이 있어야만 접근 가능 
*/

public class AdminMenuAccessHandler {	
	
	// 1. 로그인 유무 판별, 로그인이 되어있지 않을 시 로그인 페이지로 이동
	public static Boolean adminLoginCheck(HttpSession session) {
		
		String admin_sId = (String)session.getAttribute("admin_sId");
		if(admin_sId == null) {
			return false;
		}
		return true; // 로그인 중일 시 true 리턴!
	}
	
	/* 2. 권한 정보 확인
	 * 	  로그인 된 계정의 정보를 vo로 받아와 해당 계정이 현재 접속하려는 메뉴의 권한을 가지고 있으면 true, 없으면 false 리턴
	 *    접속하려는 메뉴명은 문자열(String menu_name = "member_manage") 형태로 컨트롤러에서 전달
	*/ 
	
	public static Boolean adminMenuAccessCheck(String menu_name, HttpSession session, AdminManageService adminService) {
		// 로그인 중인 관리자 계정 정보 가져오기
		AdminRegisVO adminVo = adminService.accountModifyForm((String)session.getAttribute("admin_sId"));
		
		switch(menu_name.trim()) {
		// 관리자 계정, 회원목록, 통계관리 및 이벤트, 포인트, 쿠폰관리 권한
		// menu_name = "member_manage" 인 경우
		case "member_manage" : 
			if(!adminVo.getMember_manage() || adminVo.getMember_manage() == null) {
				return false;
			} else {
				return true;
			}
		// 영화관리 권한	
		case "movie_manage" :
			if(!adminVo.getMovie_manage() ||adminVo.getMovie_manage() == null) {
				return false;
			} else {
				return true;
			}
		// 고객지원(공지사항, FAQ, 1:1 문의) 관리 권한	
		case "board_manage" :
			if(!adminVo.getNotice_board_manage() || adminVo.getNotice_board_manage() == null) {
				return false;
			} else {
				return true;
			}
		// 결제관리 권한	
		case "payment_manage" :
			if(!adminVo.getPayment_manage() || adminVo.getPayment_manage() == null) {
				return false;
			} else {
				return true;
			}
		// 투표관리 권한	
		case "vote_manage" :
			if(!adminVo.getVote_manage() || adminVo.getVote_manage() == null) {
				return false;
			} else {
				return true;
			}
		// 영화관 관리 권한	
		case "theater_manage" :
			if(!adminVo.getTheater_manage() || adminVo.getTheater_manage() == null) {
				return false;
			} else {
				return true;
			}
		// 권한 명이 제대로 전달되지 않은 경우
		default : return false;
		}
	}
}

//Boolean member_manage = adminVo.getMember_manage(); 	 
//Boolean movie_manage = adminVo.getMovie_manage(); 		
//Boolean board_manage = adminVo.getNotice_board_manage(); 
//Boolean vote_manage = adminVo.getVote_manage(); 		 
//Boolean theater_manage = adminVo.getTheater_manage(); 	 
