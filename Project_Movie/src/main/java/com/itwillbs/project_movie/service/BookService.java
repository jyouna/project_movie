package com.itwillbs.project_movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.BookMapper;
import com.itwillbs.project_movie.vo.MovieVO;

@Service
public class BookService {
	@Autowired private BookMapper mapper;

	public List<MovieVO> getMovieList() {
		return mapper.selectMovieList();
	}
}
