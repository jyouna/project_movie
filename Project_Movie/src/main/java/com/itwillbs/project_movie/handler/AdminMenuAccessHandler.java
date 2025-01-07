package com.itwillbs.project_movie.handler;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.vo.AdminRegisVO;

// 로그인 및 관리자 페이지 좌측 메뉴별 접근 권한 처리 로직
/* ex) 이벤트 등록 페이지로 이동 시 해당 권한이 있어야만 접근 가능 
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
	
	// 2. 권한 정보 확인
	public static Boolean adminMenuAccessCheck(String menu_name, HttpSession session, AdminManageService adminService) {
		AdminRegisVO adminVo = adminService.accountModifyForm((String)session.getAttribute("admin_sId"));
		Boolean member_manage = adminVo.getMember_manage(); // 관리자 계정, 회원목록 및 통계관리 및 이벤트, 포인트, 쿠폰관리  권한
		Boolean movie_manage = adminVo.getMovie_manage(); // 영화관리 권한
		Boolean board_manage = adminVo.getNotice_board_manage(); // 고객지원(공지사항, FAQ, 1:1 문의) 관리 권한
		Boolean payment_manage = adminVo.getPayment_manage(); // 결제관리 권한
		Boolean vote_manage = adminVo.getVote_manage(); // 투표관리 권한
		Boolean theater_manage = adminVo.getTheater_manage(); // 영화관 관리 권한
	
		switch(menu_name.trim()) {
		case "member_manage" :
			if(!member_manage || member_manage == null) {
				return false;
			} else {
				return true;
			}
		case "movie_manage" :
			if(!movie_manage || movie_manage == null) {
				return false;
			} else {
				return true;
			}
		case "board_manage" :
			if(!board_manage || board_manage == null) {
				return false;
			} else {
				return true;
			}
		case "payment_manage" :
			if(!payment_manage || payment_manage == null) {
				return false;
			} else {
				return true;
			}
		case "vote_manage" :
			if(!vote_manage || vote_manage == null) {
				return false;
			} else {
				return true;
			}
		case "theater_manage" :
			if(!theater_manage || theater_manage == null) {
				return false;
			} else {
				return true;
			}
		default : return false;
		}
	}
}
