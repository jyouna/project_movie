package com.itwillbs.project_movie.handler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.vo.PageInfo2;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

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
@AllArgsConstructor
@NoArgsConstructor
public class PagingHandler {	
	
	@Autowired
	AdminManageService adminService;
	
	public PageInfo2 pagingProcess(int pageNum, String boardName, String searchKeyword, String searchContent) {
		System.out.println("일반 페이징 서비스 호출");
		System.out.println("페이징 핸들러 호출");
		System.out.println("전달 받은 페이지 번호 : " + pageNum);
		System.out.println("전달 받은 호출코드 : " + boardName);
		
		int listLimit = 20;
		int startRow = (pageNum - 1) * listLimit;
		int listCount = adminService.getBoardListForPaging(boardName, searchKeyword, searchContent); // 서비스에서 boardName값 판별하여 다르게 작동!
		System.out.println("리스트 카운트 : " + listCount);

		int pageListLimit = 10;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);	
		System.out.println("MaxPage 값 1번 : " + maxPage);

		if(maxPage == 0) {
			maxPage = 1;
		}
		
		System.out.println("pageNum 1번 : " + pageNum);
		int startPage = (pageNum-1)/pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;	

		if(endPage > maxPage) {
			endPage = maxPage;
		System.out.println("pageNum 2번 : " + pageNum);
		}
		
		if(pageNum > maxPage) {
			pageNum = 1;
		}

		if(pageNum < 1 || pageNum > maxPage) {
			System.out.println("pageNum 3번" + pageNum);
			System.out.println("MaxPage 값 2번 : " + maxPage);
			return null;
		}	
		
		PageInfo2 pageInfo = new PageInfo2(listCount, pageListLimit, maxPage, startPage, endPage, pageNum, listLimit, startRow);
		return pageInfo;
	}

	// 검색기능 없는 게시판을 위한 오버로딩!!
	public PageInfo2 pagingProcess(int pageNum, String boardName) {
		System.out.println("오버로딩 페이징 서비스 호출");
		int listLimit = 20;
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
		// 2번 페이지로 와서 검색하는 경우 maxPage보다 pageNum이 큰 경우가 발생하게 되므로 1페이지로 변경시킴.
		if(pageNum > maxPage) {
			pageNum = 1;
		}
		if(pageNum < 1 || pageNum > maxPage) {
			return null;
		}	
		PageInfo2 pageInfo = new PageInfo2(listCount, pageListLimit, maxPage, startPage, endPage, pageNum, listLimit, startRow);
		return pageInfo;
	}
	
	// 이벤트 게시판 별도 페이징 처리
	public PageInfo2 pagingProcess(int pageNum, String boardName, String searchKeyword, String searchContent, String eventStatus, String eventWinnerStatus) {
		System.out.println("일반 페이징 서비스 호출");
		System.out.println("페이징 핸들러 호출");
		System.out.println("전달 받은 페이지 번호 : " + pageNum);
		System.out.println("전달 받은 호출코드 : " + boardName);
		
		int listLimit = 20;
		int startRow = (pageNum - 1) * listLimit;
		int listCount = adminService.getBoardListForPaging(boardName, searchKeyword, searchContent, eventStatus, eventWinnerStatus); // 서비스에서 boardName값 판별하여 다르게 작동!
		System.out.println("리스트 카운트 : " + listCount);

		int pageListLimit = 10;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);	
		System.out.println("MaxPage 값 1번 : " + maxPage);

		if(maxPage == 0) {
			maxPage = 1;
		}
		
		System.out.println("pageNum 1번 : " + pageNum);
		int startPage = (pageNum-1)/pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;	

		if(endPage > maxPage) {
			endPage = maxPage;
		System.out.println("pageNum 2번 : " + pageNum);
		}
		
		if(pageNum > maxPage) {
			pageNum = 1;
		}

		if(pageNum < 1 || pageNum > maxPage) {
			System.out.println("pageNum 3번" + pageNum);
			System.out.println("MaxPage 값 2번 : " + maxPage);
			return null;
		}	
		
		PageInfo2 pageInfo = new PageInfo2(listCount, pageListLimit, maxPage, startPage, endPage, pageNum, listLimit, startRow);
		return pageInfo;
	}
}
