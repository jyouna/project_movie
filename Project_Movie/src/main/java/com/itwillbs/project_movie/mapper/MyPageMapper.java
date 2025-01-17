package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.FaqBoardVO;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;

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
	Map<String, Object> selectIsRegistReview(@Param("id") String id, @Param("movie_code") String movie_code);

	//관람평 글 개수 조회
	int selectReviewListCount();
	//관람평 시작번호 끝번호
	List<Map<String, Object>> selectReviewList(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	
	//쿠폰 리스트 전체 조회
	int selectCouponListCount();
	//쿠폰 리스트 시작번호 끝번호 
	List<Map<String, String>> selectCouponList(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	
	// 포인트 글 개수 조회
	int selectPointListCount();
	// 포인트 시작글 마지막글...어쩌고
	List<Map<String, String>> selectPointList(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	
	// 1:1문의 글 전체 가져오기
	int selectInquiryListCount();
	// 1:1문의 시작번호, 끝번호 어쩌고
	List<InquiryVO> selectInquiryList(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	// 1:1문의 글 선택하면 글 불러오기
	InquiryVO selectInquiry(int inquiry_code);
	//1:1문의 글 작성
	int insertInquiry(InquiryVO inquiry);
	//1:1문의 글 수정 
	InquiryVO updateInquiry(InquiryVO inquiry_code);
	//1:1문의 글 삭제 
	int deleteInquiry(InquiryVO inquiry);
	//관리자 페이지 - 공지사항 글 개수 
	int selectNoticeListCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	//관리자 페이지 - 공지사항 글 시작번호 끝번호 
	List<NoticeBoardVO> selectNoticeList(@Param("startRow") int startRow, @Param("listLimit") int listLimit, @Param("searchType") String searchType,@Param("searchKeyword") String searchKeyword);
	//관리자 페이지 - 공지사항 글 자세히
	NoticeBoardVO selectNotice(int notice_code);
	//faq 글 개수
	int selectFaqListCount();
	//faq 글 시작번호 끝번호 
	List<FaqBoardVO> selectFaqList(@Param("startRow") int startRow, @Param("listLimit") int listLimit);
	//faq 글 보기
	FaqBoardVO selectFaq(int faq_code);



}
