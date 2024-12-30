package com.itwillbs.project_movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MovieController {
	
	// 영화안내 시즌무비 페이지 맵핑
	@GetMapping("SeasonMovieInfo")
	public String seasonMovieInfo() {
		return "movie_info/season_movie_info";
	}
	
	// 영화안내 현재상영작 페이지 맵핑
	@GetMapping("CurrentlyMovieInfo")
	public String currentlyMovieInfo() {
		return "movie_info/currently_movie_info";
	}
	
	// 영화안내 상영예정작 페이지 맵핑
	@GetMapping("UpcomingMovieInfo")
	public String upcomingMovieInfo() {
		return "movie_info/upcoming_movie_info2";
	}
	
	// 영화안내 지난상영작 페이지 맵핑
	@GetMapping("PastMovieInfo")
	public String pastMovieInfo() {
		return "movie_info/past_movie_info";
	}
	
	// 영화상세안내 페이지 맵핑
	@GetMapping("MovieInfoDetail")
	public String movieInfoDetail() {
		return "movie_info/movie_info_detail";
	}
	
	//관리자페이지 영화관리 영화목록 페이지 맵핑
	@GetMapping("AdminMovieSetList")
	public String adminMovieSetList() {
		return "adminpage/movie_set/admin_movie_list";
	}
	
	//관리자페이지 영화관리 상영예정작 페이지 맵핑
	@GetMapping("AdminMovieSetUpcoming")
	public String adminMovieSetUpcoming() {
		return "adminpage/movie_set/upcoming_movie_set";
	}
	
	//관리자페이지 영화관리 현재상영작 페이지 맵핑
	@GetMapping("AdminMovieSetCurrently")
	public String aminMovieSetCurrently() {
		return "adminpage/movie_set/currently_movie_set";
	}
	
	//관리자페이지 영화관리 지난상영작 페이지 맵핑
	@GetMapping("AdminMovieSetPast")
	public String AdminMovieSetPast() {
		return "adminpage/movie_set/past_movie_set";
	}
}
