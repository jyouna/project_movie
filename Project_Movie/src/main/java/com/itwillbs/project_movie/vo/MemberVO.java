package com.itwillbs.project_movie.vo;

import java.sql.Date;
import lombok.Data;
//민기

/*
[ member 테이블 구조에 맞춘 VO 클래스 ]
----------------------------------------------
Columns:
	member_id varchar(20) PK
	member_passwd varchar(50)
	member_name varchar(10)
	birth_date date
	email varchar(100)
	phone varchar(20)
	gender char(1)
	gerne varchar(100)
	text_receive tinyint
	email_receive tinyint
	info_open tinyint
	point int
	member_type int
	email_auth_status tinyint
	phone_auth_status tinyint
	member_status int
----------------------------------------------
*/
@Data
public class MemberVO {
	// 기본 회원 정보
	private String member_id;          // 회원 아이디 (PK)
	private String member_passwd;      // 회원 비밀번호
	private String member_name;        // 회원 이름
	
	// 추가 정보
	private Date birth_date;           // 생년월일
	private String email;              // 이메일 주소
	private String phone;              // 전화번호
	
	// 기타 정보
	private char gender;               // 성별 (M/F/)   +N
	private String gerne;              // 관심 장르 (최대 100자)
	
	// 수신 및 공개 설정
	private boolean text_receive;      // 문자 수신 동의 (0: 미동의, 1: 동의)
	private boolean email_receive;     // 이메일 수신 동의 (0: 미동의, 1: 동의)
	private boolean info_open;         // 정보 공개 여부 (0: 비공개, 1: 공개)
	
	// 회원 관리
	private boolean email_auth_status; // 이메일 인증 상태 (0: 미인증, 1: 인증)
	private int member_status;         // 회원 상태 (1: 정상, 2: 휴면, 3: 탈퇴)

	
	
	private int point;                 // 포인트
	private int member_type;           // 회원 유형 (일반, 관리자 등 구분)
	private boolean phone_auth_status; // 전화번호 인증 상태 (0: 미인증, 1: 인증)
}





/*
package com.itwillbs.project_movie.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


[ spring_mvc_board.member 테이블 정의 ]
----------------------------------------------
번호(idx) - 정수, PK, 자동증가(AUTO_INCREMENT)
이름(name) - 문자 10자, NN
아이디(id) - 문자 16자, UN, NN
패스워드(passwd) - 문자 100자, NN (단방향 암호화로 인해 문자열 길이가 16자리보다 길어짐)
우편번호(post_code) - 문자 10자, NN
기본주소(address1) - 문자 100자, NN
상세주소(address2) - 문자 100자, NN
이메일(email) - 문자 50자, UN, NN
직업(job) - 문자 10자, NN
성별(gender) - 문자 1자, NN
취미(hobby) - 문자 50자, NN
가입동기(motivation) - 문자 500자, NN
가입일(reg_date) - 날짜 및 시각(DATETIME), NN
탈퇴일자(withdraw_date) - 날짜 및 시각(DATETIME)
회원상태(member_status) - 정수, NN(1 : 정상, 2 : 휴면, 3 : 탈퇴)
메일인증상태(mail_auth_status) - 문자 1자, NN('Y' : 인증, 'N' : 미인증)
-----------------------------------------------
CREATE DATABASE spring_mvc_board;
-----------------------------------------------
CREATE TABLE member (
	idx INT PRIMARY KEY AUTO_INCREMENT,
 	name VARCHAR(10) NOT NULL,
 	id VARCHAR(16) NOT NULL UNIQUE,
 	passwd VARCHAR(100) NOT NULL,
 	post_code VARCHAR(10) NOT NULL,
 	address1 VARCHAR(100) NOT NULL,
 	address2 VARCHAR(100) NOT NULL,
 	email VARCHAR(50) NOT NULL UNIQUE,
 	job VARCHAR(10) NOT NULL,
 	gender VARCHAR(1) NOT NULL,
 	hobby VARCHAR(50) NOT NULL,
 	motivation VARCHAR(500) NOT NULL,
 	reg_date DATETIME NOT NULL,
 	withdraw_date DATETIME,
	member_status INT NOT NULL,
	mail_auth_status CHAR(1) NOT NULL
);


@Data
public class MemberVO {
	private int idx;
	private String name;
	private String id;
	private String passwd;
	private String post_code;
	private String address1;
	private String address2;
	// ----------------------------------------------------------------------------------
	// 회원가입 폼에서 입력받은 이메일 주소는 email1, email2 라는 파라미터명을 사용하므로
	// MemberVO 객체에 email1, email2 라는 멤버변수가 필요하며
	// INSERT 과정에서 email1 과 email2 값을 결합 후 전달도 가능하다!
	// 단, 뷰페이지(JSP)에서 자바스크립트를 활용하여 email1, email2 파라미터를 결합하여
	// 폼 파라미터로 전송할 경우 email1, email2 멤버변수는 불필요
	private String email;
	private String email1;
	private String email2;
	// ----------------------------------------------------------------------------------
	private String job;
	private String gender;
	private String hobby; // 체크박스 값 복수개의 파라미터가 하나의 값으로 자동 결합됨(, 로 구분)
	private String motivation;
	private Date reg_date; // 가입일자 - java.sql.Date
	private Date withdraw_date; // 탈퇴일자 - java.sql.Date
	private int member_status; // 회원상태(1 : 정상, 2 : 휴면, 3 : 탈퇴)
	private String mail_auth_status; // 이메일 인증상태('Y' : 인증, 'N' : 미인증)
	
	
	
	
}

*/



















