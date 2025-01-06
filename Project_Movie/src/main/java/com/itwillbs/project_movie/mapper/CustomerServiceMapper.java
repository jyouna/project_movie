package com.itwillbs.project_movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.FaqBoardVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;

@Mapper
public interface CustomerServiceMapper {
	// 공지사항 게시물 수 조회
	int selectNoticeListCount();
	// 공지사항 목록 조회
	List<NoticeBoardVO> selectNoticeList(@Param("startRow") int startRow, @Param("listLimit") int listLimit);
	// 공지사항 상세정보 조회
	NoticeBoardVO selectNotice(int notice_code);
	// 공지사항 조회수 증가
	void updateNoticeReadCount(NoticeBoardVO notice);
	// 자주하는 문의 게시물 수 조회
	int selectFaqListCount();

	List<FaqBoardVO> selectFaqList(@Param("startRow") int startRow,@Param("listLimit") int listLimit);

	FaqBoardVO selectFaq(int faq_code);

	void updateFaqReadCount(FaqBoardVO faq);

	int deleteNotice(NoticeBoardVO notice);
	
}
