package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface MoviePickMapper {
	
	// 투표 정보 등록
	int insertVoteInfo(Map<String, String> map);
	
	// 투표 정보 삭제
	int deleteVoteInfo(String vote_code);
	
	// 모든 투표 정보 조회
	List<Map<String, Object>> SelectAllVoteInfo();
	
	// 투표 정보 조회
	Map<String, Object> selectVoteInfo(String vote_code);
	
	// 투표완료된 가장 최신 투표 정보 조회
	Map<String, Object> selectRecentVoteInfo();
	
	// 투표 상태 업데이트
	int updateVoteStatus(@Param("vote_code") String vote_code, @Param("vote_status") int vote_status);
	
	// 투표 현황 조회
	List<Map<String, Object>> selectVoteCurrent(String vote_code);
	
	// 회원의 투표내역 등록
	int insertMemberVoteInfo(Map<String, String> map);

	// 회원의 이번 투표수 조회
	int selectMemberVoteCount(Map<String, String> map);
	
	// 선정된 영화 코드를 영화정보 테이블에 업데이트
	void updateVoteInfoAddWinner(@Param("vote_code") String vote_code, @Param("winner_movie_code") String winner_movie_code);

	
	
	


}
