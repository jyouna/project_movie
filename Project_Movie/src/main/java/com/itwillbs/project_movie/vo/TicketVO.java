package com.itwillbs.project_movie.vo;

import lombok.Data;

@Data
public class TicketVO {
	/*
	CREATE TABLE ticket (
    ticket_code INT PRIMARY KEY,
    ticket_type INT,
    ticket_amount INT
	);
	 */
	
	private int ticket_code;
	private int ticket_type;
	private int ticket_amount;
}
