package com.itwillbs.project_movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
	
	@GetMapping("AdminpageMain")
	public String AdminpageMain() {
		return "adminpage/adminpage_main";
	}
}
