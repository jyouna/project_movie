package com.itwillbs.project_movie.controller;

import java.util.List;
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
	
	//관리자페이지 영화관리 영화목록 페이지 맵핑, 영화리스트 출력
	@GetMapping("AdminMovieSetList")
	public String adminMovieSetList(@RequestParam(defaultValue = "1") int pageNum, Model model) {
		
		int listLimit = 9; // 한 페이지 당 표시할 게시물 수
		int startRow = (pageNum - 1) * listLimit; // 조회할 영화의 DB 행 번호(= row 값)
		int listCount = movieService.getMovieListCount(); //총 영화 목록수 조회
		int pageListLimit = 5; // 한페이지당 페이지번호 수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); // 최대 페이지번호
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; //각 페이지의 첫번째 페이지 번호
		int endPage = startPage + pageListLimit - 1; // 각 페이지의 마지막 페이지번호
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		if(pageNum < 1 || (maxPage > 0 && pageNum > maxPage)) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
			model.addAttribute("targetURL", "AdminMovieSetList?pageNum=1");
			return "result/process";
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		model.addAttribute("pageInfo", pageInfo);
		
		List<MovieVO> movieList = movieService.getMovieList(startRow, listLimit);
		model.addAttribute("movieList", movieList);
		
		return "adminpage/movie_set/admin_movie_list";
	}
	
	// 관리자 영화목록에서 검색어 검색으로 리스트 출력
	// ajax 요청을 통해 json 형식으로 리턴
	@ResponseBody
	@GetMapping("AdminMovieSetSearchBox")
	public List<MovieVO> adminMovieSetSearchBox(@RequestParam Map<String, String> map) {
		List<MovieVO> SearchMovieList =  movieService.searchMovie(map);
		
		// ajax 응답할때 timestamp 타입으로 반환되는 db의 Date타입 데이터를
		// String타입으로 변환 후 응답
		for(MovieVO movieVO : SearchMovieList) {
			movieVO.setStr_regist_date(movieVO.getRegist_date().toString());
		}
		return SearchMovieList;
	}
	
	// 관리자 영화목록에서 영화등록 로직
	@PostMapping("AdminMovieInfoRegist")
	public String movieInfoRegist(MovieVO movieVO, Model model, HttpSession session) {
		/* sId 판별식 추가 예정 */
		String id = (String)session.getAttribute("sId");
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
	public String updateMovieStatusToUpcoming(@RequestParam Map<String, String> map) {
		// 결과 전달을 위한 변수
		String sendMessage = "";
		
		// 상영예정작은 9개이상 등록 불가(시즌 별 상영작 9개 제한)
		// 등록가능 여부 판별을 위해 상영예정작 수 조회
		int UpcomingMovieCount = movieService.getCountConditionMovie(map);
		if(UpcomingMovieCount >= 9) {
			sendMessage = "더이상 상영예정작을 등록할 수 없습니다\\n(현재 상영예정작 : 9개)";
			return sendMessage;
		} else {
			System.out.println(map.toString());
			int updateResult = movieService.setMovieStatus(map);
			// 업데이트 결과 판별 후 메세지 전달
			sendMessage = updateResult > 0 ? "상영예정작으로 등록완료" :"상영예정작으로 등록실패\\n";	
			return sendMessage;
		}
	}
	
	// 관리자 영화관리에서 영화상태 상영예정작으로 변경
	// 업데이트 후 alert창에 표시할 문구 리턴
	@ResponseBody
	@PostMapping("UpdateMovieStatusToPick")
	public String updateMovieStatusToPick(@RequestParam Map<String, String> map) {
		// 결과 전달을 위한 변수
		String sendMessage = "";
		
		// 투표영화는 5개이상 등록 불가
		// 등록가능 여부 판별을 위해 투표영화 수 조회
		int pickMovieCount = movieService.getCountConditionMovie(map);
		if(pickMovieCount >= 5) {
			sendMessage = "더이상 투표영화를 등록할 수 없습니다\\n(현재 상영예정작 : 9개)";
			return sendMessage;
		} else {
			System.out.println(map.toString());
			int updateResult = movieService.setMovieStatus(map);
			// 업데이트 결과 판별 후 메세지 전달
			sendMessage = updateResult > 0 ? "투표영화로 등록완료" : "투표영화로 등록실패\\n";	
			return sendMessage;
		}
	}
	
	//관리자페이지 영화관리 상영예정작 페이지 맵핑
	@GetMapping("AdminMovieSetUpcoming")
	public String adminMovieSetUpcoming() {
		return "adminpage/movie_set/upcoming_movie_set";
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
