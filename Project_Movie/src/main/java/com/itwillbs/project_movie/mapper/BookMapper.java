package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.ScheduleVO;
import com.itwillbs.project_movie.vo.SeatVO;
import com.itwillbs.project_movie.vo.TicketVO;

@Mapper
public interface BookMapper {

	List<MovieVO> selectMovieList();

	List<Map<String, Object>> selectSchWithMovie(Map<String, String> conditionMap);

	List<SeatVO> selectSeat();

	Map<String, String> getSelectMovie(String movie_code);

	List<TicketVO> selectTicketType();
	
	List<MovieVO> selectMovieList2(Map<String, String> conditionMap);

	List<ScheduleVO> selectScheduleList(Map<String, String> conditionMap);





}
