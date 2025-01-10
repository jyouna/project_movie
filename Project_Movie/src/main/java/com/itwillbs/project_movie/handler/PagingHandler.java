package com.itwillbs.project_movie.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.PageInfo;
import com.itwillbs.project_movie.vo.PointVO;

 /*
  *  페이징 처리를 대신하여 전달하는 핸들러!!
  *  출력할 게시판 종류(이벤트, 관리자, 멤버 등)에 따라 조건 설정 필요
  *  총 게시물 수를 DB에서 가져올 ListCount를 위해 호출할 service 함수 종류
  *  게시판 종류에 따른 정보를 DB에서 가져올 VO객체 종류 
  *  
  *  boardName이라는 파라미터값으로 전달받아 게시판 종류를 판별하여 각기 다르게 작동하도록 설정
  *  
  *  // 관리자 목록  -> adminList
  *  // 회원목록 	 -> memberList
  *  // 이벤트목록 	 -> eventBoardList
  *  // 이벤트당첨자 -> eventWinnerList
  *  // 쿠폰당첨자	 -> couponWinnerList
  *  // 쿠폰내역	 -> couponList
  *  // 포인트당첨자 -> pointWinnerList
  *  // 포인트내역   -> pointList
  */

@Component
public class PagingHandler {	
	
	@Autowired
	AdminManageService adminService;
	
	public Map<String, Object> pagingProcess(int pageNum, String boardName) {
		
		System.out.println("페이징 핸들러 호출");
		System.out.println("전달 받은 페이지 번호 : " + pageNum);
		System.out.println("전달 받은 호출코드 : " + boardName);
		
		Map<String, Object> pageMap = new HashMap<String, Object>(); // 리턴할 리스트 객체 2개를 저장할 변수
		List<?> voList = new ArrayList<>(); // 게시물 목록을 저장할 List객체
		
		int listLimit = 10;
		int startRow = (pageNum - 1) * listLimit;
		int listCount = adminService.getBoardListForPaging(boardName); // 서비스에서 boardName값 판별하여 다르게 작동!
		System.out.println("리스트 카운트 : " + listCount);
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);	
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum-1)/pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		if(pageNum < 1 || pageNum > maxPage) {
			return null;
		}	
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		// 페이징 정보 저장
		
		// 화면에 전달할 VO LIST 객체 생성.
		// startRow을 PageInfo 객체에 저장하면 단순해진다. 
		switch(boardName) {
			case "adminList" : voList = adminService.queryAdminList(startRow, listLimit); break;
			case "memberList" : voList = adminService.queryMemberList(startRow, listLimit); break;
//			case "eventBoardList" : voList = adminService.queryEventBoardList(startRow, listLimit); break;
//			case "eventWinnerList" : voList = adminService.queryEventWinnerList(startRow, listLimit); break;
//			case "couponWinnerList" : voList = adminService.queryEventWinnerList(startRow, listLimit); break; 
//			case "couponList" : voList = adminService.queryCouponList(startRow, listLimit); break;
//			case "pointWinnerList" : voList = adminService.queryPointWinnerList(startRow, listLimit); break;
//			case "pointList" : voList = adminService.queryPointList(startRow, listLimit); break;
		}
		
		pageMap.put("voList", voList); //
		pageMap.put("pageInfo", pageInfo);

		return pageMap;
	}

}
