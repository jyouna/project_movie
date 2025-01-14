package com.itwillbs.project_movie.vo;

import java.sql.Timestamp;

import lombok.Data;
@Data
public class ReservationDetailVO {
	private int r_code;
	private int r_num;
	private String r_moviename;
	private int r_people;
	private String r_seat;
	private String r_theater;
	private int r_price;
	private Timestamp r_date;
	
	private String r_dateToString;
}
