package com.itwillbs.project_movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.EventMapper;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerAnnounceBoardVO;

@Service
public class EventService {
@Autowired
private EventMapper mapper;
	//이벤트 게시글 갯수
	public int getEventListCount(String searchType, String searchKeyword) {
		// TODO Auto-generated method stub
		return mapper.selectEventListCount(searchType,searchKeyword);
	}
	//이벤트 게시글 리스트
	public List<EventBoardVO> getEventList(int startRow, int listLimit, String searchType, String searchKeyword) {
		// TODO Auto-generated method stub
		return mapper.selectEventList(startRow,listLimit,searchType,searchKeyword);
	}
	//게시글 조회수 증가
	public EventBoardVO getEvent(int event_code, boolean isIncreaseReadcount) {
		EventBoardVO event = mapper.selectEvent(event_code);
		if(event != null && isIncreaseReadcount) {
			mapper.updateEventReadCount(event);
		}
		return event;
	}



}
