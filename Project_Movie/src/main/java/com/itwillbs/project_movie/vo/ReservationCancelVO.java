package com.itwillbs.project_movie.vo;

import java.sql.Timestamp;

import lombok.Data;
@Data
public class ReservationCancelVO {
	private String r_moviename;
	private Timestamp r_date;
	private int r_people;
	private int r_cancelstatus;
	private Timestamp r_canceldate;
	private int r_cancelprice;
}

