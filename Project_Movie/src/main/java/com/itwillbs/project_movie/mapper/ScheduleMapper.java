package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_movie.vo.ScheduleVO;

@Mapper
public interface ScheduleMapper {
	
	// schedule 테이블에 스케줄 insert
	int insertSchedule(ScheduleVO scheduleVO);
	
	// WHERE절 컬럼명에 따라 영화조회 가능한 메서드
	List<ScheduleVO> selectSchedule(Map<String, String> conditionMap);

}
