package com.itwillbs.project_movie.vo;

import lombok.Data;

@Data
public class TheaterVO {
	/*
	CREATE TABLE theater (
    theater_code VARCHAR(10) PRIMARY KEY,
    theater_name VARCHAR(20) UNIQUE NOT NULL,
    total_seat INT NOT NULL
	);
	*/
	
	private String theater_code;
	private String theater_name;
	private int total_seat;
}
