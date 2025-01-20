package com.itwillbs.project_movie.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
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
	public String adminMovieSetSchedule(@RequestParam(defaultValue = "T1") String theater_code, @RequestParam(required = false) String selectedMonth, Model model) {
		LocalDate date;
		
		// 처음 뷰페이지 포워딩시 오늘날짜기준 달력 생성
		// 상영스케줄 관리 페이지에서 날짜 선택시 해당 날짜 달력 생성
		if(selectedMonth == null) {
			date = LocalDate.now();
		} else {
			date = LocalDate.parse(selectedMonth + "-01");
		}
		
		// 뷰페이지에서 달력그리기 위해 해당 달의 1일이 첫째주의 몇번째 날인지 판별후 앞에 빈날짜에 "" 입력
		// 예시) 일요일부터 시작하는 달력이므로 1일이 수요일이면 "" 3개를 달력 List에 추가
		// 해당 달의 첫날 요일 계산
		LocalDate firstDayOfMonth = date.withDayOfMonth(1);
		int nullStringCount = firstDayOfMonth.getDayOfWeek().getValue();
		List<String> calendar = new ArrayList<String>();
		
		// 뷰페이지에서 달력을 그릴때 해당 달의 첫 날이 일요일이면 한 주가 ""으로 표시되는걸 방지
		if(nullStringCount != 7) {
			for(int i = 1; i <= nullStringCount; i++) {
				calendar.add("");
			}
		}
		
		// 해당 달의 마지막 날짜
		int lastDay = date.lengthOfMonth();
		
		// 달력 List에 해당달의 첫날부터 끝날까지 추가
		for(int day = 1; day <= lastDay; day++) {
			calendar.add(Integer.toString(day));
		}
		
		model.addAttribute("calendar", calendar);
		
		return "adminpage/movie_set/movie_schedule_info";
	}
	
	// 관리자페이지 영화관리 상영스케줄 관리 페이지 달력에 추가할 각 날의 스케줄 수 조회
	@ResponseBody
	@GetMapping("GetScheduleCountOfDay")
	public List<Map<String, Object>> getScheduleCountOfDay(String theater_code, String selectedMonth) {
		List<Map<String, Object>> scheduleCountList = scheduleService.getScheduleCountListOfday(theater_code, selectedMonth);
		return scheduleCountList;
	}

	// 관리자페이지 영화관리 상영스케줄 상세페이지 맵핑
	@GetMapping("AdminMovieSetScheduleDetail")
	public String adminMovieSetScheduleDetail(String theater_code, String select_date, Model model) {
		// 상세스케줄 페이지에 표시할 스케줄 리스트 조회
		List<Map<String, Object>> scheduleList = scheduleService.getScheduleListJoinMovie(select_date, theater_code);
		
		// 상영스케줄 상세페이지에 예매종료 표시를 하기위해 start_time 현재 날짜 시간과 비교
		for(Map<String, Object> schedule : scheduleList) {
			// 현재 날짜 시간
			LocalDateTime now = LocalDateTime.now();
			// 스케줄 시작,끝 날짜 시간
			String startTime = schedule.get("start_time").toString();
			String endTime = schedule.get("end_time").toString();
			
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
			LocalDateTime formatStartTime = LocalDateTime.parse(startTime, formatter);
			LocalDateTime formatendTime = LocalDateTime.parse(endTime, formatter);
			
			// 스케줄이 종료되었는지 판단하여 뷰페이지에 표시
			if(formatendTime.isBefore(now)) {
				// 종료된 스케줄
				schedule.put("isPassed", true);
			} else if(formatStartTime.isBefore(now) && formatendTime.isAfter(now)) {
				// 상영중인 스케줄
				schedule.put("isPassed", false);
			}
		}
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
			return "redirect:/AdminMovieSetScheduleDetail?theater_code=" + scheduleVO.getTheater_code() + "&select_date=" + select_date;
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
	
	// 스케줄 상세페이지에서 스케줄의 예매상태 활성화로 변경
	@GetMapping("ScheduleBookingStatusOn")
	public String scheduleBookingStatusOn(String select_date, String theater_code, String scheduleCodeStr, Model model) {
		// 전달받은 스케줄을 IN절에 사용하기위해 schedule_code 배열로 변경
		String[] scheduleCodeArr = scheduleCodeStr.trim().split(" ");
		int updateCount = scheduleService.changeBookingStatusToOn(scheduleCodeArr);
		if(updateCount > 0) {
			return "redirect:/AdminMovieSetScheduleDetail?theater_code=" + theater_code + "&select_date=" + select_date;
		} else {
			model.addAttribute("msg", "예매 활성화 실패");
			return "result/process";
		}
	}

	// 스케줄 상세페이지에서 스케줄의 예매상태 비활성화로 변경
	@GetMapping("ScheduleBookingStatusOff")
	public String scheduleBookingStatusOff(String select_date, String theater_code, String scheduleCodeStr, Model model) {
		// 전달받은 스케줄을 IN절에 사용하기위해 schedule_code 배열로 변경
		String[] scheduleCodeArr = scheduleCodeStr.trim().split(" ");
		int updateCount = scheduleService.changeBookingStatusToOff(scheduleCodeArr);
		if(updateCount > 0) {
			return "redirect:/AdminMovieSetScheduleDetail?theater_code=" + theater_code + "&select_date=" + select_date;
		} else {
			model.addAttribute("msg", "예매 비활성화 실패");
			return "result/process";
		}
	}
	
	// 스케줄 상세페이지에서 스케줄 삭제
	@GetMapping("DeleteScheduleInfo")
	public String deleteScheduleInfo(String select_date, String theater_code, String scheduleCodeStr, Model model) {
		// 전달받은 스케줄을 IN절에 사용하기위해 schedule_code 배열로 변경
		String[] scheduleCodeArr = scheduleCodeStr.trim().split(" ");
		
		int deleteCount = 0;
		
		try {
			deleteCount = scheduleService.deleteScheduleFromDB(scheduleCodeArr);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "예매중인 스케줄과 지난 스케줄은 삭제 할 수 없습니다.");
			return "result/process";
		}
		
		if(deleteCount > 0) {
			return "redirect:/AdminMovieSetScheduleDetail?theater_code=" + theater_code + "&select_date=" + select_date;
		} else {
			model.addAttribute("msg", "스케줄 삭제 실패");
			return "result/process";
		}
	}
}
