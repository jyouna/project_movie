package com.itwillbs.project_movie.service;

import org.springframework.beans.factory.annotation.Autowired;
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
}
