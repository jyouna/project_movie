package com.itwillbs.project_movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.MovieVO;

@Mapper
public interface MovieMapper {
	
	// 영화 등록 메서드
	int insertMovie(MovieVO movieVO);
	// 영화 조회 메서드
	MovieVO SelectMovie(String movie_code);
	
	// 영화목록 수 조회 메서드
	int selectMovieListCount();
	
	// 영화목록 조회
	List<MovieVO> selectMovieList(@Param("startRow") int startRow, @Param("listLimit") int listLimit);
	
}
