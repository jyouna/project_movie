package com.itwillbs.project_movie.vo;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;
@Data
public class PointVO {
	// 포인트 증가, 감소와 그 원인을 기록하기 위한 테이블
	// 포인트는 만료일 없음
	private int point_code; // 고유코드
	private int point_credited; // 포인트 +
	private int point_debited; // 포인트 -
	private int event_code;  // 포인트 적립 요인 기록(이벤트 당첨, 환불)
	private String point_holder; // 포인트 소유자
	private String booking_code; // 포인트 차감 요인 기록(예매)
	private Timestamp regis_date; // 등록일시
	private int refund_code; // 취소코드
}