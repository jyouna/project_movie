package com.itwillbs.project_movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.AdminManageMapper;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.MemberVO;

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
		return manageMapper.getEventBoardContent(event_code);
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
		return manageMapper.getEventBoardContent(event_code);
	}

	public List<MemberVO> getMemberList() {
		// TODO Auto-generated method stub
		return manageMapper.selectMemberInfoForEvent();
	}


	
}
