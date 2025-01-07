package com.itwillbs.project_movie.vo;

public class BookVO {
	/*
	CREATE TABLE booking (
    booking_code VARCHAR(200) PRIMARY KEY,
    payment_code INT,
    seat_code VARCHAR(10),
    ticket_code INT,
    ticket_price INT NOT NULL,
    schedule_code VARCHAR(30),
    FOREIGN KEY (payment_code) REFERENCES payment(payment_code),
    FOREIGN KEY (seat_code) REFERENCES seat(seat_code),
    FOREIGN KEY (ticket_code) REFERENCES ticket(ticket_code)
    FOREIGN KEY (schedule_code) REFERENCES schedule(schedule_code)	
	);
	 */
	
	private String booking_code;	// 예매번호
	private int payment_code;		// 결제 코드
	private String seat_code;		// 좌석 코드
	private int ticket_code;		// 티켓 분류(성인, 청소년, 노약자)
	private int ticket_price;		// 티켓 금액
	private String schedule_code;	// 스케줄 코드
	
	
}
