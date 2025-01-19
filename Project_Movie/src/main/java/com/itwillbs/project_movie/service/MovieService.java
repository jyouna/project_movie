package com.itwillbs.project_movie.service;

import java.util.HashMap;
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
		return movieMapper.SelectMovieByCode(movie_code);
	}
	
	// 페이징 처리를 위한 영화 목록 수 조회
	public int getMovieListCount(String howSearch, String searchKeyword, String howSearch2, String searchKeyword2) {
		return movieMapper.selectMovieListCount(howSearch, searchKeyword, howSearch2, searchKeyword2);
	}
	
	// 페이징 후 페이지에 필요한 만큼의 영화목록 조회
	public List<MovieVO> getMovieList(int startRow, int listLimit, String howSearch, String searchKeyword, String howSearch2, String searchKeyword2) {
		return movieMapper.selectMovieList(startRow, listLimit, howSearch, searchKeyword, howSearch2, searchKeyword2);
	}
	
	// 검색조건(컬럼명), 검색어를 파라미터로 전달 후 해당 영화리스트 조회
	public List<MovieVO> searchMovie(Map<String, String> map) {
		return movieMapper.selectMovieListCheck(map);
	}
	
	// 업데이트할 영화코드, 업데이트할 영화상태를 파라미터로 전달 후 해당 영화상태 업데이트
	public int setMovieStatus(Map<String, String> map) {
		return movieMapper.updateMovieStatus(map);
	}
	
	// 총 상영예정작 수 조회
	public int getCountTotalUpcomingMovie() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("columnName", "movie_status");
		conditionMap.put("selectCondition", "상영예정작");
		return movieMapper.selectMovieCount(conditionMap);
	}
	
	// 일반 상영예정작 수 조회
	public int getCountGeneralUpcomingMovie() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("columnName", "movie_type");
		conditionMap.put("selectCondition", "일반");
		conditionMap.put("columnName2", "movie_status");
		conditionMap.put("selectCondition2", "상영예정작");
		return movieMapper.selectMovieCount(conditionMap);
	}
	
	// 시즌 상영예정작 수 조회
	public int getCountSeasonUpcomingMovie() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("columnName", "movie_type");
		conditionMap.put("selectCondition", "시즌");
		conditionMap.put("columnName2", "movie_status");
		conditionMap.put("selectCondition2", "상영예정작");
		return movieMapper.selectMovieCount(conditionMap);
	}
	
	// 투표 영화 수 조회
	public int getCountPickMovie() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("columnName", "movie_status");
		conditionMap.put("selectCondition", "투표영화");
		return movieMapper.selectMovieCount(conditionMap);
	}
	
	// 현재 상영작 수 조회 
	public int getCountCurrentlyMovie() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("columnName", "movie_status");
		conditionMap.put("selectCondition", "현재상영작");
		return movieMapper.selectMovieCount(conditionMap);
	}
	
	// 영화 정보 삭제
	public int deleteMovieInfo(String movie_code) {
		return movieMapper.deleteMovie(movie_code);
	}
	
	// 상영예정작 리스트 조회
	public List<MovieVO> getUpcomingMovieList() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("columnName", "movie_status");
		conditionMap.put("selectCondition", "상영예정작");
		conditionMap.put("orderColumn", "movie_type");
		conditionMap.put("howOrder", "ASC");
		return movieMapper.selectMovieListCheck(conditionMap);
	}
	
	// 영화 상영예정기간 업데이트
	public int setScreeningDate(MovieVO movieVO) {
		return movieMapper.updateScreeningPeriod(movieVO);
	}
	
	// 현재상영작 리스트 조회
	public List<MovieVO> getCurrentlyMovieList() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("columnName", "movie_status");
		conditionMap.put("selectCondition", "현재상영작");
		conditionMap.put("orderColumn", "movie_type");
		conditionMap.put("howOrder", "ASC");
		return movieMapper.selectMovieListCheck(conditionMap);
	}
	
	// 시즌 현재상영작 리스트 조회
	public List<MovieVO> getSeasonCurrentlyMovieList() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("columnName", "movie_status");
		conditionMap.put("selectCondition", "현재상영작");
		conditionMap.put("columnName2", "movie_type");
		conditionMap.put("selectCondition2", "시즌");
		return movieMapper.selectMovieListCheck(conditionMap);
	}
	
	// 일반 현재상영작 수 조회
	public int getCountGeneralCurrentlyMovie() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("columnName", "movie_type");
		conditionMap.put("selectCondition", "일반");
		conditionMap.put("columnName2", "movie_status");
		conditionMap.put("selectCondition2", "현재상영작");
		return movieMapper.selectMovieCount(conditionMap);
	}
	
	// 시즌 현재상영작 수 조회
	public int getCountSeasonCurrentlyMovie() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("columnName", "movie_type");
		conditionMap.put("selectCondition", "시즌");
		conditionMap.put("columnName2", "movie_status");
		conditionMap.put("selectCondition2", "현재상영작");
		return movieMapper.selectMovieCount(conditionMap);
	}
	
	// 투표영화 리스트 조회
	public List<MovieVO> getPickMovieList() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("columnName", "movie_status");
		conditionMap.put("selectCondition", "투표영화");
		conditionMap.put("orderColumn", "movie_name");
		conditionMap.put("howOrder", "ASC");
		return movieMapper.selectMovieListCheck(conditionMap);
	}

	
}
