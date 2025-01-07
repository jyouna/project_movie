package com.itwillbs.project_movie.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class EventBoardVO {
	private int event_code;
	private String event_subject;
	private String event_content;
	private String event_file1;
	private String event_file2;
	private String event_file3;
	private String event_writer;
	private Timestamp regis_date;
	private int view_count;
	private int event_status;
	private Date event_start_date;
	private Date event_end_date;
}
