package com.itwillbs.project_movie.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.MoviePickMapper;

@Service
public class MoviePickService {
	
	@Autowired
	MoviePickMapper moviePickMapper;
	
	// 투표정보 등록 메서드
	public int registMoviePickInfo(Map<String, String> map) {
		return moviePickMapper.insertVoteInfo(map);
	}
}
