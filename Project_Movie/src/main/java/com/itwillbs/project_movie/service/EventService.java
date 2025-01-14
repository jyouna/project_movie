package com.itwillbs.project_movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.EventMapper;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerBoardVO;

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
	//이벤트 당첨자 게시글 갯수
	public int getEventWinnerListCount(String searchType, String searchKeyword) {
		// TODO Auto-generated method stub
		return mapper.selectEventWinnerCount(searchType, searchKeyword);
	}
	//이벤트 당첨자 게시글 리스트
//	public List<EventWinnerBoardVO> getEventWinnerList(int startRow, int listLimit, String searchType, String searchKeyword) {
//		// TODO Auto-generated method stub
//		return mapper.selectEventWinnerList(startRow,listLimit, searchType, searchKeyword);
//	}
//	//당첨자 게시글 조회수 증가
//	public EventWinnerBoardVO getEventWinner(int winner_code, boolean isIncreaseReadcount) {
//		EventWinnerBoardVO eventWinner = mapper.selectEventWinner(winner_code);
//		if(eventWinner != null && isIncreaseReadcount) {
//			mapper.updateEventWinnerReadCount(eventWinner);
//		}
//		return eventWinner;
//	}


}
