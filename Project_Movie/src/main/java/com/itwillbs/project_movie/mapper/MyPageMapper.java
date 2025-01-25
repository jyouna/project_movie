package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.FaqBoardVO;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;

public interface MyPageMapper {
	
	// 예매내역 글 전체 가져오기
	int selectReservationListCount(String id);
	// 예매내역 시작번호 끝번호 
	List<Map<String, Object>> selectReservationList(@Param("startRow")int startRow, @Param("listLimit")int listLimit,@Param("id") String id);
	// 예매내역 상세 정보 조회
	Map<String, Object> selectReservationInfo(String r_code);
	
	// 취소내역 글 전체 가져오기
	int selectReservationCancelCount(String id);
	//취소내역 시작번호, 끝번호 어쩌고
	List<Map<String, Object>> selectReservationCancel(@Param("startRow")int startRow, @Param("listLimit")int listLimit,@Param("id") String id);
	
	// 내가 본 영화 글 전체 가져오기
	int selectWathedMovieCount(String id, @Param("searchYear") String searchYear);
	//내가 본 영화 시작번호 끝번호
	List<Map<String, Object>> selectWatchedMovie(@Param("startRow")int startRow, @Param("listLimit")int listLimit,@Param("id") String id, @Param("searchYear") String searchYear);
	// 내가 본 영화 - 리뷰 등록
	int insertReview(@Param("movieName") String movieName, @Param("reviewContent")String reviewContent, @Param("reviewRecommend")int reviewRecommend, @Param("movieCode")int movieCode,
			@Param("id") String id);
	//내가 본 영화 - 리뷰등록 포함 출력
	Map<String, Object> selectIsRegistReview(@Param("id") String id, @Param("movie_code") String movie_code);

	//관람평 글 개수 조회
	int selectReviewListCount(String id);
	//관람평 시작번호 끝번호
	List<Map<String, Object>> selectReviewList(@Param("startRow")int startRow, @Param("listLimit")int listLimit, @Param("id") String id);
	//관람한 영화 리뷰 수정 
	int updateReview(Map<String, String> map);
	//관람한 영화 리뷰 삭제
	int deleteReview(Map<String, String> map);
	
	//쿠폰 리스트 전체 조회
	int selectCouponListCount(String id);
	//쿠폰 리스트 시작번호 끝번호 
	List<Map<String, String>> selectCouponList(@Param("startRow")int startRow, @Param("listLimit")int listLimit, @Param("id")String id);
	
	// 포인트 글 개수 조회
	int selectPointListCount(String id);
	// 포인트 시작글 마지막글...어쩌고
	List<Map<String, String>> selectPointList(@Param("startRow")int startRow, @Param("listLimit")int listLimit, @Param("id")String id);
	
	// 1:1문의 글 전체 가져오기
	int selectInquiryListCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword, @Param("id")String id);
	// 1:1문의 시작번호, 끝번호 어쩌고
	List<InquiryVO> selectInquiryList(@Param("startRow")int startRow, @Param("listLimit")int listLimit, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword, @Param("id")String id);
	// 1:1문의 글 선택하면 글 불러오기
	InquiryVO selectInquiry(int inquiry_code);
	//1:1문의 글 작성
	int insertInquiry(InquiryVO inquiry);
	//1:1문의 글 수정 
	int updateInquiry(InquiryVO inquiry_code);
	//1:1문의 글 삭제 
	int deleteInquiry(InquiryVO inquiry);
	//회원탈퇴
	int updateMemberstatus(String member_id);
	
	
	
	//============================관리자 페이지 ======================================
	
	

	//관리자 페이지 - 공지사항 글 개수 
	int selectNoticeListCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	//관리자 페이지 - 공지사항 글 시작번호 끝번호 
	List<NoticeBoardVO> selectNoticeList(@Param("startRow") int startRow, @Param("listLimit") int listLimit, @Param("searchType") String searchType,@Param("searchKeyword") String searchKeyword);
	//관리자 페이지 - 공지사항 글 등록 
	int insertNoticeAdmin(NoticeBoardVO notice);
	//관리자 페이지 - 공지사항 글 자세히
	NoticeBoardVO selectNotice(int notice_code);
	//관리자 페이지 - 공지사항 글 수정 
	int updateNotice(NoticeBoardVO notice);
	//공지사항 삭제
	int deleteNotice(NoticeBoardVO notice);
	//faq 글 개수
	int selectFaqListCount();
	//faq 글 시작번호 끝번호 
	List<FaqBoardVO> selectFaqList(@Param("startRow") int startRow, @Param("listLimit") int listLimit);
	// faq 글 작성
	int insertFaqAdmin(FaqBoardVO faq);
	//faq 글 보기
	FaqBoardVO selectFaq(int faq_code);
	// faq 조회수 증가
	void updateReadCount(FaqBoardVO faq);
	// faq 글 수정
	int updateFaq(FaqBoardVO faq);
	// faq 글 삭제
	int deleteFaq(FaqBoardVO faq);
	//1:1 문의 개수 
	int selectAdminInquiryListCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	//1:1 문의 시작번호 끝번호 
	List<InquiryVO> selectAdminInquiryList(@Param("startRow") int startRow, @Param("listLimit") int listLimit, @Param("searchType") String searchType,@Param("searchKeyword") String searchKeyword);
	// 1:1문의 글 수정 
	int updateInquiryModify(int inquiry_code);
	// 1:1 문의 글 삭제
	int deleteInquiryAdmin(InquiryVO inquiry);
	//1:1문의 답글 순서번호 조정
	void updateInquiryReSeq(InquiryVO inquiry);
	// 1:1문의 글 답변
	int insertInquiryReply(InquiryVO inquiry);
	//1:1문의 답변 상태 업데이트
	int updateInquiryCode(InquiryVO inquiry);
	void updateInquiryCode2(InquiryVO inquiry);
	
	// 답글삭제시 해당 글의 ref와 같은 ref 수 조회
	// 답글 삭제하기전 조회 수가 2이면 삭제후 남는건
	// 부모글만 남으므로 response_status 0으로 변경
	// (부모글만 존재할 경우)
	int selectRefCount(InquiryVO inquiry);

	
	



}
