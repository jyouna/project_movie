package com.itwillbs.project_movie.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.service.MovieService;
import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.PageInfo;
import com.itwillbs.project_movie.vo.ScheduleVO;

@Controller
public class MovieController {
	
	@Autowired
	private MovieService movieService;
	
	// 영화안내 시즌무비 페이지 맵핑
	@GetMapping("SeasonMovieInfo")
	public String seasonMovieInfo() {
		return "movie_info/season_movie_info";
	}
	
	// 영화안내 현재상영작 페이지 맵핑
	@GetMapping("CurrentlyMovieInfo")
	public String currentlyMovieInfo() {
		return "movie_info/currently_movie_info";
	}
	
	// 영화안내 상영예정작 페이지 맵핑
	@GetMapping("UpcomingMovieInfo")
	public String upcomingMovieInfo() {
		return "movie_info/upcoming_movie_info2";
	}
	
	// 영화안내 지난상영작 페이지 맵핑
	@GetMapping("PastMovieInfo")
	public String pastMovieInfo() {
		return "movie_info/past_movie_info";
	}
	
	// 영화상세안내 페이지 맵핑
	@GetMapping("MovieInfoDetail")
	public String movieInfoDetail() {
		return "movie_info/movie_info_detail";
	}
	
	//관리자페이지 영화관리 영화목록 페이지 맵핑, 영화리스트 출력, 검색한 영화 리스트 출력
	@GetMapping("AdminMovieSetList")
	public String adminMovieSetList(@RequestParam(defaultValue = "1") int pageNum, Model model,
			@RequestParam(defaultValue="") String howSearch, @RequestParam(defaultValue="") String searchKeyword) {
		
		int listLimit = 10; // 한 페이지 당 표시할 게시물 수
		int startRow = (pageNum - 1) * listLimit; // 조회할 영화의 DB 행 번호(= row 값)
		int listCount = movieService.getMovieListCount(howSearch, searchKeyword); //총 영화 목록수 조회
		int pageListLimit = 5; // 한페이지당 페이지번호 수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); // 최대 페이지번호
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; //각 페이지의 첫번째 페이지 번호
		int endPage = startPage + pageListLimit - 1; // 각 페이지의 마지막 페이지번호
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// url 파라미터 조작 방지
		if(pageNum < 1 || (maxPage > 0 && pageNum > maxPage)) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
			model.addAttribute("targetURL", "AdminMovieSetList?pageNum=1");
			return "result/process";
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		model.addAttribute("pageInfo", pageInfo);
		
		// 조건에맞는 영화 리스트 조회
		List<MovieVO> movieList = movieService.getMovieList(startRow, listLimit, howSearch, searchKeyword);
		model.addAttribute("movieList", movieList);
		return "adminpage/movie_set/admin_movie_list";
	}
	
