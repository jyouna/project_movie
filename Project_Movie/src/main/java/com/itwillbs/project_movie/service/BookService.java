package com.itwillbs.project_movie.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_movie.mapper.BookMapper;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.ScheduleVO;
import com.itwillbs.project_movie.vo.SeatVO;
import com.itwillbs.project_movie.vo.TicketVO;


@Service
public class BookService {
	@Autowired private BookMapper mapper;

	// 영화/시간 선택 페이지
	public List<MovieVO> getMovieList() {
		return mapper.selectMovieList();
	}

	public List<Map<String, Object>> getSchWithMovie(Map<String, String> conditionMap) {
		return mapper.selectSchWithMovie(conditionMap);
	}
	
	public List<MovieVO> getMovieList2(Map<String, String> conditionMap) {
		return mapper.selectMovieList2(conditionMap);
	}

	public List<ScheduleVO> getScheduleList(Map<String, String> conditionMap) {
		return mapper.selectScheduleList(conditionMap);
	}


	// 좌석 선택 페이지
	public List<SeatVO> getSeat() {
		return mapper.selectSeat();
	}

	public Map<String, String> getSelectedMovie(String movie_code) {
		return mapper.getSelectMovie(movie_code);
	}

	public List<TicketVO> getTicketType() {
		return mapper.selectTicketType();
	}

	public Map<String, Object> getScheduleInfoByScheduleCode(String schedule_code) {
		return mapper.selectScheduleInfoByScheduleCode(schedule_code);
	}
	
	@Transactional
	public int registBookingTicket(Map<String, String> map) {
		mapper.insertPaymentTable(map);
		
		List<Map<String, String>> insertBookingList = new ArrayList<Map<String,String>>();
		
		String[] seatArr = map.get("totalSeat").split(", ");
		for(String seat : seatArr) {
			Map<String, String> insertBookingInfo = new HashMap<String, String>();
			String seat_code = map.get("theater_code") + "_" + seat.trim();
			insertBookingInfo.put("booking_code", map.get("payment_code") + seat);
			insertBookingInfo.put("seat_code", seat_code);
			insertBookingInfo.put("payment_code", map.get("payment_code"));
			insertBookingInfo.put("schedule_code", map.get("schedule_code"));
			insertBookingList.add(insertBookingInfo);
		}
		System.out.println(insertBookingList);
		return mapper.insertBookingTable(insertBookingList);
	}

	public int getMyPoint(String id) {
		return mapper.selectMyPoint(id);
	}

	public List<Map<String, Object>> getMyCouponList(String id) {
		return mapper.selectMyCouponList(id);
	}

	public CouponVO getMyCoupon(String coupon_code) {
		return mapper.selectMyCoupon(coupon_code);
	}



}























