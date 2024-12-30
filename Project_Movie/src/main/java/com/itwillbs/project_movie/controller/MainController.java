package com.itwillbs.project_movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.project_movie.service.MemberService;

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
