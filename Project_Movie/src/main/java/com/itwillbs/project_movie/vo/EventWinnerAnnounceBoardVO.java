package com.itwillbs.project_movie.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class EventWinnerAnnounceBoardVO {
	private int winner_code;
	private int winner_division;
	private String winner_subject;
	private Timestamp winner_announce_date;
	private int winner_views;
	private String winner_content;
}
