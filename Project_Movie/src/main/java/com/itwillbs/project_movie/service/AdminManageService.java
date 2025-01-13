package com.itwillbs.project_movie.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.AdminManageMapper;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.GetGiveCouponInfoVO;
import com.itwillbs.project_movie.vo.MemberAllInfoVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.PointVO;

@Service
public class AdminManageService {
	@Autowired
	private AdminManageMapper manageMapper;
	
	public int createAccount(AdminRegisVO adminVo) {
		return manageMapper.insertAccount(adminVo);
	}

	public int deleteAdminAccount(String id) {
		// TODO Auto-generated method stub
		return manageMapper.deleteAdminAccount(id);
	}

	public void regisEventBoard(EventBoardVO eventVo) {
		// TODO Auto-generated method stub
		manageMapper.insertEventBoard(eventVo);
	}

	public List<EventBoardVO> eventBoardList() {
		return manageMapper.selectEventBoardList();
	}
	
	public void setEventStart(int[] event_codes) {
		for(int event_code : event_codes) {
			manageMapper.updateEventStatusStart(event_code);
		}
	}

	public void setEventEnd(int[] event_codes) {
		for(int event_code : event_codes) {
			manageMapper.updateEventStatusEnd(event_code);
		}
	}

	public EventBoardVO updateEventBoard(int event_code) {
		// TODO Auto-generated method stub
		return manageMapper.getEventBoardList(event_code);
	}

	public String checkAdminId(String id) {
		// TODO Auto-generated method stub
		String checkIdResult = manageMapper.checkAdminId(id);
		
		if(checkIdResult == null) {
			return "사용 가능한 아이디";
		} else {
			return "이미 사용중인 아이디";
		}
	}

	public int getBoardListCount() {
		int listCount = manageMapper.getBoardListCount();
		return listCount;
	}

	public AdminRegisVO accountModifyForm(String admin_id) {
		// TODO Auto-generated method stub
		return manageMapper.selectAdminAccountInfo(admin_id);
	}

	public void accountModify(AdminRegisVO modifyVo) {
		// TODO Auto-generated method stub
		manageMapper.adminAccountModify(modifyVo);
	}

	public AdminRegisVO adminLogin(AdminRegisVO adminLoginInfo) {
		// TODO Auto-generated method stub
		return manageMapper.adminLogin(adminLoginInfo);
	}

	public List<AdminRegisVO> showEndEvent() {
		// TODO Auto-generated method stub
		return manageMapper.getEndEventList();
	}

	public EventBoardVO selectWinner(int event_code) {
		// TODO Auto-generated method stub
		return manageMapper.getEventBoardList(event_code);
	}

	public List<MemberVO> getMemberList() {
		// TODO Auto-generated method stub
		return manageMapper.selectMemberInfoForEvent();
	}

	public void insertCoupon(GetGiveCouponInfoVO vo) {
		
		String coupon_type = vo.getCoupon_type();
		int discount_amount = Integer.parseInt(vo.getDiscount_amount());
		int discount_rate = Integer.parseInt(vo.getDiscount_rate());
		int event_code = vo.getEvent_code();
		List<String> id = vo.getMember_id();
		int insertCount = 0;
		
		for(String member_id : id) {
			CouponVO coupon = new CouponVO();
			if(coupon_type.equals("금액할인")) {
				coupon.setCoupon_type(false);
			} else if(coupon_type.equals("할인율")){
				coupon.setCoupon_type(true);
			} 
			coupon.setCoupon_status(false);
			coupon.setDiscount_amount(discount_amount);
			coupon.setDiscount_rate(discount_rate);
			coupon.setExpired_date(vo.getExpired_date());
			coupon.setMember_id(member_id);
			coupon.setEvent_code(vo.getEvent_code());
			
			insertCount = manageMapper.insertCoupon(coupon);
			}
			if(insertCount > 0) {
				manageMapper.updateEventWinnerSetStatus(event_code); 
				// 당첨 완료 시 해당 이벤트 당첨 상태 true
			} else {
				System.out.println("쿠폰등록 실패");
			}
	}

	public EventBoardVO checkEventStatus(int event_code) {
		// TODO Auto-generated method stub
		return manageMapper.checkEventStatus(event_code);
	}

	public void GivePointToWinner(List<String> member_id, int event_code, int point_amount) {
		// TODO Auto-generated method stub
		// 1. 회원에게 포인트 + 시키고
		// 2. 포인트 테이블에 정보 저장
		// 3. 이벤트 당첨자 추첨 상태 true
		
		for(String id : member_id) {
			manageMapper.insertPointInfo(id, event_code, point_amount); // 포인트 변동 정보 저장
			manageMapper.creditPoint(id, point_amount); // 회원에게 포인트 + 시킴
		}
		
		manageMapper.updateEventWinnerSetStatus(event_code); // 당첨 완료 시 해당 이벤트 추첨 상태 true

	}

