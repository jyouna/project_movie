package com.itwillbs.project_movie.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class EventBoardVO {
	private int event_code;           // 0번은 이벤트가 아니라 관리자가 임의로 직접 발급한 쿠폰을 표시하기 위해 사용
	private String event_subject;
	private String event_content;
	private String event_file1;    
	private String event_file2;
	private String event_file3;
	private String event_writer;
	private Timestamp regis_date;
	private int view_count;
	private int event_status; 	// 0-대기  1-진행   2-종료
	private Date event_start_date;
	private Date event_end_date;
	private Boolean set_winner_status = false;
}


