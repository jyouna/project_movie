package com.itwillbs.project_movie.controller;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.service.MovieService;
import com.itwillbs.project_movie.service.MypageService;
import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.PageInfo;
import com.itwillbs.project_movie.vo.PaymentVO;
import com.itwillbs.project_movie.vo.ReviewVO;

@Controller
public class MovieController {
	
	@Autowired
	private MovieService movieService;
	
	// 영화안내 시즌무비 페이지 맵핑
	@GetMapping("SeasonMovieInfo")
	public String seasonMovieInfo(Model model) {
		// 시즌 현재상영작 리스트 조회
		List<MovieVO> movieList = movieService.getSeasonCurrentlyMovieList();
		model.addAttribute("movieList", movieList);
		return "movie_info/season_movie_info";
	}
	
	// 영화안내 현재상영작 페이지 맵핑
	@GetMapping("CurrentlyMovieInfo")
	public String currentlyMovieInfo(Model model) {
		// 현재상영작 리스트 조회
		List<MovieVO> currentlyMovieList = movieService.getCurrentlyMovieList();
		int seasonMovieCount = movieService.getCountSeasonCurrentlyMovie();
		int generalMovieCount = movieService.getCountGeneralCurrentlyMovie();
		
		// 영화 가격 조회
		int generalPrice = movieService.getTicketPrice();
		
		model.addAttribute("movieList", currentlyMovieList);
		model.addAttribute("seasonMovieCount", seasonMovieCount);
		model.addAttribute("generalMovieCount", generalMovieCount);
		model.addAttribute("generalPrice", generalPrice);
		return "movie_info/currently_movie_info";
	}
	
	// 영화안내 상영예정작 페이지 맵핑
	@GetMapping("UpcomingMovieInfo")
	public String upcomingMovieInfo(Model model) {
		// 전체 상영 예정작 수
		int upcomingTotalMovieCount = movieService.getCountTotalUpcomingMovie();
		// 일반 상영예정작 수
		int generalMovieCount = movieService.getCountGeneralUpcomingMovie();
		// 시즌 상영예정작 수
		int seasonMovieCount = movieService.getCountSeasonUpcomingMovie();
		// 상영예정작 리스트 조회
		List<MovieVO> upcomingMovieList = movieService.getUpcomingMovieList();
		// 영화 가격 조회
		int generalPrice = movieService.getTicketPrice();
		
		model.addAttribute("movieList", upcomingMovieList);
		model.addAttribute("seasonMovieCount", seasonMovieCount);
		model.addAttribute("generalMovieCount", generalMovieCount);
		model.addAttribute("totalCount", upcomingTotalMovieCount);
		model.addAttribute("generalPrice", generalPrice);
		return "movie_info/upcoming_movie_info";
	}
	
	// 영화안내 지난상영작 페이지 맵핑
	@GetMapping("PastMovieInfo")
	public String pastMovieInfo(@RequestParam(defaultValue = "1") int pageNum, Model model,
			@RequestParam(defaultValue="") String howSearch, @RequestParam(defaultValue="") String searchKeyword) {
		// 기본 영화 리스트 페이징처리와 구분을 위한 변수선언
		String howSearch2 = "movie_status";
		String searchKeyword2 = "지난상영작";
		
		// 페이징처리 메서드 
		if(!pagingMethod(model, pageNum, 10, howSearch, searchKeyword, howSearch2, searchKeyword2)) {
			return "result/process";
		}
		
		return "movie_info/past_movie_info";
	}
	
	// 영화상세안내 페이지 맵핑
	@GetMapping("MovieInfoDetail")
	public String movieInfoDetail(Model model, String movie_code) {
		// 영화코드로 영화정보 조회
		MovieVO movie = movieService.searchMovieInfo(movie_code);
		
		// 영화 가격 조회
		int generalPrice = movieService.getTicketPrice();
				
		model.addAttribute("movie", movie);
		model.addAttribute("generalPrice", generalPrice);
		return "movie_info/movie_info_detail";
	}
	
