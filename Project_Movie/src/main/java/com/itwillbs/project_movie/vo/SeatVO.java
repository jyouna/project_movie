package com.itwillbs.project_movie.vo;

import lombok.Data;

@Data
public class SeatVO {
	/*
	CREATE TABLE seat (
    seat_code VARCHAR(10) PRIMARY KEY,
    seat_row CHAR(1) NOT NULL,
    seat_col INT NOT NULL,
    seat_type VARCHAR(20) NOT NULL CHECK ( seat_type IN ('일반석', '장애인석')),
    theater_code VARCHAR(10) NOT NULL,
    FOREIGN KEY (theater_code) REFERENCES theater(theater_code)
	);
	 */
	
	private String seat_code;
	private String seat_row;
	private int seat_col;
	private String seat_type;
	private String theater_code;
}
