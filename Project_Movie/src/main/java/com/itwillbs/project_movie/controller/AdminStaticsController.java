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


// 관리자 페이지 기간별 통계 메뉴에 사용되는 컨트롤러
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
		return "adminpage/statics_manage/statics_voteResult";
	}
	
	// 신규 가입자 통계 메인페이지 이동
	@GetMapping("StaticsNewMember") 
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
	
	
	// 통계 2, 3번 차트 월 가입자 수 조회
	@GetMapping("GetMonthlyMemberJoinStaticsInfo")
	@ResponseBody
	public int monthlyMemberJoinStaticsInfo(@RequestParam("year") int year, @RequestParam("month") int month) {
		// 연도 ex)2024를 입력받으면 해당연도의 1 ~ 12월 까지 월별 신규가입자 통계수치를 리턴
		// 2024. 1월 : xx명 - WHERE regis_date >= 2024.01.01 AND regis_date <=2024.01.31 
		// 2024. 2월 : xx명
		// 2024. 3월 : xx명
		
		int totalNewMember = adminService.monthlyTotalNewMemberStatics(year, month);
		
		return totalNewMember;
	}
	
	
	// 통계 연 단위 가입자 수 조회
	@GetMapping("GetYearTotalMemberJoinStaticsInfo")
	@ResponseBody
	public Map<String, Object> yearTotalNewMemeber(int year) {
		System.out.println("연간 가입자 통계 컨트롤러 호출됨 : " + year);
		Map<String, Object> map = adminService.getMonthlyNewMember(year);
		System.out.println("컨트롤러 map에 저장된 값 : " + map);
		
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
	
	
	// 전체 기간(2020~2025) 연간 가입자 조회
	@PostMapping("getTotalPeriodMemberJoinStatics")
	@ResponseBody
	public Map<String, String> totalPeriodMemberJoinStatics(@RequestBody Map<String, List<String>> period) {
		System.out.println("컨트롤러에서 전달받은 period : " + period);
		Map<String, String> map = adminService.getTotalMemberJoinStatics(period);
		System.out.println("컨트롤러 map에 저장된 값 : " + map);
		
		return map;
	}
	
	// 전년도(2024년) 월별 매출액 조회 
	@GetMapping("GetYearSales")
	@ResponseBody
	public Map<String, Object> getYearSales(int year) {
		Map<String, Object> map = adminService.getYearSales(year);
		
		return map;
	}
	
	// 2, 3번 차트 연 - 월 선택 시 해당 월 매출액 조회
	@GetMapping("GetMonthSales")
	@ResponseBody
	public int getMonthSales(int year, int month) {
		int monthSales = adminService.getMonthSales(year, month);
		return monthSales;
	}
	
	// 4번 차트 전체 기간(2020~2025) 연간 매출액 조회
	// 파라미터는 ["period" : {2020, 2021, 2022, 2023, 2024, 2025}] 형태로 전달 받기에 Map<List<>> 사용
	@PostMapping("GetAnnualSales")
	@ResponseBody
	public Map<Integer, Integer> annualSales(@RequestBody Map<String, List<Integer>> period) {
		Map<Integer, Integer> map = adminService.getAnnualSales(period);
		// [{2020 : 14,123,412}, {2021: 14,235,534}] 형태의 데이터로 ajax 응답
		return map;
	}	
	
}



