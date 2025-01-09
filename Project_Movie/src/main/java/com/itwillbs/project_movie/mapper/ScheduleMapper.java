package com.itwillbs.project_movie.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_movie.vo.ScheduleVO;

@Mapper
public interface ScheduleMapper {
	
	// schedule 테이블에 스케줄 insert
	int insertSchedule(ScheduleVO scheduleVO);

}
