package com.itwillbs.project_movie.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Data;


// DB에는 없는 VO 객체
// 이벤트 당첨자 목록 출력 시 event_board 테이블과 
//	coupon 테이블을 join한 결과값을 임시로 저장하기 위해 만든 객체

@Data
public class EventWinnerVO {
	private int event_code;
	private String winner_id;
	private String event_subject;
	private Date event_start_date;
	private Date event_end_date;
	private Boolean coupon_type; // 0 금액할인 1 할인율
	private int discount_amount = 0;
	private int discount_rate = 0;
	private Timestamp prize_datetime;
	private int point_amount = 0;
}
