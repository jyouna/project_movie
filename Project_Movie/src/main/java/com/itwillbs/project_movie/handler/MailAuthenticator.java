package com.itwillbs.project_movie.handler;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

import org.springframework.stereotype.Component;


// 자바 메일 기능 사용 시 메일 서버(ex. 네이버, Gmail 등) 인증을 위한 정보를 관리하는 클래스 정의
@Component
public class MailAuthenticator extends Authenticator {
	// 앱비밀번호 : kxnankeqtkqfgpac
	// 인증정보(아이디, 패스워드) 를 관리할 PasswordAuthentication 클래스 타입 멤버변수 선언
	PasswordAuthentication passwordAuthentication;
	
	// 기본 생성자 정의
	public MailAuthenticator() {
		/*
		 * 인증에 사용될 아이디와 패스워드를 파라미터로 전달받는 PasswordAuthentication 객체 생성
		 * - 파라미터 : 메일 서버의 계정명, 패스워드
		 *   => 네이버, Gmail 기준 2단계 인증 미사용 시 : 계정명, 패스워드
		 *   => 네이버, Gmail 기준 2단계 인증 사용 시 : 계정명, 앱 비밀번호
		 *      (단, 사용 메일 계정에 대한 2단계 인증 활성화 및 앱 비밀번호 등록 필요)
		 *      (앱 비밀번호는 로그인 등의 다른 서비스에서는 사용 불가능하며, 특정 서비스에서만 사용)
		 */
//		passwordAuthentication = new PasswordAuthentication("ytlee7066@gmail.com", "kxnankeqtkqfgpac");
	}

	/*
	 * 인증 정보 관리 객체(PasswordAuthentication)를 외부로 리턴하는 getPasswordAuthentication() 메서드 정의
	 * => 주의! Getter 메서드를 직접 정의 시 멤버변수명에 따라 메서드명이 달라지는데
	 *    외부에서 getPasswordAuthentication() 메서드를 직접 호출하는 것이 아니라
	 *    객체 내에서 자동으로 호출되므로 미리 약속된 메서드명으로 정의 필수!
	 * => 슈퍼클래스인 Autheneticator 클래스의 getPasswordAuthentication() 메서드 오버라이딩하자!
	 */
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		// 외부에서 자동으로 메서드가 호출될 때
		// PasswordAuthentication 객체가 생성되도록 생성자 호출 코드를 기술			xgbarnzqdlqedrdl
		passwordAuthentication = new PasswordAuthentication("8888jangs@gmail.com", "xgbarnzqdlqedrdl");
		return passwordAuthentication;
	}
	
	
}













