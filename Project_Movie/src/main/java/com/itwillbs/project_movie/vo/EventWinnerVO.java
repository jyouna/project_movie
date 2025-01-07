package com.itwillbs.project_movie.vo;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class EventWinnerVO {
	private int winner_code;
	private int event_code;
	private String winner_id;
	private int winner_point;
	private String winner_coupon_type;
	private String winner_coupon_rate;
	private Boolean prize_status;
	private Timestamp prize_date;
}
