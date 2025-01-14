package com.itwillbs.project_movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.MyPageMapper;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.ReservationCancelVO;
import com.itwillbs.project_movie.vo.ReservationDetailVO;
import com.itwillbs.project_movie.vo.WatchedMovieVO;

@Service
public class MypageService {
@Autowired
private MyPageMapper mapper;
// 예매내역 가져오기 
	public int getReservationDetailCount() {
		// TODO Auto-generated method stub
		return mapper.selectReservationDetailCount();
	}
// 예매내역 시작번호 끝번호~..
	public List<ReservationDetailVO> getReservationDetail(int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return mapper.selectReservationDetail(startRow, listLimit);
	}
	//예매내역 상세정보 창
	public ReservationDetailVO searchdetail(String r_code) {
		return mapper.selectReservationInfo(r_code);
	}
// 취소내역 글 전체 가져오기 
	public int getReservationCancelCount() {
		// TODO Auto-generated method stub
		return mapper.selectReservationCancelCount();
	}
// 취소내역 시작번호, 끝번호 어쩌고
	public List<ReservationCancelVO> getReservationCancel(int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return mapper.selectReservationCancel(startRow, listLimit);
	}
// 내가 본 영화 글 전체 가져오기
	public int getWatchedMovieCount() {
		// TODO Auto-generated method stub
		return mapper.selectWathedMovieCount();
	}
// 내가 본 영화 시작번호, 끝번호 어쩌고
	public List<WatchedMovieVO> getWatchedMovie(int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return mapper.selectWatchedMovie(startRow, listLimit);
	}
	
	//리뷰 등록창
	public WatchedMovieVO searchWatchedmovieReview(String r_code) {
		// TODO Auto-generated method stub
		return mapper.selectWatchedmovieReview(r_code);
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
