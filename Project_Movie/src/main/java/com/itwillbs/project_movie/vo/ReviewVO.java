package com.itwillbs.project_movie.vo;
//250122 장민기
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Data;

@Data // 리뷰등록을 위한 테이블입니다
public class ReviewVO {
	private int review_code;         //리뷰 번호
	private String movie_code;       //영화 코드        
	private String review_content;   //한줄 리뷰
	private String review_writer;    //리뷰 작성자      
	private int review_recommend;    //리뷰 추천 여부 

}

/*
 
Table: review

Columns:
review_code int AI PK 

movie_code varchar(30) 

review_content text 

review_writer varchar(20) 

review_recommend (-> boolean) int  
다른 부분 편의상 int로 설정?

*/