package com.itwillbs.project_movie.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MoviePickMapper {
	
	// 투표 정보 등록
	int insertVoteInfo(Map<String, String> map);

}
