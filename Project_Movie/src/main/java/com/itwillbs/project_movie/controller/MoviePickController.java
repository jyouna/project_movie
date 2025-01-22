package com.itwillbs.project_movie.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.service.MoviePickService;
import com.itwillbs.project_movie.service.MovieService;

@Controller
public class MoviePickController {
	
	@Autowired
	MovieService movieService;
	
	@Autowired
	MoviePickService moviePickService;
	
	// 영화투표하기 페이지 맵핑
	@GetMapping("MoivePick")
	public String moivePick(Model model) {
		// 현재 진행중인 투표 정보 조회
		Map<String, Object> voteInfo = moviePickService.getVoteInfo();
		model.addAttribute("voteInfo", voteInfo);
		
		// 영화 가격조회
		int generalPrice = movieService.getTicketPrice();
		model.addAttribute("generalPrice", generalPrice);
		
		// 투표영화 리스트, 투표현황(결과) 조회 메서드
		getVoteInfoAndMovieList(voteInfo, model);
		return "movie_pick/movie_pick";
	}
	
	// 투표현황 조회
	@ResponseBody
	@GetMapping("GetVoteStatusInfo")
	public List<Map<String, Object>> getVoteStatusInfo(String vote_code) {
		
		// 투표코드에 따른 투표현황 조회
		List<Map<String, Object>> voteCurrentInfoList = moviePickService.getVoteCurrentInfo(vote_code);
		
		return voteCurrentInfoList;
	}
	
	// 클라이언트 투표내역 DB등록
	@GetMapping("JoinMovieVote") 
	public String joinMovieVote(@RequestParam Map<String, String> map, Model model) {
		// 해당 시즌 투표 등록 여부 판별(한 시즌에 투표 한번 가능)
		int searchCount = moviePickService.getJoinCountThisVote(map);
		if(searchCount != 0) {
			model.addAttribute("msg", "이미 투표한 회원입니다\\n다음 시즌에 투표바랍니다.");
			return "result/process";
		}
		
		// 투표등록
		int insertCount = moviePickService.registMemberVoteInfo(map);
		
		if(insertCount > 0) {
			return "redirect:/JoinMovieVoteSuccess";
		} else {
			model.addAttribute("msg", "투표 실패하였습니다. 다시 시도하여 주십시오");
			return "result/process";
		}
	}
	
	// 투표등록완료 리다이렉트 후 투표완료 알람창 출력
	@GetMapping("JoinMovieVoteSuccess")
	public String joinMovieVoteSuccess(Model model) {
		model.addAttribute("msg", "투표등록 완료 되었습니다.");
		model.addAttribute("targetURL", "MoivePick");
		return "result/process";
	}
	
	// PICK결과보기 페이지 맵핑
	// 현재 투표 진행중이면 전시즌 투표 결과 출력, 투표미진행중이면 가장 최근 투표 결과 출력
	@GetMapping("MoivePickResult")
	public String moivePickResult(Model model) {
		Map<String, Object> voteInfo = moviePickService.getRecentVoteInfo();
		model.addAttribute("voteInfo", voteInfo);
		
		getVoteInfoAndMovieList(voteInfo, model);
		return "movie_pick/movie_pick_result";
	}
	
	//관리자페이지 투표관리 투표설정 페이지 맵핑
	@GetMapping("AdminMoviePickSet")
	public String adminMoviePickSet(Model model) {
		// 현재 진행중인 투표 정보 조회
		Map<String, Object> voteInfo = moviePickService.getVoteInfo();
		model.addAttribute("voteInfo", voteInfo);
		
		// 투표영화 리스트, 투표현황(결과) 조회 메서드
		getVoteInfoAndMovieList(voteInfo, model);
		return "adminpage/movie_pick_set/movie_pick_set";
	}
	
	// 투표설정 페이지의 투표등록 form
	@PostMapping("RegistPickInfo")
	public String registPickInfo(@RequestParam Map<String, String> map, Model model) {
		// 투표시작날짜와 끝날짜를 더해 투표코드 생성
		String vote_code = (map.get("start_date") + map.get("end_date")).replace("-", "");
		map.put("vote_code", vote_code);
		
		int insertCount = moviePickService.registMoviePickInfo(map);
		
		if(insertCount > 0) {
			return "redirect:/RegistPickInfoSuccess";
		} else {
			model.addAttribute("msg", "투표등록 실패하였습니다.");
			return "result/process";
		}
	}
	
	// 투표등록 완료후 리다이렉트
	@GetMapping("RegistPickInfoSuccess")
	public String registPickInfoSuccess(Model model) {
		model.addAttribute("msg", "투표등록 완료하였습니다.");
		model.addAttribute("targetURL", "AdminMoviePickSet");
		return "result/process";
	}
	
	// 투표설정 페이지의 투표시작
	@GetMapping("StartVoteForThisSeason")
	public String startVoteForThisSeason(String vote_code ,Model model) {
		int updateCount = moviePickService.startMvoiePick(vote_code);
		
		if(updateCount > 0) {
			return "redirect:/UpdateVoteStatusSuccess";
		} else {
			model.addAttribute("msg", "투표활성화에 실패하였습니다.");
			return "result/process";
		}
	}
	
	// 투표설정 페이지의 투표종료
	@GetMapping("EndVoteForThisSeason")
	public String endVoteForThisSeason(String vote_code ,Model model) {
		int updateCount = moviePickService.endMvoiePick(vote_code);
		
		if(updateCount > 0) {
			return "redirect:/UpdateVoteStatusSuccess";
		} else {
			model.addAttribute("msg", "투표비활성화에 실패하였습니다.");
			return "result/process";
		}
	}
	
	// 투표상태 업데이트 성공
	@GetMapping("UpdateVoteStatusSuccess")
	public String UpdateVoteStatusSuccess(Model model) {
		model.addAttribute("msg", "투표상태 변경 완료하였습니다.");
		model.addAttribute("targetURL", "AdminMoviePickSet");
		return "result/process";
	}
	
	// 투표영화 리스트, 투표현황(결과) 조회 메서드
	private void getVoteInfoAndMovieList(Map<String, Object> voteInfo, Model model) {
		
		String vote_code = (String)voteInfo.get("vote_code");
		
		// 해당투표의 현황(결과), 영화정보 조회
		List<Map<String, Object>> voteCurrentInfoList = moviePickService.getVoteCurrentInfo(vote_code);
		
		// 전체 투표수
		int totalCount = 0;
		
		for(Map<String, Object> voteCurrentInfo : voteCurrentInfoList) {
			totalCount += Integer.parseInt(voteCurrentInfo.get("count").toString());
		}
		
		model.addAttribute("voteCurrentInfoList", voteCurrentInfoList);
		model.addAttribute("totalCount", totalCount);
	}
	
}
