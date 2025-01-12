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

}
