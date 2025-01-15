package com.itwillbs.project_movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.MyPageMapper;
import com.itwillbs.project_movie.vo.InquiryVO;

@Service
public class MypageService {
@Autowired
private MyPageMapper mapper;
// 예매내역 가져오기 
	public int getReservationListCount() {
		// TODO Auto-generated method stub
		return mapper.selectReservationListCount();
	}
// 예매내역 시작번호 끝번호~..
	
	public java.util.List<Map<String, Object>> getReservationList(int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return mapper.selectReservationList(startRow, listLimit);
	}
	//예매내역 상세정보 창
	public Map<String, Object> searchdetail(String r_code) {
		return mapper.selectReservationInfo(r_code);
	}
// 취소내역 글 전체 가져오기 
	public int getReservationCancelCount() {
		// TODO Auto-generated method stub
		return mapper.selectReservationCancelCount();
	}
// 취소내역 시작번호, 끝번호 어쩌고
	public List<Map<String, Object>> getReservationCancel(int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return mapper.selectReservationCancel(startRow, listLimit);
	}
// 내가 본 영화 글 전체 가져오기
	public int getWatchedMovieCount() {
		// TODO Auto-generated method stub
		return mapper.selectWathedMovieCount();
	}
// 내가 본 영화 시작번호, 끝번호 어쩌고
	public List<Map<String, Object>> getWatchedMovie(int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return mapper.selectWatchedMovie(startRow, listLimit);
	}
	//리뷰 등록창
	public Map<String, Object> searchWatchedmovieReview(String r_code) {
		// TODO Auto-generated method stub
		return mapper.selectWatchedmovieReview(r_code);
	}
	// 내가 본 영화 - 리뷰등록 
	public int getReview(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.insertReview(map);
	}
	//내가 본 영화 - 리뷰등록 포함 출력 
	public Map<String, Object> isRegistReview(String id, String movie_code) {
		return mapper.selectRegistReview(id, movie_code);
	}
	//무비로그 - 관람평 
	public int getReviewCount() {
		// TODO Auto-generated method stub
		return mapper.selectReviewCount();
	}
	
	//무비로그 - 관람평 시작번호 끝번호
	public List<Map<String, Object>> getReview(int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return mapper.selectReview(startRow, listLimit);
	}
	
// 1:1문의 글 전체 가져오기
	public int getInquiryListCount() {
		// TODO Auto-generated method stub
		return mapper.selectInquiryListCount();
	}
// 1:1문의 시작번호, 끝번호 어쩌고
	public List<InquiryVO> getInquiryList(int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return mapper.selectInquiryList(startRow, listLimit);
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
	public InquiryVO getInquiry(InquiryVO inquiry) {
		// TODO Auto-generated method stub
		return mapper.updateInquiry(inquiry);
	}
	//1:1문의 글 삭제 
	public int removeInquiry(InquiryVO inquiry) {
		// TODO Auto-generated method stub
		return mapper.deleteInquiry(inquiry);
	}
	

}
