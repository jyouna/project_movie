package com.itwillbs.project_movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.BookMapper;
import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.ScheduleVO;
import com.itwillbs.project_movie.vo.SeatVO;

@Service
public class BookService {
	@Autowired private BookMapper mapper;

	// 영화/시간 선택 페이지
	public List<MovieVO> getMovieList() {
		return mapper.selectMovieList();
	}

	public List<Map<String, Object>> getSchWithMovie(String start_time) {
		return mapper.selectSchWithMovie(start_time);
	}


	// 좌석 선택 페이지
	public List<SeatVO> getSeat() {
		return mapper.selectSeat();
	}

}
