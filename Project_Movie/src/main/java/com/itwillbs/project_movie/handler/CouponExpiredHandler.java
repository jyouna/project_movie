package com.itwillbs.project_movie.handler;

import java.time.LocalDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;
import com.itwillbs.project_movie.service.AdminManageService;

// 자동으로 기한 만료된 쿠폰을 처리하기 위한 컨트롤러
@Component
@EnableScheduling
public class CouponExpiredHandler {
	@Autowired
	AdminManageService adminService;
	
	@org.springframework.scheduling.annotation.Scheduled(cron = "59 59 23 * * ?")
	// 쿠폰 만료일 23시 59분 59초에 해당 쿠폰 '사용불가' 상태로 변겅
	public void couponExpired() {
		System.out.println("쿠폰 기한 만료 처리 스케줄러 작동!");
		LocalDate date = LocalDate.now();
		
		adminService.handlingExpiredCoupon(date);
	}
}
