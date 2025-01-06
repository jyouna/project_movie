package com.itwillbs.project_movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class MainController {

	// main페이지 맵핑
	@GetMapping("/")
	public String home() {
		return "main";
	}
	
	@GetMapping("AdminpageMain")
	public String AdminpageMain() {
		return "adminpage/adminpage_main";
	}
	
}
