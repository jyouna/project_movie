package com.itwillbs.project_movie.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class CouponVO {
	private int coupon_code; // 쿠폰 코드
	private Boolean coupon_type; // 쿠폰 타입(0 = 금액, 1 = 비율)
	private int discount_amount; // 할인금액
	private int discount_rate; // 할인 비율
	private Timestamp regis_date; // 등록일
	private Date expired_date; // 만료일
	private Boolean coupon_status; // 쿠폰 상태(0 = 미사용, 1 = 사용완료)
	private String member_id; // 쿠폰 소유 계정
	private int event_code; // 이벤트 코드 참조
}
