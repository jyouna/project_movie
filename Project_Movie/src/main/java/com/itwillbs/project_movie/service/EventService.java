package com.itwillbs.project_movie.service;

import java.util.List;
import java.util.Map;

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
	
	// 이벤트 이전글 다음글
	public Map<String, Object> getPreNext(Map<String, String> map) {
		// 이벤트
		if(map.get("tableName").equals("event_board")) {
			map.put("orderBy", "ORDER BY event_status ASC, event_start_date DESC, event_end_date DESC");
		} else if(map.get("tableName").equals("notice_board")) {
			map.put("orderBy", "ORDER BY notice_code DESC");
		} else if(map.get("tableName").equals("faq_board")) {
			map.put("orderBy", "ORDER BY faq_code DESC");
		} else if(map.get("tableName").equals("Inquiry")) {
			map.put("orderBy", "ORDER BY inquiry_re_ref DESC, inquiry_re_seq ASC");
		}
		return mapper.selectPreNextCodeList(map);
	}



}
