package com.itwillbs.project_movie.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class AdminRegisVO {
	private String admin_id;
	private String admin_passwd;
	private Date start_date;
	private Boolean user_status;
	private String user_name;
	private Boolean member_manage;
	private Boolean payment_manage;
	private Boolean notice_board_manage;
	private Boolean movie_manage;
	private Boolean theater_manage;
	private Boolean vote_manage;
}
