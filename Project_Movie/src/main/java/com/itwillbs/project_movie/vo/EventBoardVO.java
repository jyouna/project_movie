package com.itwillbs.project_movie.vo;

import java.sql.Date;

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
	private Date regis_date;
	private int view_count;
}
