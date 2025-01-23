package com.itwillbs.project_movie.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_movie.mapper.MovieMapper;
import com.itwillbs.project_movie.mapper.MoviePickMapper;

@Service
public class MoviePickService {
	
	@Autowired
	MoviePickMapper moviePickMapper;
	
	@Autowired
	MovieMapper movieMapper;
	
	// 투표정보 등록 메서드
	public int registMoviePickInfo(Map<String, String> map) {
		return moviePickMapper.insertVoteInfo(map);
	}
	
	// 투표정보 삭제
	public int removeVoteInfo(String vote_code) {
		return moviePickMapper.deleteVoteInfo(vote_code);
	}
	
	// 모든 투표정보 조회
	public List<Map<String, Object>> getVoteInfoList() {
		return moviePickMapper.SelectAllVoteInfo();
	}
	
	// 투표코드에 해당하는 투표 정보 조회
	public Map<String, Object> getVoteInfo(String vote_code) {
		return moviePickMapper.selectVoteInfo(vote_code);
	}
	
	// 투표가 종료된 가장 최근의 투표 정보 조회
	public Map<String, Object> getRecentVoteInfo() {
		return moviePickMapper.selectRecentVoteInfo();
	}
	
	
	// 투표 활성화
	public int startMvoiePick(String vote_code) {
		int vote_status = 1;
		return moviePickMapper.updateVoteStatus(vote_code, vote_status);
	}
	
	// 투표 비활성화
	public int endMvoiePick(String vote_code) {
		int vote_status = 0;
		return moviePickMapper.updateVoteStatus(vote_code, vote_status);
	}
	
	// 투표 현황 조회
	public List<Map<String, Object>> getVoteCurrentInfo(String vote_code) {
		return moviePickMapper.selectVoteCurrent(vote_code);
	}
	
	// 회원의 투표내역 정보 등록
	public int registMemberVoteInfo(Map<String, String> map) {
		return moviePickMapper.insertMemberVoteInfo(map);
	}
	
	// 회원의 투표내역 조회(중복 투표 방지)
	public int getJoinCountThisVote(Map<String, String> map) {
		return moviePickMapper.selectMemberVoteCount(map);
	}
	
	// 투표 결과 적용
	// 1) 투표 결과 1, 2, 3등 영화 시즌 상영예정작으로 등록
	// 2) 4, 5등 영화 대기영화로 변경
	// 3) 투표 정보 테이블에 선정영화 컬럼 업데이트
	@Transactional
	public void adjustVoteResult(String vote_code) {
		// 영화결과정보 조회(득표수 기준 내림차순 정렬)
		List<Map<String, Object>> voteResultInfoList = moviePickMapper.selectVoteCurrent(vote_code);
		// 선정된 영화 코드 리스트
		List<String> winnerCodeList = new ArrayList<String>();
		// 비선정된 영화 코드 리스트
		List<String> loserCodeList = new ArrayList<String>();;
		
		for(Map<String, Object> voteResultEach : voteResultInfoList) {
			if(winnerCodeList.size() < 3) {
				winnerCodeList.add((String)voteResultEach.get("movie_code"));
			} else {
				loserCodeList.add((String)voteResultEach.get("movie_code"));
			}
		}
		
		// 1)
		movieMapper.updateMovieStatusToSeasonUpcoming("상영예정작", "시즌", winnerCodeList);
		
		// 2)
		movieMapper.updateMovieStatusToStandBy("대기", loserCodeList.toArray(new String[loserCodeList.size()]));
		
		// 3)
		String winnerMovieCodeStr = String.join(",", winnerCodeList);
		moviePickMapper.updateVoteInfoAddWinner(vote_code, winnerMovieCodeStr);
	}
	
	
	
	

		
}
