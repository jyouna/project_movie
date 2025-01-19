package com.itwillbs.project_movie.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_movie.handler.GenerateRandomCode;
import com.itwillbs.project_movie.handler.MailClient;
import com.itwillbs.project_movie.mapper.MemberMapper;
import com.itwillbs.project_movie.vo.EmailAuthVO;
import com.itwillbs.project_movie.vo.MemberVO;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Service
public class MailService {

    @Autowired
    private MailClient mailClient;

    @Autowired
    private MemberMapper mapper;

    // 인증 메일 발송 메서드
    public EmailAuthVO sendAuthMail(MemberVO member) {
        try {
            // 1. 인증 코드 생성
            String mail_auth_code = GenerateRandomCode.getRandomCode(50);
            System.out.println("생성된 인증 코드 : " + mail_auth_code);

            // 2. URL 인코딩 추가
            String encodedEmail = URLEncoder.encode(member.getEmail(), StandardCharsets.UTF_8);
            String encodedAuthCode = URLEncoder.encode(mail_auth_code, StandardCharsets.UTF_8);

            
            // 3. 인증 링크 생성
            String subject = "[Project Movie] 가입 인증 메일입니다";
            String url = "http://localhost:8081/project_movie/MemberEmailAuth?email=" + encodedEmail + "&auth_code=" + encodedAuthCode;
            String content = "<a href='" + url + "'>이메일 인증을 수행하려면 이 링크를 클릭하세요!</a>";

            // 4. 메일 발송 (예외 처리 추가)
            new Thread(() -> {
                try {
                    mailClient.sendMail(member.getEmail(), subject, content);
                    System.out.println("메일 전송 성공: " + member.getEmail());
                } catch (Exception e) {
                    e.printStackTrace();
                    System.err.println("메일 전송 실패: " + member.getEmail() + " - " + e.getMessage());
                }
            }).start();

            // 5. 인증 정보 반환
            return new EmailAuthVO(member.getEmail(), mail_auth_code);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("메일 인증 처리 중 오류 발생!", e);
        }
    }
    
    

    // 이메일 인증 정보 등록 메서드
    public void registMailAuthInfo(EmailAuthVO email_auth) {
        EmailAuthVO dbMailAuthInfo = mapper.selectMailAuthInfo(email_auth);

        if (dbMailAuthInfo == null) {
            mapper.insertMailAuthInfo(email_auth);
        } else {
            mapper.updateMailAuthInfo(email_auth);
        }
    }

    
    
    
    // 이메일 인증 처리 메서드
    @Transactional
    public boolean requestEmailAuth(EmailAuthVO email_auth) {
        boolean isAuthSuccess = false;

        // 1. 입력값 검증
        if (email_auth == null || email_auth.getMail_auth_code() == null) {
            return false; // 값이 없으면 실패 처리
        }

        // 2. DB에서 인증 정보 조회
        EmailAuthVO dbMailAuthInfo = mapper.selectMailAuthInfo(email_auth);

        // 3. 인증 코드 검증
        if (dbMailAuthInfo != null && dbMailAuthInfo.getMail_auth_code() != null) {
            if (email_auth.getMail_auth_code().equals(dbMailAuthInfo.getMail_auth_code())) {
                // 인증 성공 시 상태 업데이트 및 정보 삭제
                mapper.updateMailAuthStatus(email_auth);
                mapper.deleteMailAuthInfo(email_auth);
                isAuthSuccess = true;
            }
        }

        return isAuthSuccess;
    }
    
    
    
    // --------------------------------------------------------------------------------------------------------------------------- 비밀번호 찾기
    // --------------------------------------------------------------------------------------------------------------------------- 임시비번 생성
    
  // 비밀번호 찾기: 임시 비밀번호 생성 및 이메일 전송
    public boolean sendTemporaryPassword(MemberVO member,String email) {
        try {
        	
        	// 0. 회원 객체 검증
            if (member == null || email == null || email.isEmpty()) {
                throw new IllegalArgumentException("MailService  sendTemporaryPassword) 유효하지 않은 회원 정보 또는 이메일입니다.");
            }

            // 1. 임시 비밀번호 생성
            String tempPassword = GenerateRandomCode.getRandomCode(10); // 10자리 난수 생성
            System.out.println("생성된 임시 비밀번호: " + tempPassword);

            // 2. 임시 비밀번호 암호화
            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            String encodedPassword = passwordEncoder.encode(tempPassword);

            // 3. 회원 비밀번호 업데이트
            member.setMember_passwd(encodedPassword);
            int updatedRows = mapper.updateMemberPassword(member);
            
            if (updatedRows == 0) {
                System.err.println("비밀번호 업데이트 실패: 이메일 = " + email);
                return false;
            }
         

            // 4. 이메일 발송 내용 작성
            String subject = "[Project Movie] 임시 비밀번호 발급 안내";
            String content = "<p>안녕하세요, manager 장민기입니다.  " + member.getMember_name() + "님.</p>"
                + "<p>임시 비밀번호가 발급되었습니다. 아래 정보를 사용해 로그인하세요.</p>"
                + "<p><strong>임시 비밀번호:</strong> " + tempPassword + "</p>"
                + "<p>로그인 후 반드시 비밀번호를 변경하시기 바랍니다.</p>";

            // 5. 메일 발송
            new Thread(() -> {
            	
                try {
                    mailClient.sendMail(email, subject, content);
                    System.out.println("임시 비밀번호 전송 성공: " + email);
                    
                } catch (Exception e) {
                    e.printStackTrace();
                    System.err.println("임시 비밀번호 전송 실패: " + email + " - " + e.getMessage());
                }
                
            }).start();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("임시 비밀번호 처리 중 오류 발생!", e);
        }
    }


    
    
}
