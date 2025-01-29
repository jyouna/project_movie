package com.itwillbs.project_movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_movie.mapper.MyPageMapper;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.FaqBoardVO;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;

@Service
public class MypageService {
@Autowired
private MyPageMapper mapper;
// 예매내역 가져오기 
	public int getReservationListCount(String id) {
		// TODO Auto-generated method stub
		return mapper.selectReservationListCount(id);
	}
// 예매내역 시작번호 끝번호~..
	public java.util.List<Map<String, Object>> getReservationList(int startRow, int listLimit, String id) {
		// TODO Auto-generated method stub
		return mapper.selectReservationList(startRow, listLimit, id);
	}
	//예매내역 상세정보 창
	public Map<String, Object> searchdetail(String payment_code) {
		return mapper.selectReservationInfo(payment_code);
	}
// 취소내역 글 전체 가져오기 
	public int getReservationCancelCount(String id) {
		// TODO Auto-generated method stub
		return mapper.selectReservationCancelCount(id);
	}
// 취소내역 시작번호, 끝번호 어쩌고
	public List<Map<String, Object>> getReservationCancel(int startRow, int listLimit, String id) {
		// TODO Auto-generated method stub
		return mapper.selectReservationCancel(startRow, listLimit, id);
	}
// 내가 본 영화 글 전체 가져오기
	public int getWatchedMovieCount(String id, String searchYear) {
		// TODO Auto-generated method stub
		return mapper.selectWathedMovieCount(id, searchYear);
	}
// 내가 본 영화 시작번호, 끝번호 어쩌고
	public List<Map<String, Object>> getWatchedMovie(int startRow, int listLimit, String id, String searchYear) {
		// TODO Auto-generated method stub
		return mapper.selectWatchedMovie(startRow, listLimit, id, searchYear);
	}
	// 내가 본 영화 시작번호 끝번호 - 2 
	public Map<String, Object> isRegistReview(String id, String string) {
		// TODO Auto-generated method stub
		return mapper.selectIsRegistReview(id,string);
	}

	//무비로그 - 관람평 글 전체 가져오기
	public int getReviewListCount(String id) {
		// TODO Auto-generated method stub
		return mapper.selectReviewListCount(id);
	}
	
