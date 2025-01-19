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
import com.itwillbs.project_movie.vo.PointVO;

import kotlinx.serialization.json.JsonObject;
import retrofit2.http.GET;

@Controller
public class AdminStaticsController {
	@Autowired
	private AdminManageService adminService;
	
	@GetMapping("StaticsVisitors") // 방문자 통계
	public String staticsVisitors(HttpSession session, Model model) {
		// 관리자 로그인 판별
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("member_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		
		return "adminpage/statics_manage/statics_visitors";
	}

	@GetMapping("StaticsSales") // 매출 통계 
	public String staticsSales(HttpSession session, Model model) {
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("member_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		return "adminpage/statics_manage/statics_sales";
	}
	
	@GetMapping("StaticsVoteResult") // 투표 결과(통계)
	public String staticsVoteResult(HttpSession session, Model model) {
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("member_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		return "\"adminpage/statics_manage/statics_voteResult";
	}
	
	@GetMapping("StaticsNewMember") // 신규 가입자 통계
	public String staticsNewMembers(HttpSession session, Model model) {
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("member_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		
		return "adminpage/statics_manage/statics_newMember";
	}
	
	@GetMapping("SpecificPeriodSearch") // 상세 기간 조회 버튼
	public String specificPeriodSearch() {
		return "adminpage/specific_period_search";
	}
	
	
	//월 가입자 통계 리턴
	@GetMapping("GetMonthlyMemberJoinStaticsInfo")
	@ResponseBody
	public int monthlyMemberJoinStaticsInfo(@RequestParam("year") int year, @RequestParam("month") int month) {
		// 연도 ex)2024를 입력받으면 해당연도의 1 ~ 12월 까지 월별 신규가입자 통계수치를 리턴
		// 2024. 1월 : xx명 - WHERE regis_date >= 2024.01.01 AND regis_date <=2024.01.31 
		// 2024. 2월 : xx명
		// 2024. 3월 : xx명
		
		System.out.println("가입자 통계 컨트롤러 호출");
		System.out.println(year);
		System.out.println(month);
		
		int totalNewMember = adminService.monthlyTotalNewMemberStatics(year, month);
		
		System.out.printf("%d년 %d월 가입자 수 : %d\n", year, month, totalNewMember);
		
		return totalNewMember;
	}
	
	
	// 월별 가입자 통계 출력!
	@GetMapping("GetYearTotalMemberJoinStaticsInfo")
	@ResponseBody
	public Map<String, Object> yearTotalNewMemeber(int year) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("연간 가입자 통계 컨트롤러 호출됨 : " + year);
		
		map = adminService.getMonthlyNewMember(year);
		
		System.out.println("컨트롤러 map에 저장된 값 : " + map);
		
//		JSONObject jo = new JSONObject(map);
//		System.out.println("jsonobject에 저장된 값 : " + jo);
		return map;
	}
	
	@GetMapping("AdminMainGetYearTotalMemberJoinStaticsInfo")
	@ResponseBody
	public Map<String, Object> adminMainForYearTotalNewMemeber(int year) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("관리자 메인페이지 가입자 통계 컨트롤러 호출됨 : " + year);
		
		map = adminService.getMonthlyNewMember(year);
		
		System.out.println("컨트롤러 map에 저장된 값 : " + map);
		
		return map;
	}	
	
	
	
	@PostMapping("getTotalPeriodMemberJoinStatics")
	@ResponseBody
	public Map<String, String> totalPeriodMemberJoinStatics(@RequestBody Map<String, List<String>> period) {
		System.out.println("컨트롤러에서 전달받은 period : " + period);
		Map<String, String> map = new HashMap<String, String>();
		map = adminService.getTotalMemberJoinStatics(period);
		System.out.println("컨트롤러 map에 저장된 값 : " + map);
		
		return map;
	}
	
	
	// 회원 자동 생성 메크로
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
}



