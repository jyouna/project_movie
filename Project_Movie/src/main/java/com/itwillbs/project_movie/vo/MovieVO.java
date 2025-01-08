package com.itwillbs.project_movie.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class MovieVO {
	private String movie_code;				// 영화코드
	private String movie_name;   			// 영화명
	private String movie_genre;   			// 영화장르
	private String movie_director;			// 영화감독
	private String movie_actor;				// 영화배우
	private Date release_date;				// 개봉일
	private int running_time;				// 러닝타임
	private String age_limit;				// 관람등급
	private double movie_rating;			// 영화평점
	private String movie_synopsis;			// 줄거리
	private String movie_status;			// 영화상태(대기, 투표영화, 상영예정작, 현재상영작, 지난상영작)
	private String movie_img1;				// 영화이미지1
	private String movie_img2;				// 영화이미지2
	private String movie_img3;				// 영화이미지3
	private String movie_img4;				// 영화이미지4
	private String movie_img5;				// 영화이미지5
	private String movie_trailer;			// 예고편
	private Timestamp regist_date;			// 등록날짜
	private String regist_admin_id;			// 등록계정
	private String movie_type;				// 영화타입(일반, 시즌)
	private Date start_screening_date;      // 상영 시작날짜
	private Date end_screening_date;        // 상영 끝날짜
	
	// json형태로 movieVO 응답할때 timestamp 형태로 응답되서
	// String 타입으로 변환후 응답하기위해 멤버변수 추가
	private String str_regist_date;
	private String str_release_date;
	
}