	//무비로그 - 관람평 시작번호 끝번호
	public List<Map<String, Object>> getReviewList(int startRow, int listLimit, String id) {
		// TODO Auto-generated method stub
		return mapper.selectReviewList(startRow, listLimit, id);
	}
	//관람한 영화 리뷰 등록 
	public int getReview(String movieName, String reviewContent, int reviewRecommend, int movieCode, String id) {
		// TODO Auto-generated method stub
		return mapper.insertReview(movieName, reviewContent, reviewRecommend, movieCode, id);
	}
	//관람한 영화 리뷰 수정 
	public int getReviewModify(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.updateReview(map);
	}
	//관람한 영화 리뷰 삭제
	public int removeReview(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.deleteReview(map);
	}
	//쿠폰 리스트 조회
	public int getCouponListCount(String id) {
		// TODO Auto-generated method stub
		return mapper.selectCouponListCount(id);
	}
	//쿠폰 리스트 시작번호 끝번호 
	public List<Map<String, String>> getCouponList(int startRow, int listLimit, String id) {
		// TODO Auto-generated method stub
		return mapper.selectCouponList(startRow, listLimit, id);
	}

// 1:1문의 글 전체 가져오기
	public int getInquiryListCount(String searchType, String searchKeyWord, String id) {
		// TODO Auto-generated method stub
		return mapper.selectInquiryListCount(searchType, searchKeyWord, id);
	}
// 1:1문의 시작번호, 끝번호 어쩌고
	public List<InquiryVO> getInquiryList(int startRow, int listLimit, String searchType, String searchKeyWord, String id) {
		// TODO Auto-generated method stub
		return mapper.selectInquiryList(startRow, listLimit, searchType, searchKeyWord, id);
	}
// 1:1문의 글 선택하면 글 불러오기
	public InquiryVO getInquiry(int inquiry_code) {
		InquiryVO inquiry = mapper.selectInquiry(inquiry_code);
		return inquiry;
	}
	//1:1문의 글 작성 
	public int registInquiry(InquiryVO inquiry) {
		// TODO Auto-generated method stub
		return mapper.insertInquiry(inquiry);
	}
	//1:1문의 글 수정
	public int getInquiryModify(InquiryVO inquiry) {
		// TODO Auto-generated method stub
		return mapper.updateInquiry(inquiry);
	}
	//1:1문의 글 삭제 
	public int removeInquiry(InquiryVO inquiry) {
		// TODO Auto-generated method stub
		return mapper.deleteInquiry(inquiry);
	}
	//포인트 글 개수
	public int getPointListCount(String id) {
		// TODO Auto-generated method stub
		return mapper.selectPointListCount(id);
	}
	//포인트 시작번호 끝번호..
	public List<Map<String, String>> getPointList(int startRow, int listLimit, String id) {
		// TODO Auto-generated method stub
		return mapper.selectPointList(startRow, listLimit, id);
	}
	//---------------------------여기서는 관리자 페이지 -------------------------------------------------------------------------------------------------
	//관리자페이지 - 공지사항 글 개수
	public int getNoticeListCount(String searchType, String searchKeyword) {
		// TODO Auto-generated method stub
		return mapper.selectNoticeListCount(searchType, searchKeyword );
	}
	//관리자페이지 - 공지사항 시작번호 끝번호 
	public List<NoticeBoardVO> getNoticeList(int startRow, int listLimit, String searchType, String searchKeyword) {
		// TODO Auto-generated method stub
		return mapper.selectNoticeList(startRow,listLimit, searchType,searchKeyword);
	}
	//공지사항 글 등록
	public int registNotice(NoticeBoardVO notice) {
		// TODO Auto-generated method stub
		return mapper.insertNoticeAdmin(notice);
	}
	//관리자페이지 - 공지사항 글 자세히보기 
	public NoticeBoardVO getNotice(int notice_code, boolean isIncreaseReadcount) {
		// TODO Auto-generated method stub
		return mapper.selectNotice(notice_code);
	}
	// 공지사항 글 수정 
	public int getNoticeUpdate(NoticeBoardVO notice) {
		// TODO Auto-generated method stub
		return mapper.updateNotice(notice);
	}
	public int getNoticeDelete(NoticeBoardVO notice) {
		// TODO Auto-generated method stub
		return mapper.deleteNotice(notice);
	}
	//faq 글 개수
	public int getFaqListCount() {
		// TODO Auto-generated method stub
		return mapper.selectFaqListCount();
	}
	//faq 시작번호 끝번호 
	public List<FaqBoardVO> getFaqList(int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return mapper.selectFaqList(startRow,listLimit );
	}
	//faq 글 작성 
	public int faqWrite(FaqBoardVO faq) {
		// TODO Auto-generated method stub
		return mapper.insertFaqAdmin(faq);
	}
	//faq 글 보기 
	public FaqBoardVO getFaq(int faq_code, boolean isIncreaseReadcount) {
		FaqBoardVO faq = mapper.selectFaq(faq_code);
		if(faq != null && isIncreaseReadcount) {
			mapper.updateReadCount(faq);
		}
		return faq;
	}
	//faq 글 수정
	public int getFaqModify(FaqBoardVO faq) {
		// TODO Auto-generated method stub
		return mapper.updateFaq(faq);
	}
	//faq 글 삭제 
	public int getFaqDelete(FaqBoardVO faq) {
		// TODO Auto-generated method stub
		return mapper.deleteFaq(faq);
	}
	//1:1문의 글 개수
	public int getInquiryListCount(String searchType) {
		// TODO Auto-generated method stub
		return mapper.selectAdminInquiryListCount(searchType);
	}
	//1:1문의 글 시작번호 끝번호 
	public List<InquiryVO> getInquiryList(int startRow, int listLimit, String searchType) {
		// TODO Auto-generated method stub
		return mapper.selectAdminInquiryList(startRow, listLimit, searchType);
	}
	//1:1문의 글 수정 
	public int getInquiryModify(int inquiry_code) {
		// TODO Auto-generated method stub
		return mapper.updateInquiryModify(inquiry_code);
	}
	//1:1문의 글 삭제
	@Transactional
	public int getInquiryDelete(InquiryVO inquiry) {
		int refCount = mapper.selectRefCount(inquiry);
		if(refCount == 2) {
			int updateCount = mapper.updateInquiryCode(inquiry);
			if(updateCount == 0) {
				return 0;
			}
		}
		return mapper.deleteInquiryAdmin(inquiry);
	}
	//1:1문의 글 답변
	@Transactional
	public int addReply(InquiryVO inquiry) {
		mapper.updateInquiryReSeq(inquiry);
		mapper.updateInquiryCode2(inquiry);
		return mapper.insertInquiryReply(inquiry);
	}
	//회원탈퇴 
	public int updateMemberStatus(String member_id) {
		return mapper.updateMemberstatus(member_id);
	}
	//마이페이지 메인 예매내역 출력
	public List<Map<String, Object>> getReservationList(String id) {
		// TODO Auto-generated method stub
		return mapper.getReservationList(id);
	}
	public List<Map<String, String>> getCouponList(String id) {
		// TODO Auto-generated method stub
		return mapper.getCouponList(id);
	}
	public List<Map<String, String>> getPointList(String id) {
		// TODO Auto-generated method stub
		return mapper.getPointList(id);
	}
	public List<InquiryVO> getInquiryList(String id) {
		// TODO Auto-generated method stub
		return mapper.getInquiryList(id);
	}



	

}
