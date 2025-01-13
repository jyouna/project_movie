package com.itwillbs.project_movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.BookMapper;
import com.itwillbs.project_movie.mapper.BookMapper2;
import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.ScheduleVO;
import com.itwillbs.project_movie.vo.SeatVO;
import com.itwillbs.project_movie.vo.TicketVO;

@Service
public class BookService2 {
	@Autowired private BookMapper2 mapper;

	public List<MovieVO> getMovieList(Map<String, String> conditionMap) {
		return mapper.selectMovieList(conditionMap);
	}

	public List<ScheduleVO> getScheduleList(Map<String, String> conditionMap) {
		return mapper.selectScheduleList(conditionMap);
	}


}
