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
	private int ticket_type; // 티켓분류(0 : 성인, 1 : 청소년, 2 : 경로/우대)
	private int ticket_amount; // 티켓 금액
}