	// 관리자 영화관리에서 조건별 영화 검색
	// ajax 요청을 통해 json 형식으로 리턴
	@ResponseBody
	@GetMapping("AdminMovieSetSearch")
	public List<MovieVO> adminMovieSetSearch(@RequestParam Map<String, String> map) {
		List<MovieVO> SearchMovieList =  movieService.searchMovie(map);
		
		// db의 timestamp타입 데이터를 String타입으로 변환 후 응답
		for(MovieVO movieVO : SearchMovieList) {
			String[] formatDateString = movieVO.getRegist_date().toString().split(" ");
			movieVO.setStr_regist_date(formatDateString[0]);
		}
		return SearchMovieList;
	}

	
	// 관리자 영화목록에서 영화등록 로직
	@PostMapping("AdminMovieInfoRegist")
	public String movieInfoRegist(MovieVO movieVO, Model model, HttpSession session) {
		/* sId 판별식 추가 예정 */
//		String id = (String)session.getAttribute("sId");
		movieVO.setRegist_admin_id("admin");
		
		// 이미 등록된 영화인지 확인을 위해 영화정보 조회
		MovieVO dbMovieVO = movieService.searchMovieInfo(movieVO.getMovie_code());
		if(dbMovieVO == null) {
			int resultCount = 0;
			
			try {
				resultCount = movieService.registMovie(movieVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(resultCount > 0) {
				model.addAttribute("msg", "영화등록이 완료되었습니다");
				model.addAttribute("targetURL", "AdminMovieSetList");
				return "result/process";
			} else {
				model.addAttribute("msg", "영화등록 실패");
				return "result/process";
			}
			
		} else {
			model.addAttribute("msg", "이미 등록된 영화입니다");
			return "result/process";
		}
		
	}
	
	// 관리자 영화관리에서 영화상태 상영예정작으로 변경
	// 업데이트 후 alert창에 표시할 문구 리턴
	@ResponseBody
	@PostMapping("UpdateMovieStatusToUpcoming")
	public Map<String, String> updateMovieStatusToUpcoming(@RequestParam Map<String, String> map) {
		// 결과 전달을 위한 객체
		Map<String, String> sendMsgMap = new HashMap<String, String>();
		
		// 상영예정작은 9개이상 등록 불가(시즌 별 상영작 9개 제한)
		// 등록가능 여부 판별을 위해 상영예정작 수 조회
		int UpcomingTotalMovieCount = movieService.getCountTotalUpcomingMovie();
		
		if(UpcomingTotalMovieCount >= 9) {
			sendMsgMap.put("msg", "더이상 상영예정작을 등록할 수 없습니다(현재 상영예정작 : 9개)");
			return sendMsgMap;
		} else {
			// 일반영화인지 시즌영화인지 비교후 상영예정작 등록 간으여부 판별(일반-6, 시즌-3)
			if(map.get("movie_type").equals("일반")) {
				int generalUpcomingMovieCount = movieService.getCountGeneralUpcomingMovie();
				if(generalUpcomingMovieCount >=6) {
					sendMsgMap.put("msg", "등록초과! 등록가능 상영예정작 일반영화(6개)을 초과했습니다.");
					return sendMsgMap;
				}
			} else {
				int seasonUpcomingMovieCount = movieService.getCountSeasonUpcomingMovie();
				if(seasonUpcomingMovieCount >=3) {
					sendMsgMap.put("msg", "등록초과! 등록가능 상영예정작 시즌영화(3개)를 초과했습니다.");
					return sendMsgMap;
				}
			}
			
			int updateResult = movieService.setMovieStatus(map);
			// 업데이트 결과 판별 후 메세지 전달
			if(updateResult > 0) {
				sendMsgMap.put("msg", "상영예정작으로 등록완료");
			} else {
				sendMsgMap.put("msg", "상영예정작으로 등록실패");
			}
			return sendMsgMap;
		}
	}
	
	// 관리자 영화관리에서 영화상태 투표영화로 변경
	// 업데이트 후 alert창에 표시할 문구 리턴
	@ResponseBody
	@PostMapping("UpdateMovieStatusToPick")
	public Map<String, String> updateMovieStatusToPick(@RequestParam Map<String, String> map) {
		// 결과 전달을 위한 객체
		Map<String, String> sendMsgMap = new HashMap<String, String>();
		
		// 투표영화는 5개이상 등록 불가
		// 등록가능 여부 판별을 위해 투표영화 수 조회
		int pickMovieCount = movieService.getCountPickMovie();
		if(pickMovieCount >= 5) {
			sendMsgMap.put("msg", "더이상 투표영화를 등록할 수 없습니다(현재 투표영화 : 5개)");
			return sendMsgMap;
		} else {
			int updateResult = movieService.setMovieStatus(map);
			// 업데이트 결과 판별 후 메세지 전달
			if(updateResult>0) {
				sendMsgMap.put("msg", "투표영화로 등록완료");
			} else {
				sendMsgMap.put("msg", "투표영화로 등록실패");
			}
			return sendMsgMap;
		}
	}
	
	// 관리자 영화관리에서 영화삭제
	@ResponseBody
	@PostMapping("DeleteMovieFromDB")
	public Map<String, String> deleteMovieFromDB(String movie_code) {
		// 결과 전달을 위한 객체
		Map<String, String> sendMsgMap = new HashMap<String, String>();
		
		int deleteResult = movieService.deleteMovieInfo(movie_code);
		
		// 삭제 결과 판별 후 메세지 전달
		if(deleteResult > 0) {
			sendMsgMap.put("msg", "영화 삭제 완료");
		} else {
			sendMsgMap.put("msg", "영화 삭제 실패");
		}
		return sendMsgMap;
	}
	
	// 선택된 영화정보 조회
	@ResponseBody
	@GetMapping("SelectMovieInfo")
	public MovieVO selectMovieInfo(String movie_code) {
		MovieVO movie =	movieService.searchMovieInfo(movie_code);
		movie.setStr_regist_date(movie.getRegist_date().toString());
		movie.setStr_release_date(movie.getRelease_date().toString());
		return movie;
	}
	
	//관리자페이지 영화관리 상영예정작 페이지 맵핑
	@GetMapping("AdminMovieSetUpcoming")
	public String adminMovieSetUpcoming(Model model) {
		List<MovieVO> upcomingMovieList = movieService.getUpcomingMovieList();
		model.addAttribute("movieList", upcomingMovieList);
		return "adminpage/movie_set/upcoming_movie_set";
	}
	
	//상영예정작 페이지에서 상영기간 설정
	@ResponseBody
	@PostMapping("UpdateScreeningDate")
	public Map<String, String> updateScreeningDate(MovieVO movieVO) {
		Map<String, String> sendMsgMap = new HashMap<String, String>();
		int updateResult = movieService.setScreeningDate(movieVO);
		
		if(updateResult > 0) {
			sendMsgMap.put("msg", "상영기간설정 완료되었습니다");
			return sendMsgMap;
		} else {
			sendMsgMap.put("msg", "상영기간설정 실패");
			return sendMsgMap;
		}
	}
	
	//관리자페이지 영화관리 현재상영작 페이지 맵핑
	@GetMapping("AdminMovieSetCurrently")
	public String aminMovieSetCurrently() {
		return "adminpage/movie_set/currently_movie_set";
	}
	
	//관리자페이지 영화관리 지난상영작 페이지 맵핑
	@GetMapping("AdminMovieSetPast")
	public String AdminMovieSetPast() {
		return "adminpage/movie_set/past_movie_set";
	}
	
}
