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

	public List<MovieVO> getMovieList() {
		return mapper.selectMovieList();
	}

	public List<SeatVO> getSeat() {
		return mapper.selectSeat();
	}

	public List<ScheduleVO> getSchedule() {
		return mapper.selectScheduleJoinMovie();
	}

	public List<Map<String, Object>> getSchWithMovie() {
		return mapper.selectSchWithMovie();
	}
}
