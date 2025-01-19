package com.itwillbs.project_movie.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project_movie.service.MoviePickService;
import com.itwillbs.project_movie.service.MovieService;
import com.itwillbs.project_movie.vo.MovieVO;

@Controller
public class MoviePickController {
	
	@Autowired
	MovieService movieService;
	
	@Autowired
	MoviePickService moviePickService;
	
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
	public String adminMoviePickSet(Model model) {
		// 투표영화리스트 조회
		List<MovieVO> movieList = movieService.getPickMovieList();
		
		return "adminpage/movie_pick_set/movie_pick_set";
	}
	
	// 투표설정 페이지의 투표등록 form
	@PostMapping("RegistPickInfo")
	public String registPickInfo(@RequestParam Map<String, String> map, Model model) {
		// 투표시작날짜와 끝날짜를 더해 투표코드 생성
		String vote_code = (map.get("start_date") + map.get("end_date")).replace("-", "");
		map.put("vote_code", vote_code);
		
		int insertCount = moviePickService.registMoviePickInfo(map);
		
		if(insertCount > 0) {
			return "redirect:/RegistPickInfoSuccess";
		} else {
			model.addAttribute("msg", "투표등록 실패하였습니다.");
			return "result/process";
		}
	}
	
	// 투표등록 완료후 리다이렉트
	@GetMapping("RegistPickInfoSuccess")
	public String registPickInfoSuccess(Model model) {
		model.addAttribute("msg", "투표등록 완료하였습니다.");
		model.addAttribute("targetURL", "AdminMoviePickSet");
		return "result/process";
	}
	
	
}
