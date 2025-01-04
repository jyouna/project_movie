package com.itwillbs.project_movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.FaqBoardVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;

@Mapper
public interface CustomerServiceMapper {

	int selectNoticeListCount();

	List<NoticeBoardVO> selectNoticeList(@Param("startRow") int startRow, @Param("listLimit") int listLimit);

	NoticeBoardVO selectNotice(int notice_code);

	void updateReadCount(NoticeBoardVO notice);

	int selectFaqListCount();

	List<FaqBoardVO> selectFaqList(int startRow, int listLimit);
	
}
