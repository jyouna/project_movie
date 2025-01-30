package com.itwillbs.project_movie.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
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
// 데이터 자동 생성을 위한 컨트롤러
// 결제일, 가입일 모두 다르게 설정하여 연->월->일 반복횟수를 난수로 생성하여 반복 작업 수행

@Controller
public class CreateDataController {
	@Autowired
	private AdminManageService adminService;
	
	// 회원 자동 생성 매크로
	@GetMapping("createNewmember")
	public void createNewMember() {
		Random r = new Random();
		LocalDate localDate = LocalDate.of(2002, 2, 2);
		Date date = Date.valueOf(localDate);
		
		int year = 2020;
		int month = 0;
		
		for(int i = 0; i < 4; i++) { // 4년
			for(int j = 1; j <= 12; j++) { // 12개월
				month = j; // 1~12월 
				int repetitionCount = (int) ((Math.random()*400)+100);
				for(int k = 0; k < repetitionCount; k++) { // repititionCount = 월 생성 계정 수
					MemberVO member = new MemberVO();
					LocalDate lastDay = YearMonth.of(year, month).atEndOfMonth();
					int dayOfMonth = lastDay.getDayOfMonth(); 
					LocalDateTime time = LocalDateTime.of(year, month, r.nextInt(dayOfMonth)+1, 11, 11, 11, 11);
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
					// 회원 생성
					adminService.createMembers(member);
				}
			}
			year ++; // 반복 끝날 때마다 1년씩 증가
		}
	}
	
	// 매출 자동 생성 매크로 -> admin account manage 페이지에 생성 버튼 있음 
	@GetMapping("CreateSalesRecord")
	public String createSalesRecord() {
		System.out.println("매출생성 버튼 컨트롤러 호출됨");
		Random r = new Random();
		int year = 2020;
		int month = 0;
		// 매출 데이터 생성에 필요한 멤버 아이디 조회 
		List<String> memberList = adminService.getMemberIdList();
		for(int i = 0; i < 4; i++) { // 4년
			for(int j = 1; j <= 12; j++) { // 12개월
				month = j; // 1~12월 
				// 100~399 사이 난수 생성 : 월 생성할 데이터 개수
				int repetitionCount = (int) ((Math.random()*300)+100); 
				for(int k = 0; k < repetitionCount; k++) { // repititionCount = 월 매출 발생 수
					PaymentVO payment = new PaymentVO();
					// 해당 월의 마지막 날 출력
					LocalDate lastDay = YearMonth.of(year, month).atEndOfMonth();
					int dayOfMonth = lastDay.getDayOfMonth(); 
					// 전체 회원 목록 중 랜덤으로 아이디 1개 선택
					String id = memberList.get(r.nextInt(memberList.size()));
					// 날짜 설정
					LocalDateTime time = LocalDateTime.of(year, month, r.nextInt(dayOfMonth)+1, 11, 11, 11, 11);
					Timestamp regis_date = Timestamp.valueOf(time);
					int count = (r.nextInt(9) + 1);
					int amount = (10000 * count);
					
					payment.setPayment_code(r.nextInt(99) + r.nextInt(99) + r.nextInt(99) + "tes" + r.nextInt(99) + r.nextInt(99) + r.nextInt(99) + "a" + r.nextInt(99) + r.nextInt(99));
					payment.setPayment_date(regis_date);
					payment.setMember_id(id);
					// 스케줄 코드는 결제일 <= 상영시간 등의 복잡성 때문에 고정
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
					
					// 매출 데이터 생성
					adminService.createSalesRecord(payment);
				}
			}
			year ++; // 반복 끝날 때마다 1년씩 증가
		}
		
		return "redirect:/AdminAccountManage";
	}
}