	//관리자페이지 영화관리 영화목록 페이지 맵핑, 영화리스트 출력, 검색한 영화 리스트 출력
	@GetMapping("AdminMovieSetList")
	public String adminMovieSetList(@RequestParam(defaultValue = "1") int pageNum, Model model,
			@RequestParam(defaultValue="") String howSearch, @RequestParam(defaultValue="") String searchKeyword) {
		
		// 지난상영작 리스트 페이징처리와 구분하기위한 변수선언
		String howSearch2 = "";
		String searchKeyword2 = "";
		
		//페이징 처리 메서드
		if(!pagingMethod(model, pageNum, 9, howSearch, searchKeyword, howSearch2, searchKeyword2)) {
			return "result/process";
		}
		
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
			
			// 트레일러주소 포맷
			String trailer_url = movieVO.getMovie_trailer().replace("watch?v=", "embed/");
			movieVO.setMovie_trailer(trailer_url);
			
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
		int upcomingTotalMovieCount = movieService.getCountTotalUpcomingMovie();
		
		if(upcomingTotalMovieCount >= 9) {
			sendMsgMap.put("msg", "더이상 상영예정작을 등록할 수 없습니다(현재 상영예정작 : 9개)");
			return sendMsgMap;
		} else {
			// 일반영화인지 시즌영화인지 비교후 상영예정작 등록 가능여부 판별(일반-6, 시즌-3)
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
	
	// 투표설정 페이지에서 투표영화 삭제
	@GetMapping("RemoveMovieFromPick")
	public String removeMovieFromPick(String movieCodeStr, Model model) {
		String[] movieCodeArr = movieCodeStr.trim().split(" ");
		int updateCount = movieService.changeMovieStatusToStandby(movieCodeArr);
		
		if(updateCount > 0) {
			return "redirect:/RemoveMovieFromPickSuccess";
		} else {
			model.addAttribute("msg", "투표영화 삭제 실패");
			return "result/process";
		}
	}
	
	// 투표영화삭제 성공
	@GetMapping("RemoveMovieFromPickSuccess")
	public String removeMovieFromPickSuccess(Model model) {
		model.addAttribute("targetURL", "AdminMoviePickSet");
		model.addAttribute("msg", "투표영화 삭제 성공");
		return "result/process";
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
		int seasonMovieCount = movieService.getCountSeasonUpcomingMovie();
		int generalMovieCount = movieService.getCountGeneralUpcomingMovie();
		model.addAttribute("movieList", upcomingMovieList);
		model.addAttribute("seasonMovieCount", seasonMovieCount);
		model.addAttribute("generalMovieCount", generalMovieCount);
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
	
	// 관리자 영화관리에서 영화상태 현재상영작으로 변경
	// 업데이트 후 alert창에 표시할 문구 리턴
	@ResponseBody
	@PostMapping("UpdateMovieStatusToCurrently")
	public Map<String, String> updateMovieStatusToCurrently(@RequestParam Map<String, String> map) {
		// 결과 전달을 위한 객체
		Map<String, String> sendMsgMap = new HashMap<String, String>();
		
		// 현재상영작은 9개이상 등록불가
		// 등록가능 여부 판별을 위해 현재상영작 수 조회
		int pickMovieCount = movieService.getCountCurrentlyMovie();
		if(pickMovieCount >= 9) {
			sendMsgMap.put("msg", "더이상 현재상영작 등록할 수 없습니다(현재상영작 : 9개)");
			return sendMsgMap;
		} else {
			int updateResult = movieService.setMovieStatus(map);
			// 업데이트 결과 판별 후 메세지 전달
			if(updateResult>0) {
				sendMsgMap.put("msg", "현재상영작 등록완료");
			} else {
				sendMsgMap.put("msg", "현재상영작 등록실패");
			}
			return sendMsgMap;
		}
	}
	
	// 관리자 영화관리에서 상영예정작을 다시 대기 영화로 변경
	@ResponseBody
	@PostMapping("RemoveFromUpcoming")
	public Map<String, String> removeFromUpcoming(@RequestParam Map<String, String> map) {
		// 결과 전달을 위한 객체
		Map<String, String> sendMsgMap = new HashMap<String, String>();
		int updateResult = movieService.setMovieStatus(map);
		
		// 업데이트 결과 판별 후 메세지 전달
		if(updateResult > 0) {
			sendMsgMap.put("msg", "상영예정작에서 삭제 완료");
		} else {
			sendMsgMap.put("msg", "상영예정작에서 삭제 실패");
		}
		return sendMsgMap;
	}
	
	// 관리자 영화관리에서 영화상태 지난상영작으로 변경
	// 업데이트 후 alert창에 표시할 문구 리턴
	@ResponseBody
	@PostMapping("UpdateMovieStatusToPast")
	public Map<String, String> updateMovieStatusToPast(@RequestParam Map<String, String> map) {
		// 결과 전달을 위한 객체
		Map<String, String> sendMsgMap = new HashMap<String, String>();
		int updateResult = movieService.setMovieStatus(map);
		
		// 업데이트 결과 판별 후 메세지 전달
		if(updateResult > 0) {
			sendMsgMap.put("msg", "지난상영작 등록완료");
		} else {
			sendMsgMap.put("msg", "지난상영작 등록실패");
		}
		return sendMsgMap;
	}
	
	//관리자페이지 영화관리 현재상영작 페이지 맵핑
	@GetMapping("AdminMovieSetCurrently")
	public String aminMovieSetCurrently(Model model) {
		List<MovieVO> currentlyMovieList = movieService.getCurrentlyMovieList();
		int seasonMovieCount = movieService.getCountSeasonCurrentlyMovie();
		int generalMovieCount = movieService.getCountGeneralCurrentlyMovie();
		model.addAttribute("movieList", currentlyMovieList);
		model.addAttribute("seasonMovieCount", seasonMovieCount);
		model.addAttribute("generalMovieCount", generalMovieCount);
		return "adminpage/movie_set/currently_movie_set";
	}
	
	//관리자페이지 영화관리 지난상영작 페이지 맵핑
	@GetMapping("AdminMovieSetPast")
	public String AdminMovieSetPast(@RequestParam(defaultValue = "1") int pageNum, Model model,
			@RequestParam(defaultValue="") String howSearch, @RequestParam(defaultValue="") String searchKeyword) {
		
		// 기본 영화 리스트 페이징처리와 구분을 위한 변수선언
		String howSearch2 = "movie_status";
		String searchKeyword2 = "지난상영작";
		
		// 페이징처리 메서드 
		if(!pagingMethod(model, pageNum, 9, howSearch, searchKeyword, howSearch2, searchKeyword2)) {
			return "result/process";
		}
		
		return "adminpage/movie_set/past_movie_set";
	}
	
	// 페이징 처리 메서드
	private Boolean pagingMethod(Model model, int pageNum, int listLimit, String howSearch, String searchKeyword,
			String howSearch2, String searchKeyword2) {
		int startRow = (pageNum - 1) * listLimit; // 조회할 영화의 DB 행 번호(= row 값)
		int listCount = movieService.getMovieListCount(howSearch, searchKeyword, howSearch2, searchKeyword2); //총영화 목록(검색 영화 목록)수 조회
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
			return false;
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		model.addAttribute("pageInfo", pageInfo);
		
		// 조건에맞는 영화 리스트 조회
		List<MovieVO> movieList = movieService.getMovieList(startRow, listLimit, howSearch, searchKeyword, howSearch2, searchKeyword2);
		
		// 지난상영작 페이지 리스트 조회시 줄거리 길이 조정을위해 if문 사용 후 줄거리 길이 조정
		// 다른 페이지 listLimit:9, 지난상영작 페이지 listLimit:10
		if(listLimit == 10) {
			for(MovieVO movie : movieList) {
				movie.setMovie_synopsis(movie.getMovie_synopsis().substring(0, 90) + "...");
			}
		}
		model.addAttribute("movieList", movieList);
		return true;
	}
	
}
