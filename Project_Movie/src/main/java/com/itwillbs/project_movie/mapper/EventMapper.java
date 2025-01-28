package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerAnnounceBoardVO;

public interface EventMapper {

	int selectEventListCount(@Param("searchType") String searchType,@Param("searchKeyword") String searchKeyword);
	// 이벤트 글 가져오기 
	List<EventBoardVO> selectEventList
	(@Param("startRow") int startRow,@Param("listLimit") int listLimit, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	//이벤트 글 누르면 글로 이동 
	EventBoardVO selectEvent(int event_code);
	//이벤트 글 조회수 증가
	void updateEventReadCount(EventBoardVO event);
	//이전글 다음글 버튼 
	Map<String, Object> selectPreNextCodeList(Map<String, String> map);


}
