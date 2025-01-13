package com.itwillbs.project_movie.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;


// DB 테이블은 존재하지 않는 클래스로, 마이페이지 및 관리자 회원관리 시 
// JOIN 구문 후 데이터 저장 시 편의를 위해 작성

@Data
public class MemberAllInfoVO {
	private String member_id; 
	private String member_passwd;
	private String member_name;
	private Date birth_date;
	private String email;
	private String phone;
	private String gender; // 비교를 위해 char로 저장한 memeberVO와 다르게 String으로 저장
	private String gerne;
	private boolean text_receive;      // 문자 수신 동의 (0: 미동의, 1: 동의)
	private boolean email_receive;     // 이메일 수신 동의 (0: 미동의, 1: 동의)
	private boolean info_open;         // 정보 공개 여부 (0: 비공개, 1: 공개)
	private boolean email_auth_status; // 이메일 인증 상태 (0: 미인증, 1: 인증)
	private boolean phone_auth_status; // 전화번호 인증 상태 (0: 미인증, 1: 인증)
	private int member_type;           // 회원 유형 (일반, 관리자 등 구분)
	private int remain_point;			// 잔여 포인트
	private int coupon_num; 			// 보유 쿠폰 개수
	private int member_status;         // 회원 상태 (1: 정상, 2: 휴면, 3: 탈퇴)
	private Timestamp regis_date;         	// 회원가입일자
}
