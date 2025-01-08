package com.itwillbs.project_movie.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;


// 쿠폰 등록시 view에서 컨트롤러로 전달된 파라미터 값을 임시로 저장하기 위해 만든 객체

@Data
public class GetGiveCouponInfoVO {
	private List<String> member_id;
	private Date expired_date;
	private String coupon_type;
	private String discount_amount;
	private String discount_rate;
	private int event_code;
}