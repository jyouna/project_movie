package com.itwillbs.project_movie.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.MoviePickMapper;
import com.itwillbs.project_movie.vo.MemberVO;

@Service
public class MoviePickService {
	
	@Autowired
	MoviePickMapper moviePickMapper;
	
	// 투표정보 등록 메서드
	public int registMoviePickInfo(Map<String, String> map) {
		return moviePickMapper.insertVoteInfo(map);
	}
	
	// 현재날짜에 해당하는 투표 정보 조회
	public Map<String, Object> getVoteInfo() {
		return moviePickMapper.selectVoteInfo();
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
	

		
}
