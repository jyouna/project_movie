//장민기

package com.itwillbs.project_movie.service;
import net.nurigo.sdk.message.model.Message;

import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
// 추가 . 기존 객체 타입 불일치해서 수정

import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import net.nurigo.sdk.NurigoApp;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class SmsService {

    private final DefaultMessageService messageService;

    // 환경 변수 주입
    @Value("${coolsms.api.key}")
    private String apiKey;

    @Value("${coolsms.api.secret}")
    private String apiSecret;

    @Value("${coolsms.from}")
    private String fromNumber;

    // 생성자에서 SDK 초기화
    public SmsService(
            @Value("${coolsms.api.key}") String apiKey,
            @Value("${coolsms.api.secret}") String apiSecret,
            @Value("${coolsms.from}") String fromNumber) {

        // null 체크 추가
        if (apiKey == null || apiSecret == null || fromNumber == null || apiKey.isEmpty() || apiSecret.isEmpty() || fromNumber.isEmpty()) {
            throw new IllegalArgumentException("API 키 또는 시크릿 키가 설정되지 않았습니다.");
        }

        this.apiKey = apiKey;
        this.apiSecret = apiSecret;
        this.fromNumber = fromNumber;

        // SDK 초기화
        this.messageService = NurigoApp.INSTANCE.initialize(this.apiKey, this.apiSecret, "https://api.coolsms.co.kr");
    }


    public boolean sendSms(String to, String text) {
        try {
            Message message = new Message();
            message.setFrom(fromNumber);
            message.setTo(to);
            message.setText(text);

            // 전송 요청
            messageService.sendOne(new SingleMessageSendingRequest(message));

            return true; // 성공
        } catch (Exception e) {
            e.printStackTrace();
            return false; // 실패
        }
    }
}
