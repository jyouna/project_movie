package com.itwillbs.project_movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.InquiryVO;

public interface MyPageMapper {
	// 1:1문의 글 전체 가져오기
	int selectInquiryListCount();
	// 1:1문의 시작번호, 끝번호 어쩌고
	List<InquiryVO> selectInquiryList(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	// 1:1문의 글 선택하면 글 불러오기
	InquiryVO selectInquiry(int inquiry_code);


}
