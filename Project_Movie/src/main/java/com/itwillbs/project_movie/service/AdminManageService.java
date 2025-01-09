package com.itwillbs.project_movie.service;

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

	public List<AdminRegisVO> queryAdminList(int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return manageMapper.selectAdminList(startRow, listLimit);
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

	public List<EventWinnerVO> getEventWinnerList() { // 쿠폰 당첨자 리스트 
		// TODO Auto-generated method stub
		return manageMapper.selectAllEventWinner();
	}

	public List<EventWinnerVO> getPointWinnerList() { // 포인트 당첨자 리스트
		// TODO Auto-generated method stub
		return manageMapper.getPointWinnerList();
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

	public List<PointVO> getPointRecord() {
		// TODO Auto-generated method stub
		return manageMapper.getPointRecord();
	}

	public List<CouponVO> getCouponList() {
		// TODO Auto-generated method stub
		return manageMapper.getCouponList();
	}

	public List<Map<String, String>> getCouponInfo() {
		// TODO Auto-generated method stub
		return manageMapper.getCouponInfo();
	}

	public List<MemberAllInfoVO> getMemberAllInfo() {
		// TODO Auto-generated method stub
		return manageMapper.getMemberAllInfo();
	}
}
