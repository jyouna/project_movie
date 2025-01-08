package com.itwillbs.project_movie.vo;


import java.sql.Timestamp;

import lombok.Data;

@Data
public class ScheduleVO {
	
		private String schedule_code;		// 스케줄 코드
		private String movie_code;			// 영화 코드
		private Timestamp start_time;		// 스케줄 시작날짜시간
		private Timestamp end_time;			// 스케줄 끝날짜시간
		private Timestamp next_schedule;	// 다음스케줄 시작가능날짜시간
		private int booking_avail;			// 예매가능 여부
		private String theater_code;		// 상영관 코드
		private int avail_seat;				// 예매가능 좌석수
		private String showtime_type;		// 상영시간대 타입(조조, 일반, 심야)
		
		private String str_start_time;		// 날짜 시간 변환을 위한 String 타입 날짜
		private String str_end_time;		
}
