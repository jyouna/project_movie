package com.itwillbs.project_movie.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class WatchedMovieVO {
	private String w_moviename;
	private Timestamp w_date;
	private int w_review;
	private int w_people;
}
