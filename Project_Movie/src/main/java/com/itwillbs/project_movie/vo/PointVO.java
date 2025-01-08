package com.itwillbs.project_movie.vo;

import lombok.Data;
@Data
public class PointVO {
	// 포인트 증가, 감소와 그 원인을 기록하기 위한 테이블
	private int point_code; // 고유코드
	private int point_credited = 0; // 포인트 적립
	private int point_debited = 0; // 포인트 차감
	private int event_code;  // 포인트 적립 요인 기록(이벤트 당첨)
	private String point_holder; // 포인트 소유자
	private String booking_code; // 포인트 차감 요인 기록(예매)
}