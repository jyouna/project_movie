package com.itwillbs.project_movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.EventBoardVO;

public interface EventMapper {

	int selectEventListCount();

	List<EventBoardVO> selectEventList(@Param("startRow") int startRow,@Param("listLimit") int listLimit);

	EventBoardVO selectEvent(int event_code);

	void updateEventReadCount(EventBoardVO event);

}
