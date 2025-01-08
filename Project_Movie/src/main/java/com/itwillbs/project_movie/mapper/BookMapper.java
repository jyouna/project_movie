package com.itwillbs.project_movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.SeatVO;

@Mapper
public interface BookMapper {

	List<MovieVO> selectMovieList();

	List<SeatVO> selectSeat();

}
