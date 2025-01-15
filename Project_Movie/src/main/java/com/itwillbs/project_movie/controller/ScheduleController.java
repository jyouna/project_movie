package com.itwillbs.project_movie.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.service.ScheduleService;
import com.itwillbs.project_movie.vo.ScheduleVO;

@Controller
public class ScheduleController {

	@Autowired
	private ScheduleService scheduleService;

	// 관리자페이지 영화관리 상영스케줄관리 페이지 맵핑
	@GetMapping("AdminMovieSetSchedule")
	public String adminMovieSetSchedule() {
		
//	    // 오늘 날짜로 설정
//	    Calendar calendar = Calendar.getInstance();
//	    
//	    // 해당 달의 첫날 계산
//	    calendar.set(Calendar.DAY_OF_MONTH, 1);
//	    int firstDay = calendar.get(Calendar.DAY_OF_MONTH);
//	    int firstDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
//	    
//	    // 해당 달의 마지막 날 계산
//	    int lastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
//	    calendar.set(Calendar.DAY_OF_MONTH, lastDay);
//	    int lastDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
//	    
//	    // 요일 배열 (1: 일요일, 2: 월요일, ... , 7: 토요일)
//	    String[] days = {"", "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"};
//	    
//	    System.out.println("해당 달의 첫날: " + firstDay + "일 (" + days[firstDayOfWeek] + ")");
//	    System.out.println("해당 달의 마지막 날: " + lastDay + "일 (" + days[lastDayOfWeek] + ")");

		
		
		return "adminpage/movie_set/movie_schedule_info";
	}

	// 관리자페이지 영화관리 상영스케줄 상세페이지 맵핑
	@GetMapping("AdminMovieSetScheduleDetail")
	public String adminMovieSetScheduleDetail(String theater_code, String select_date, Model model) {
		// 상세스케줄 페이지에 표시할 스케줄 리스트 조회
		List<Map<String, Object>> scheduleList = scheduleService.getScheduleListJoinMovie(select_date, theater_code);
		model.addAttribute("scheduleList", scheduleList);
		return "adminpage/movie_set/movie_schedule_info_detail";
	}

	// 스케줄상세페이지에서 스케줄등록 비즈니스 로직
	@PostMapping("ScheduleRegistForm")
	public String scheduleRegistForm(ScheduleVO scheduleVO, String select_date, Model model) {
		System.out.println("select_date : " + select_date);
		// 영화코드를 유니크하게 조합하기위해 schedule 컬럼의 리터럴 조합
		// 날짜조합하기위해 "yyyy-MM-dd HH:mm"을 "yyyyMMddHHmm"으로 변환
		DateTimeFormatter beforeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		LocalDateTime beforeStartTime = LocalDateTime.parse(scheduleVO.getStr_start_time(), beforeFormatter);
		DateTimeFormatter afterFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmm");
		String afterStartTime = beforeStartTime.format(afterFormatter);

		// 상영관코드, 영화코드, 상영시작날짜시간을 조합하여 스케줄 코드 생성 및 vo에 초기화
		String makeSchedule_code = scheduleVO.getTheater_code() + scheduleVO.getMovie_code() + afterStartTime;
		scheduleVO.setSchedule_code(makeSchedule_code);
		
		int insertCount = scheduleService.registSchedule(scheduleVO);
		
		if(insertCount > 0) {
			model.addAttribute("theater_code", scheduleVO.getTheater_code());
			model.addAttribute("select_date", select_date);
			return "redirect:/AdminMovieSetScheduleDetail";
		} else {
			model.addAttribute("msg", "스케줄 등록 실패!");
			return "result/process";
		}
		
	}
	
	// 스케줄 등록폼의 시간 입력시 DB에 저장된 스케줄 정보와 비교하여 일정 겹침 여부 판단을 위해
	// DB에서 해당 날짜와 상영관에 등록된 스케줄 리스트 조회
	@ResponseBody
	@GetMapping("GetScheduleInfo")
	public List<ScheduleVO> getScheduleInfo(String select_date, String theater_code) {
		List<ScheduleVO> scheduleList = scheduleService.getScheduleListOnSelectDay(select_date, theater_code);
		for(ScheduleVO schedule : scheduleList) {
			System.out.println(schedule);
		}
		return scheduleList;
	}
	
	// 상영예정작 페이지에서 현재상영작으로 등록하기 위해 등록 스케줄 존재여부 판별
	@ResponseBody
	@GetMapping("IsExistSchedule") 
	public Boolean isExistSchedule(String movie_code) {
		Boolean isExit = false;
		
		// 해당영화의 스케줄 조회, 조회결과 존재할경우 true 리턴;
		List<ScheduleVO> ScheduleList = scheduleService.getScheduleRegisted(movie_code);
		if(ScheduleList.size() != 0) {
			isExit = true;
		}
		return isExit;
	}
}
