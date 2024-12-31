package com.itwillbs.project_movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TheaterInfoController {
	// 영화관 안내 - 영화관 안내
	@GetMapping("TheaterInfo")
	public String theaterInfo() {
		return"theater_info/theater_info";
	}
	// 영화관 안내 - 좌석 안내
	@GetMapping("SeatingInfo")
	public String seatingInfo() {
		return"theater_info/seating_info";
	}
	// 영화관 안내 - 오시는 길 안내
	@GetMapping("DirectionsInfo")
	public String directionsInfo() {
		return"theater_info/directions_info";
	}
}
