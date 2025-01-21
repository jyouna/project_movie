package com.itwillbs.project_movie.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PaymentVO {
	private String payment_code;			// 예매번호
	private Timestamp payment_date;			// 결제날짜
	private String member_id;				// 회원 아이디
	private String schedule_code;			// 스케줄 코드
	private int ticket_count;				// 티켓 수(좌석 수)
	private int total_amount;				// 총 결제금액
	private int point_discount;				// 포인트 할인
	private int coupon_discount;			// 쿠폰 할인
	private int total_discount;				// 총 할인금액
	private int total_payment;				// 최종 결제금액
	private Timestamp seat_selection_time;	// 결제버튼 클릭시간
	private String payment_method;			// 결제수단
	private int payment_status;				// 결제여부
	private String total_seat_code;			// 선택한 좌석
}
