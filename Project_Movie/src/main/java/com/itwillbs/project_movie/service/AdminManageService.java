package com.itwillbs.project_movie.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_movie.mapper.AdminManageMapper;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.GetGiveCouponInfoVO;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.MemberAllInfoVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;
import com.itwillbs.project_movie.vo.PaymentVO;
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
	
	
	// 이벤트 당첨자 포인트 발급
	// 1. 회원에게 포인트 + 시키고
	// 2. 포인트 테이블에 정보 저장
	// 3. 이벤트 당첨자 추첨 상태 true
	@Transactional
	public void GivePointToWinner(List<String> member_id, int event_code, int point_amount) {
		// TODO Auto-generated method stub
		
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
	
	
	// 페이징 처리 시 해당 게시판 별 행 개수 조회
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
		case "eventWinnerList" :
			listCount = manageMapper.getAllEventWinnerCount(searchKeyword, searchContent); break;
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
	
	// 2, 3번 차트 월 가입자 수 조회
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
		}
		
		System.out.println("map에 저장된 값 : " + map);
		
		return map;
	}

	public int modifyEventBoard(EventBoardVO eventVo) {
		// TODO Auto-generated method stub
		return manageMapper.modifyEventBoard(eventVo);
	}

	public int deleteEvent(int event_code) {
		// TODO Auto-generated method stub
		// 이벤트 삭제 전 상태 값 검사. 
		// 2의 경우 이미 종료된 이벤트이므로 삭제 불가.
		int event_status = checkEventStatusForDelete(event_code);
		
		if(event_status != 2) {
			return manageMapper.deleteEventBoard(event_code);
		} else {
			return 0;
		}
	}
	// 이벤트 삭제 전 상태 값 반환
	public int checkEventStatusForDelete(int event_code) {
		return manageMapper.checkEventStatusForDelete(event_code);
	}

	public int getMemberCount(String searchKeyword, String searchContent) {
		// TODO Auto-generated method stub
		return manageMapper.getMemberCount(searchKeyword, searchContent);
	}
	
	// 4번 차트 전체 기간 (2020~2025) 가입자 출력
	// 파라미터로 [period : 2025,2024,2023,2022,2021,2020] 전달 받기에 Map<List<>> 형태로 전달 받음 
	public Map<String, String> getTotalMemberJoinStatics(Map<String, List<String>> period) {
		// TODO Auto-generated method stub
		List<String> list = period.get("period"); // {2025,2024,2023,2022,2021,2020} 값만 별도로 저장
		Map<String, String> map = new HashMap<String, String>(); // {연도 : 매출액} 형태로 저장해서 전달하기 위한 Map 객체

		System.out.println("서비스 리스트 객체 저장한 값 : " + list);
		
		for(String year : list) { // {2020 : 14,543}, {2021 : 15,123} 이런 형태로 저장
			map.put(year, manageMapper.getTotalPeriodMemberJoin(year));
		}
		System.out.println("서비스 map에 저장받은 값 : " + map);
		
		return map;
	}

	public void createMembers(MemberVO member) {
		manageMapper.createMembers(member);
		// TODO Auto-generated method stub
		
	}

	public List<EventWinnerVO> getAllEventWinnerList(int startRow, int listLimit, String searchKeyword, String searchContent) {
		// TODO Auto-generated method stub
		return manageMapper.getAllEventWinnerList(startRow, listLimit, searchKeyword, searchContent);
	}

	public int getWinnerCount(String searchKeyword, String searchContent) {
		// TODO Auto-generated method stub
		return manageMapper.getAllEventWinnerCount(searchKeyword, searchContent);
	}
	
	// 메인화면 이벤트 당첨자 목록 출력
	public List<EventWinnerVO> getWinnerList(int event_code) {
		// TODO Auto-generated method stub
		return manageMapper.getWinnerList(event_code);
	}
	
	// 이벤트 당첨자 팝업창에 당첨자 수 ajax 전달 
	public int getSingEventWinnerCount(int event_code) {
		// TODO Auto-generated method stub
		return manageMapper.getSingleEventWinnerCount(event_code);
	}

	// 관리자 메인화면 출력 공지사항 게시판 리스트 출력
	public List<NoticeBoardVO> getNoticeBoardList() {
		// TODO Auto-generated method stub
		return manageMapper.getNoticeBoardList();
	}
	
	// 관리자 메인화면 1:1문의 게시판 리스트 출력
	public List<InquiryVO> getInquiryBoardList() {
		// TODO Auto-generated method stub
		return manageMapper.getInquiryBoardList();
	}

	// 마이페이지 회원 정보 조회
	public MemberVO getMyInfo(String sMemberId) {
		// TODO Auto-generated method stub
		return manageMapper.getMyInfo(sMemberId);
	}
	
	// 회원정보 변경 시 기존 비밀번호 일치 여부 체크
	public String getDbPasswd(String member_id) {
		// TODO Auto-generated method stub
		return manageMapper.getDbPasswd(member_id);
	}
	
	// 마이페이지 회원 정보 수정
	public int updateMyInfo(MemberVO member) {
		// TODO Auto-generated method stub
		return manageMapper.updateMyInfo(member);
	}
	
	// 매출 데이터 매크로 생성 
	public void createSalesRecord(PaymentVO payment) {
		// TODO Auto-generated method stub
		manageMapper.createSalesRecord(payment);
	}

	
	// 전년도 월간 매출 조회
	public Map<String, Object> getYearSales(int year) {
		// TODO Auto-generated method stub
		// 월별 매출액 조회
		// 월별 환불액 조회 
		// 월별 최종 매출액 = 월별 매출액(결제상태1) - 월별 환불액(환불상태1, 환불일자 기준) 
		
		Map<String, Object> map = new HashMap<String, Object>();
		String[] arr = {"", "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"};
		
		for(int i = 1; i <= 12; i++) {
			// 월별 매출액
			int monthlySales = manageMapper.getMonthlySales(year, i);
			// 월별 환불금액
			int monthlyRefund = manageMapper.getMonthlyRefund(year, i);
			System.out.println(arr[i] + "월 매출액 : " + monthlySales);
			System.out.println(arr[i] + "월 환불액 : " + monthlyRefund);
			map.put(arr[i], (monthlySales-monthlyRefund));
			System.out.println(arr[i] + "월 순매출액 : " + (monthlySales-monthlyRefund));
		}
		System.out.println("map에 저장된 값 : " + map);
		
		return map;
		
	}
	
	// 2, 3번 차트 해당 월 매출액 리턴
	public int getMonthSales(int year, int month) {
		// 월 매출액
		int monthSales = manageMapper.getMonthlySales(year, month);
		// 월 환불액
		int monthRefund = manageMapper.getMonthlyRefund(year, month);
		// TODO Auto-generated method stub
		return (monthSales-monthRefund); 
	}

	// 4번 차트 전체 기간 (2020 ~ 2025) 연 단위 매출액 조회
	public Map<Integer, Integer> getAnnualSales(Map<String, List<Integer>> period) {
		// TODO Auto-generated method stub
		
		List<Integer> list = period.get("period"); // {2025,2024,2023,2022,2021,2020} 값만 별도로 저장
		Map<Integer, Integer> map = new HashMap<Integer, Integer>(); // {연도 : 매출액} 형태로 저장해서 전달하기 위한 Map 객체
		
		for(int year : list) { // {2020 : 14,543}, {2021 : 15,123} 이런 형태로 저장
			// 연 매출액
			int annualSales = manageMapper.getAnnualSales(year);
			// 연 환불액
			int annualRefund = manageMapper.getAnnualRefund(year);
			map.put(year, (annualSales-annualRefund));
		}
		return map;
	}

	// 스케줄러로 매일 09시 20분에 쿠폰 기한 만료 시 '사용불가' 처리
	public void handlingExpiredCoupon(LocalDate date) {
		// TODO Auto-generated method stub
		manageMapper.handlingExpiredCoupon(date);
		
	}
	
	// 이벤트 당첨자 목록 조회
	public List<String> getBookingEventWinnerList(Date event_start_date, Date event_end_date) {
		// TODO Auto-generated method stub
		return manageMapper.getBookingEventWinnerList(event_start_date, event_end_date);
	}
	
	// 매출 데이터 생성에 필요한 멤버 아이디 조회 
	public List<String> getMemberIdList() {
		// TODO Auto-generated method stub
		return manageMapper.getMemberIdList();
	}
	
	// 일일 매출 조회
	public List<Map<String, Object>> getDailySales(LocalDate firstDay, LocalDate lastDay) {
		// TODO Auto-generated method stub
		return manageMapper.getDailySales(firstDay, lastDay);
	}

}
