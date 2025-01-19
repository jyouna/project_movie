package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.ScheduleVO;

@Mapper
public interface ScheduleMapper {
	
	// schedule 테이블에 스케줄 insert
	int insertSchedule(ScheduleVO scheduleVO);
	
	// WHERE절 컬럼명에 따라 스케줄조회 가능한 메서드
	List<ScheduleVO> selectSchedule(Map<String, String> conditionMap);
	
	// schedule와 movie테이블 조인 메서드
	List<Map<String, Object>> selectScheduleJoinMovie(@Param("select_date") String select_date, @Param("theater_code") String theater_code);
	
	// schedule의 booking_avail 업데이트
	int updateScheduleBookingAvail(@Param("scheduleCodeArr") String[] scheduleCodeArr, @Param("booking_avail") int booking_avail);
	
	// schedule 삭제
	int deleteSchedule(@Param("scheduleCodeArr") String[] scheduleCodeArr);
	
	// 각 날의 schedule 수 조회
	List<Map<String, Object>> selectScheduleCountOfDay(@Param("theater_code") String theater_code, @Param("selectedMonth") String selectedMonth);
	
}
