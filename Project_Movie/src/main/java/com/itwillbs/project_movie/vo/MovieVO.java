package com.itwillbs.project_movie.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class MovieVO {
	private String movie_code;
	private String movie_name;
	private String movie_genre;
	private String movie_director;
	private String movie_actor;
	private Date release_date;
	private int running_time;
	private String age_limit;
	private double movie_rating;
	private String movie_synopsis;
	private String movie_status;
	private String movie_img1;
	private String movie_img2;
	private String movie_img3;
	private String movie_img4;
	private String movie_img5;
	private String movie_trailer;
	private Date regist_date;
	private String regist_admin_id;
	
	// json형태로 movieVO 응답할때 timestamp 형태로 응답되서
	// String 타입으로 변환후 응답하기위해 멤버변수 추가
	private String str_regist_date;
	private String str_release_date;
	
}
