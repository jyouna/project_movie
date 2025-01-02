package com.itwillbs.project_movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.MovieMapper;
import com.itwillbs.project_movie.vo.MovieVO;

@Service
public class MovieService {
	
	@Autowired
	private MovieMapper movieMapper;
	
	// MovieMapper의 영화등록 메서드 호출
	public int registMovie(MovieVO movieVO) {
		return movieMapper.insertMovie(movieVO);
	}
	
	// MovieMapper의 영화조회 메서드 호출
	public MovieVO searchMovieInfo(String movie_code) {
		return movieMapper.SelectMovie(movie_code);
	}
	
	// 페이징 처리를 위한 영화 목록 수 조회
	public int getMovieListCount() {
		return movieMapper.selectMovieListCount();
	}

	public List<MovieVO> getMovieList(int startRow, int listLimit) {
		return movieMapper.selectMovieList(startRow, listLimit);
	}
	
}
