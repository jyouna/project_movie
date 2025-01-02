package com.itwillbs.project_movie.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.handler.GenerateRandomCode; //*****수정전: mvc_board ----> 수정후: project_movie *****
import com.itwillbs.project_movie.handler.MailClient; //*****수정전: mvc_board ----> 수정후: project_movie *****
import com.itwillbs.project_movie.vo.EmailAuthVO; //*****수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
import com.itwillbs.project_movie.vo.MemberVO;
//민기

@Service
public class MailService {
	@Autowired
	private MailClient mailClient;

	// 인증 메일 발송 요청 메서드
	// *****수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
	public EmailAuthVO sendAuthMail(MemberVO member) {
		// 인증 메일에 포함시킬 인증코드(난수) 생성
		// GenerateRandomCode 클래스의 static 메서드 getRandomCode() 메서드 호출하여 난수 요청
		// => 파라미터 : 생성할 난수 길이(정수)  리턴타입 : String(mail_auth_code) 
		// *****수정전: auth_code ----> 수정후: mail_auth_code *****
		String mail_auth_code = GenerateRandomCode.getRandomCode(50); 
		System.out.println("생성된 인증 코드 : " + mail_auth_code); //*****수정전: auth_code ----> 수정후: mail_auth_code *****

		// ===================================================================================
		// [ 인증 메일 발송 요청 ]
		// 인증 메일에 포함할 제목과 본문 생성
		String subject = "[아이티윌] 가입 인증 메일입니다";

		// 인증을 위한 하이퍼링크를 포함할 경우(이메일 본문에는 HTML 태그 사용 가능)
		// *****수정전: auth_code ----> 수정후: mail_auth_code *****
		String url = "http://localhost:8081/project_movie/MemberEmailAuth?email=" + member.getEmail() + "&auth_code=" + mail_auth_code;
		String content = "<a href='" + url + "'>이메일 인증을 수행하려면 이 링크를 클릭하세요!</a>";

		// 메일 발송을 별도의 쓰레드에서 수행
		new Thread(new Runnable() {
			@Override
			public void run() {
				// 메일 발송 코드
				mailClient.sendMail(member.getEmail(), subject, content);
			}
		}).start(); // ***** start() 필수 호출! *****

		// ============================================================================

		// *****수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
		// 메일 발송에 사용한 이메일주소와 인증코드 정보를 EmailAuthVO 객체에 저장 후 리턴
		EmailAuthVO emailAuthInfo = new EmailAuthVO(member.getEmail(), mail_auth_code); //*****수정전: auth_code ----> 수정후: mail_auth_code *****

		return emailAuthInfo; //*****수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
	}
}
