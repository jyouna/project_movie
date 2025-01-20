package com.itwillbs.project_movie.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class InquiryVO {
	private int inquiry_code;
	private String inquiry_subject;
	private String inquiry_writer;
	private String inquiry_content;
	private String inquiry_response;
	private String response_status;
	private Timestamp inquriy_date;
	private String admin_id;
	private Timestamp response_date;
	private String inquiry_writer_ip;
}
