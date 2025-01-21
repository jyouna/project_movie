package com.itwillbs.project_movie.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.handler.AdminMenuAccessHandler;
import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.GetGiveCouponInfoVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.PageInfo;
import com.itwillbs.project_movie.vo.PaymentVO;
import com.itwillbs.project_movie.vo.PointVO;

import kotlinx.serialization.json.JsonObject;
import retrofit2.http.GET;

@Controller
public class CreateDataController {
	@Autowired
	private AdminManageService adminService;
	
	// 회원 자동 생성 매크로
	@GetMapping("createNewmember")
	public void createNewMember() {
		Random r = new Random();
		r.nextInt(5000);
		
		MemberVO member = new MemberVO();
		LocalDate localDate = LocalDate.of(2002, 2, 2);
		Date date = Date.valueOf(localDate);
		
		int year = 2020;
		int month = 0;
		int day = 10;
		
		for(int i = 1; i < 4; i++) { // 4년
			for(int j = 1; j <= 12; j++) { // 12개월
				month = j; // 1~12월 
				int repetitionCount = (int) ((Math.random()*200)+100);
				for(int k = 0; k < repetitionCount; k++) { // k 반복횟수만큼 계정 생성
					LocalDateTime time = LocalDateTime.of(year, month, day, 11, 11, 11, 11);
					Timestamp regis_date = Timestamp.valueOf(time);
					member.setMember_id(r.nextInt(999) + "tes" + r.nextInt(999) + r.nextInt(999) + r.nextInt(999));
					member.setMember_passwd("abcdedfg");
					member.setMember_name("tester" + r.nextInt(55));
					member.setBirth_date(date);
					member.setEmail(r.nextInt(999) + "abc@awe"+r.nextInt(999)+r.nextInt(9999)+".com");
					member.setPhone(r.nextInt(10000) + "010-" + r.nextInt(10000) + "-" + r.nextInt(10000));
					member.setGender('M');
					member.setGenre("액션");
					member.setText_receive(true);
					member.setEmail_receive(true);
					member.setInfo_open(true);
					member.setRegis_date(regis_date);
					
					adminService.createMembers(member);
				}
			}
			year += i; // 반복 끝날 때마다 1년씩 증가
		}
	}
	
	// 매출 자동 생성 매크로 -> admin account manage 페이지에 생성 버튼 있음 
	@GetMapping("CreateSalesRecord")
	public String createSalesRecord() {
		System.out.println("매출조작 버튼 컨트롤러 호출됨");
		Random r = new Random();
		MemberVO member = new MemberVO();
		LocalDate localDate = LocalDate.of(2002, 2, 2);
		Date date = Date.valueOf(localDate);
		int year = 2020;
		int month = 0;
//		int day = 10;
		PaymentVO payment = new PaymentVO();
		
		for(int i = 1; i < 4; i++) { // 4년
			for(int j = 1; j <= 12; j++) { // 12개월
				month = j; // 1~12월 
				int repetitionCount = (int) ((Math.random()*200)+100);
				for(int k = 0; k < repetitionCount; k++) { // k 반복횟수만큼 계정 생성
					LocalDateTime time = LocalDateTime.of(year, month, r.nextInt(28)+1, 11, 11, 11, 11);
					Timestamp regis_date = Timestamp.valueOf(time);
					System.out.println(regis_date);
					int count = r.nextInt(9)+1;
					int amount = 10000*count;
					
					payment.setPayment_code(r.nextInt(999) + r.nextInt(999) + "tes" + r.nextInt(999) + "a" + r.nextInt(999) + r.nextInt(999));
					payment.setPayment_date(regis_date);
					payment.setMember_id("hoon123");
					payment.setSchedule_code("T120136803202501130910");
					payment.setTicket_count(count);
					payment.setTotal_amount(amount);
					payment.setPoint_discount(0);
					payment.setCoupon_discount(0);
					payment.setTotal_discount(0);
					payment.setTotal_payment(amount);
					payment.setSeat_selection_time(regis_date);
					payment.setPayment_method("신용카드");
					payment.setPayment_status(r.nextInt(2));
					payment.setTotal_seat_code("A1, A2");
					
					adminService.createSalesRecord(payment);
				}
			}
			year += i; // 반복 끝날 때마다 1년씩 증가
		}
		
		return "redirect:/AdminAccountManage";
	}
}