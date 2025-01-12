package com.itwillbs.project_movie.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.ScheduleMapper;
import com.itwillbs.project_movie.vo.ScheduleVO;

@Service
public class ScheduleService {
	
	@Autowired
	private ScheduleMapper scheduleMapper;
	
	// scheduleMapper의 스케줄 등록 메서드 호출
	public int registSchedule(ScheduleVO scheduleVO) {
		return scheduleMapper.insertSchedule(scheduleVO);
	}
	
	// 스케줄 등록시 스케줄 일정 겹침 여부 판단을 위해 해당 날짜의 스케줄 리스트 조회
	public List<ScheduleVO> getScheduleListOnSelectDay(String select_date, String theater_code) {
		// 조회조건 전달을 위한 map 객체
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("howSearch", "start_time");
		conditionMap.put("searchKeyword", select_date);
		conditionMap.put("columnName2", "theater_code");
		conditionMap.put("selectCondition2", theater_code);
		return scheduleMapper.selectSchedule(conditionMap);
	}
	
	// 상영예정작 영화를 현재상영작으로 등록시 해당영화의 스케줄 등록여부조회
	// select문의 where절 조건 전달
	public List<ScheduleVO> getScheduleRegisted(String movie_code) {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("columnName", "movie_code");
		conditionMap.put("selectCondition", movie_code);
		return scheduleMapper.selectSchedule(conditionMap);
	}


}