	public List<Map<String, String>> getCouponInfo() {
		// TODO Auto-generated method stub
		return manageMapper.getCouponInfo();
	}

	public List<MemberAllInfoVO> getMemberAllInfo() {
		// TODO Auto-generated method stub
		return manageMapper.getMemberAllInfo();
	}

	public int getBoardListForPaging(String boardName, String searchKeyword, String searchContent) {
		
		System.out.println("서비스까지 호출됨!!");
		int listCount = 0;
		/* boardName의 값에 따라 조회하는 테이블을 다르게 한다.
		// 관리자 목록  -> adminList
		// 회원목록 	 -> memberList
		// 이벤트목록 	 -> eventBoardList
		// 이벤트당첨자 -> eventWinnerList
		// 쿠폰당첨자	 -> couponWinnerList
		// 쿠폰내역	 -> couponList
		// 포인트당첨자 -> pointWinnerList
		// 포인트내역   -> pointList
		*/
		switch (boardName) {
		case "memberList" : 
			listCount = manageMapper.getMemberListCount(searchKeyword, searchContent); break;
		case "eventBoardList" : 
			listCount = manageMapper.getEventBoardListCount(searchKeyword, searchContent); break;
		case "couponWinnerList" : 
			listCount = manageMapper.getCouponWinnerListCount(searchKeyword, searchContent); break;
		case "pointWinnerList" : 
			listCount = manageMapper.getPointWinnerListCount(searchKeyword, searchContent); break;
		case "couponList" : 
			listCount = manageMapper.getCouponListCount(searchKeyword, searchContent); break;
		case "pointList" : 
			listCount = manageMapper.getPointListCount(searchKeyword, searchContent); break;
		}
		return listCount;
	}
	
	// 검색기능 없는 게시판용 오버로딩
	public int getBoardListForPaging(String boardName) {
		
		System.out.println("서비스까지 호출됨!!");
		int listCount = 0;
		
		switch (boardName) {
		case "adminList" :
			listCount = manageMapper.getAdminListCount(); break;
		}
		return listCount;
	}

	// 관리자 계정 리스트 조회
	public List<AdminRegisVO> queryAdminList(int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return manageMapper.selectAdminPagingListPaging(startRow, listLimit);
	}

	// 회원 리스트 조회
	public List<MemberAllInfoVO> queryMemberList(int startRow, int listLimit, String searchKeyword, String searchContent) {
		// TODO Auto-generated method stub
		return manageMapper.selectMemberListPaging(startRow, listLimit, searchKeyword, searchContent);
	}

	// 이벤트 게시판 리스트 조회
	public List<EventBoardVO> eventBoardList(int startRow, int listLimit, String searchKeyword, String searchContent) {
		// TODO Auto-generated method stub
		return manageMapper.selectEventBoardList(startRow, listLimit, searchKeyword, searchContent);
	}
	
	// 쿠폰 당첨자 리스트 조회
	public List<EventWinnerVO> getEventWinnerList(int startRow, int listLimit, String searchKeyword, String searchContent) { // 쿠폰 당첨자 리스트 
		// TODO Auto-generated method stub
		return manageMapper.selectAllEventWinner(startRow, listLimit, searchKeyword, searchContent);
	}

	// 포인트 당첨자 리스트 조회
	public List<EventWinnerVO> getPointWinnerList(int startRow, int listLimit, String searchKeyword, String searchContent) { // 포인트 당첨자 리스트
		// TODO Auto-generated method stub
		return manageMapper.getPointWinnerList(startRow, listLimit, searchKeyword, searchContent);
	}
	
	// 쿠폰 테이블 조회
	public List<CouponVO> getCouponList(int startRow, int listLimit, String searchKeyword, String searchContent) {
		// TODO Auto-generated method stub
		return manageMapper.getCouponList(startRow, listLimit, searchKeyword, searchContent);
	}
	
	// 포인트 테이블 조회
	public List<PointVO> getPointRecord(int startRow, int listLimit, String searchKeyword, String searchContent) {
		// TODO Auto-generated method stub
		return manageMapper.getPointRecord(startRow, listLimit, searchKeyword, searchContent);
	}

	public int monthlyTotalNewMemberStatics(int year, int month) {
		// TODO Auto-generated method stub
		return manageMapper.getMonthlyTotalNewMember(year, month);
	}

	public Map<String, Object> getMonthlyNewMember(int year) {
		// TODO Auto-generated method stub
		
		Map<String, Object> map = new HashMap<String, Object>();
		String[] arr = {"", "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"};
		
		for(int i = 1; i <= 12; i++) {
			int monthlyCount = manageMapper.getMonthlyTotalNewMember(year, i);
			map.put(arr[i], monthlyCount);
			System.out.println(arr[i] + " 가입자 : " + monthlyCount);
//			System.out.println("월별 통계 : " + map);
		}
		
		System.out.println("map에 저장된 값 : " + map);
		
		return map;
	}


}
