package com.itwillbs.project_movie.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class FaqBoardVO {
	private int faq_code;
	private String faq_subject;
	private String faq_content;
	private String faq_file1;
	private String faq_file2;
	private String faq_file3;
	private Timestamp regis_date;
	private int view_count;
	
}
