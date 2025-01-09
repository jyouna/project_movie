package com.itwillbs.project_movie.service;

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


}
