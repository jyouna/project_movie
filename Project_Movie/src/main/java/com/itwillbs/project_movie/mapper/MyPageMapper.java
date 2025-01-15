package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.InquiryVO;

public interface MyPageMapper {
	
	// 예매내역 글 전체 가져오기
	int selectReservationListCount();
	// 예매내역 시작번호 끝번호 
	List<Map<String, Object>> selectReservationList(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	// 예매내역 상세 정보 조회
	Map<String, Object> selectReservationInfo(String r_code);
	// 취소내역 글 전체 가져오기
	int selectReservationCancelCount();
	//취소내역 시작번호, 끝번호 어쩌고
	List<Map<String, Object>> selectReservationCancel(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	// 내가 본 영화 글 전체 가져오기
	int selectWathedMovieCount();
	//내가 본 영화 시작번호 끝번호
	List<Map<String, Object>> selectWatchedMovie(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	//내가 본 영화 - 리뷰 창 띄우기 
	Map<String, Object> selectWatchedmovieReview(String r_code);
	//내가 본 영화 - 리뷰등록 포함 출력
	Map<String, Object> selectRegistReview(@Param("id") String id, @Param("movie_code") String movie_code);
	//관람평 등록
	int insertReview(Map<String, String> map);
	//관람평 글 개수 조회
	int selectReviewCount();
	//관람평 시작번호 끝번호
	List<Map<String, Object>> selectReview(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	
	// 1:1문의 글 전체 가져오기
	int selectInquiryListCount();
	// 1:1문의 시작번호, 끝번호 어쩌고
	List<InquiryVO> selectInquiryList(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	// 1:1문의 글 선택하면 글 불러오기
	InquiryVO selectInquiry(int inquiry_code);
	
	//1:1문의 글 작성
	int insertInquiry(InquiryVO inquiry);
	
	//1:1문의 글 수정 
	InquiryVO updateInquiry(InquiryVO inquiry);
	//1:1문의 글 삭제 
	int deleteInquiry(InquiryVO inquiry);

}
