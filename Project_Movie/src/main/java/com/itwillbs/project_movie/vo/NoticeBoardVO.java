package com.itwillbs.project_movie.vo;

import java.sql.Timestamp;

import lombok.Data;
@Data
public class NoticeBoardVO {
	private int notice_code;
	private String notice_subject;
	private String notice_content;
	private String notice_file1;
	private String notice_file2;
	private String notice_file3;
	private String notice_writer;
	private Timestamp regis_date;
	private int view_count;	
}