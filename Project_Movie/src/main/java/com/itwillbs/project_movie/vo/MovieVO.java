package com.itwillbs.project_movie.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MovieVO {
	private String movie_code;
	private String movie_name;
	private String movie_genre;
	private String movie_director;
	private String movie_actor;
	private String release_date;
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
	private Timestamp regist_date;
	private String regist_admin_id;
	
}
