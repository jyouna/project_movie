package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.ScheduleVO;
import com.itwillbs.project_movie.vo.SeatVO;

@Mapper
public interface BookMapper {

	List<MovieVO> selectMovieList();

	List<Map<String, Object>> selectSchWithMovie();

	List<SeatVO> selectSeat();


}
