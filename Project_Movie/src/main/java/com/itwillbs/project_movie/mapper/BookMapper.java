package com.itwillbs.project_movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_movie.vo.MovieVO;

@Mapper
public interface BookMapper {

	List<MovieVO> selectMovieList();

}
