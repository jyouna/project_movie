package com.itwillbs.project_movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MoviePickController {
	
	// 영화투표하기 페이지 맵핑
	@GetMapping("MoivePick")
	public String moivePick() {
		return "movie_pick/movie_pick";
	}
	
	// PICK현황 페이지 맵핑
	@GetMapping("MoivePickStatus")
	public String moivePickStatus() {
		return "movie_pick/movie_pick_status";
	}
	
	// PICK결과보기 페이지 맵핑
	@GetMapping("MoivePickResult")
	public String moivePickResult() {
		return "movie_pick/movie_pick_result";
	}
	
	//관리자페이지 투표관리 투표설정 페이지 맵핑
	@GetMapping("AdminMoviePickSet")
	public String adminMoviePickSet() {
		return "adminpage/movie_pick_set/movie_pick_set";
	}
	
}
