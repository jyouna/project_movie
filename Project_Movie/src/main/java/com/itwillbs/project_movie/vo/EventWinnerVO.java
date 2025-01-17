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
<select id="getAllEventWinnerList" resultType="map">
	SELECT 
		e.event_code AS event_code,
		CONCAT(ifnull(c.member_id, ""), ifnull(p.point_holder,"")) AS winner_id,
		e.event_subject AS event_subject,
		e.event_start_date AS event_start_date,
		e.event_end_date AS event_end_date,
	    IFNULL(c.discount_amount, NULL) AS discount_amount,
	    IFNULL(c.discount_rate, NULL) AS discount_rate,
	    IFNULL(p.point_credited, NULL) AS point_amount,
		COALESCE(c.regis_date, p.regis_date) AS prize_datetime -- 첫번째로 NULL 값이 아닌 수를 반환! 
	FROM event_board e 
		LEFT JOIN coupon c ON e.event_code = c.event_code 
		LEFT JOIN point p ON e.event_code = p.event_code
	WHERE 
		((c.discount_amount is null AND c.discount_rate is null) 
			AND (p.point_credited is not null)) 
	    OR ((c.discount_amount is not null AND c.discount_rate is not null) 
	    	AND (p.point_credited is null))
	ORDER BY event_code ASC
	LIMIT
		#{startRow},
		#{listLimit}		
</select>
 * 
 * 
 * 
 * 
 */