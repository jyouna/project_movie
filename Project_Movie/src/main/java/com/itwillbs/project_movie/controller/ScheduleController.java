package com.itwillbs.project_movie.controller;

import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.project_movie.service.ScheduleService;
import com.itwillbs.project_movie.vo.ScheduleVO;

@Controller
public class ScheduleController {

	@Autowired
	private ScheduleService scheduleService;

	// 관리자페이지 영화관리 상영스케줄관리 페이지 맵핑
	@GetMapping("AdminMovieSetSchedule")
	public String adminMovieSetSchedule() {
		return "adminpage/movie_set/movie_schedule_info";
	}

	// 관리자페이지 영화관리 상영스케줄 상세페이지 맵핑
	@GetMapping("AdminMovieSetScheduleDetail")
	public String adminMovieSetScheduleDetail(String theater_code, Date select_date, Model model) {
		model.addAttribute("select_date", select_date);
		model.addAttribute("theater_code", theater_code);
		return "adminpage/movie_set/movie_schedule_info_detail";
	}

	// 스케줄상세페이지에서 스케줄등록 비즈니스 로직
	@PostMapping("ScheduleRegistForm")
	public String scheduleRegistForm(ScheduleVO scheduleVO, String select_date) {

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

		return "redirect:/AdminMovieSetScheduleDetail?theater_code=" + scheduleVO.getTheater_code() + "&select_date="
				+ select_date;
	}

}
