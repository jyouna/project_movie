package com.itwillbs.project_movie.service;

import java.util.List;
import java.util.Map;

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
	
	// 페이징 후 페이지에 필요한 만큼의 영화목록 조회
	public List<MovieVO> getMovieList(int startRow, int listLimit) {
		return movieMapper.selectMovieList(startRow, listLimit);
	}
	
	// 검색조건(컬럼명), 검색어를 파라미터로 전달 후 해당 영화리스트 조회
	public List<MovieVO> searchMovie(Map<String, String> map) {
		return movieMapper.selectSearchMovie(map);
	}
	
	// 업데이트할 영화코드, 업데이트할 영화상태를 파라미터로 전달 후 해당 영화상태 업데이트
	public int setMovieStatus(Map<String, String> map) {
		return movieMapper.updateMovieStatus(map);
	}
	
	// 조건에 해당하는 영화의 수 조회
	public int getCountConditionMovie(Map<String, String> map) {
		return movieMapper.selectMovieCount(map);
	}
	
	
}
