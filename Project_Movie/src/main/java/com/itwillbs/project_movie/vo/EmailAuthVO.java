package com.itwillbs.project_movie.vo;

import lombok.AllArgsConstructor;

import lombok.Data;
import lombok.NoArgsConstructor;

//민기

/*
 * [ 회원 이메일 인증 정보를 관리할 mail_auth_info 테이블 정의 ]
 * --------------------------------------------------------------
 * 이메일(email) - 50자, PK
 * 인증코드(auth_code) - 50자, UN, NN
 * --------------------------------------------------------------
   CREATE TABLE mail_auth_info (
   		email VARCHAR(50) PRIMARY KEY,
   		auth_code VARCHAR(50) UNIQUE NOT NULL
   );
 */





// 메일 인증 정보 1개를 관리하는 클래스 정의
@Data
@AllArgsConstructor
@NoArgsConstructor


public class EmailAuthVO {
	private String email;
	private String mail_auth_code;
	//수업때랑 컬럼명 다름. 유의
}











