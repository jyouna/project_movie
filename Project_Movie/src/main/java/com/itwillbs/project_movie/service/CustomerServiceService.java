package com.itwillbs.project_movie.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.CustomerServiceMapper;
import com.itwillbs.project_movie.vo.FaqBoardVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;

@Service
public class CustomerServiceService {
	@Autowired
	private CustomerServiceMapper mapper;
	
	public int getNoticeListCount() {
		// TODO Auto-generated method stub
		return mapper.selectNoticeListCount();
	}

	public List<NoticeBoardVO> getNoticeList(@Param("startRow") int startRow, @Param("listLimit") int listLimit) {
		// TODO Auto-generated method stub
		return mapper.selectNoticeList(startRow, listLimit);
	}

	public NoticeBoardVO getNotice(int notice_code, boolean isIncreaseReadcount) {
		NoticeBoardVO notice = mapper.selectNotice(notice_code);
		if(notice != null && isIncreaseReadcount) {
			mapper.updateReadCount(notice);
		}
		return notice;
				
	}

	public int getFaqListCount() {
		// TODO Auto-generated method stub
		return mapper.selectFaqListCount();
	}

	public List<FaqBoardVO> getFaqList(@Param("startRow") int startRow, @Param("listLimit") int listLimit) {
		// TODO Auto-generated method stub
		return mapper.selectFaqList(startRow, listLimit);
	}



}//cutomerservice
