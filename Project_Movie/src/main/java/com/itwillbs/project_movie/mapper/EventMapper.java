package com.itwillbs.project_movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.EventBoardVO;

public interface EventMapper {

	int selectEventListCount(@Param("searchType") String searchType,@Param("searchKeyword") String searchKeyword);

	List<EventBoardVO> selectEventList(@Param("startRow") int startRow,@Param("listLimit") int listLimit, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);

	EventBoardVO selectEvent(int event_code);

	void updateEventReadCount(EventBoardVO event);

}
