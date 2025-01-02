package com.itwillbs.project_movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.AdminManageMapper;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.EventBoardVO;

@Service
public class AdminManageService {
	@Autowired
	private AdminManageMapper manageMapper;

	public int createAccount(AdminRegisVO adminVo) {
		return manageMapper.insertAccount(adminVo);
	}

	public List<AdminRegisVO> queryAdminList() {
		// TODO Auto-generated method stub
		return manageMapper.selectAdminList();
	}

	public void deleteAdminAccount(String[] admin_id) {
		// TODO Auto-generated method stub
		
		for(String id : admin_id) {
			manageMapper.deleteAdminAccount(id);
		}
	}

	public void regisEventBoard(EventBoardVO eventVo) {
		// TODO Auto-generated method stub
		manageMapper.insertEventBoard(eventVo);
	}

	public List<EventBoardVO> eventBoardList() {
		return manageMapper.selectEventBoardList();
	}
	
}
