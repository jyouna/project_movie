package com.itwillbs.project_movie.vo;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class AdminRegisVO {
	private String admin_id;
	private String admin_passwd;
	private Timestamp start_date;
	private Boolean user_status = true;
	private String user_name;
	private Boolean member_manage = false; // 관리자 계정, 회원목록 및 통계관리 권한
	private Boolean payment_manage = false; // 결제관리 권한
	private Boolean notice_board_manage = false;  // 고객지원(공지사항, FAQ, 1:1 문의) 관리 권한
	private Boolean movie_manage = false; // 영화관리 권한
	private Boolean theater_manage = false; // 영화관 관리 권한
	private Boolean vote_manage = false; // 이벤트, 포인트, 쿠폰, 투표 관리 권한
}
