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

/*
 * 	이벤트 당첨자 출력 구문
 *  
 * SELECT 
1	    e.event_code AS event_code,
2	    c.member_id AS winner_id,
3	    e.event_subject AS event_subject,
4	    e.event_start_date AS event_start_date,
5	    e.event_end_date AS event_end_date,
6	    CASE 
	        WHEN c.discount_amount IS NOT NULL THEN c.discount_amount
	        ELSE NULL
	    END AS 할인,
7	    CASE 
	        WHEN c.discount_rate IS NOT NULL THEN c.discount_rate
	        ELSE NULL
	    END AS 할인률,
8	    CASE 
	        WHEN p.point_credited IS NOT NULL THEN p.point_credited
	        ELSE NULL
	    END AS 포인트,
	    
9	    COALESCE(c.regis_date, p.regis_date) AS prize_datetime -- 첫번째로 NULL 값이 아닌 수를 반환! 
	
	FROM event_board e
	LEFT JOIN coupon c ON e.event_code = c.event_code
	LEFT JOIN point p ON e.event_code = p.event_code
	
	WHERE 
	    (c.discount_amount IS NOT NULL AND p.point_credited IS NULL) 
	    OR (c.discount_amount IS NULL AND p.point_credited IS NOT NULL)
	
	ORDER BY event_code ASC;
 * 
 * 
 * 
 * 
 * 
 */