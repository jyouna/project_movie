package com.itwillbs.project_movie.vo;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Data;

@Data // 예매 취소 테이블
public class Refund {
	private int refund_code; 
	private String payment_code;          // 결제 코드
	private int refund_request_amount;    // 환불 요청 금액
	private Timestamp refund_request_date;  // 취소 요청일
	private Timestamp refund_completed_date; // 취소 완료일
	private int refund_amount;                // 환블 완료 금액
	private int refund_status; // 취소 상태 => 0 미완 1 완료
}
