package com.itwillbs.project_movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.EventMapper;
import com.itwillbs.project_movie.vo.EventBoardVO;

@Service
public class EventService {
@Autowired
private EventMapper mapper;
	public int getEventListCount() {
		// TODO Auto-generated method stub
		return mapper.selectEventListCount();
	}
	public List<EventBoardVO> getEventList(int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return mapper.selectEventList(startRow,listLimit);
	}

}
