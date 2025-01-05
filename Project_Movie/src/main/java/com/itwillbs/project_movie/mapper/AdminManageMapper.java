package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.EventBoardVO;

@Mapper
public interface AdminManageMapper {

	int insertAccount(AdminRegisVO adminVo);

	List<AdminRegisVO> selectAdminList(@Param("startRow") int startRow, @Param("listLimit") int listLimit);

	int deleteAdminAccount(@Param("id") String id);

//	void insertEventBoard(@Param("noticeVo") NoticeBoardVO noticeVo);
	void insertEventBoard(EventBoardVO eventVo);

	List<EventBoardVO> selectEventBoardList();

	void updateEventStatusStart(@Param("event_code") int event_code);

	void updateEventStatusEnd(@Param("event_code") int event_code);

	EventBoardVO getEventBoardContent(@Param("event_code") int event_code);

	String checkAdminId(@Param("id") String id);

	int getBoardListCount();

	AdminRegisVO selectAdminAccountInfo(@Param("admin_id") String admin_id);

	void adminAccountModify(AdminRegisVO modifyVo);


//	void selectEventWinner(@Param("event_code") int event_code);
}
