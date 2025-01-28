package com.itwillbs.project_movie.mapper;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.MemberAllInfoVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;
import com.itwillbs.project_movie.vo.PaymentVO;
import com.itwillbs.project_movie.vo.PointVO;

@Mapper
public interface AdminManageMapper {
	//관리자 후기 관리 - 장민기 20250123 시작 **********
	//내가 본 영화 - 리뷰 등록
	int insertReview(@Param("movieName") String movieName, @Param("reviewContent")String reviewContent, 
			@Param("reviewRecommend")int reviewRecommend, @Param("movieCode")int movieCode, @Param("id") String id);
	//int insertReview(@Param("map") Map<String, String> map);
	//내가 본 영화 - 리뷰 창 띄우기 
	//Map<String, Object> selectWatchedmovieReview(String movie_code);
	//내가 본 영화 - 리뷰등록 포함 출력
	Map<String, Object> selectIsRegistReview(@Param("id") String id, @Param("movie_code") String movie_code);
	//관람평 글 개수 조회
	int selectReviewListCount();
	//관람평 시작번호 끝번호
	List<Map<String, Object>> selectReviewList(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	//관람한 영화 리뷰 수정 
	int updateReview(Map<String, String> map);
	//관람한 영화 리뷰 삭제
	int deleteReview(Map<String, String> map);
	//관리자 후기 관리 - 장민기 20250123 끝 **********	
	
	// 관리자 계정 관리
	// 1. 관리자 계정 등록
	int insertAccount(AdminRegisVO adminVo);
	// 2. 관리자 계정 삭제
	int deleteAdminAccount(@Param("id") String id);
	// 3. 관리자 아이디 조회
	String checkAdminId(@Param("id") String id);
	// 4. 관리자 계정 수 조회
	int getBoardListCount();
	// 5. 관리자 계정 정보 가져오기 
	AdminRegisVO selectAdminAccountInfo(@Param("admin_id") String admin_id);
	// 6. 관리자 계정 정보 수정
	void adminAccountModify(AdminRegisVO modifyVo);
	// 7. 관리자 로그인 시 아이디, 패스워드 판별
	AdminRegisVO adminLogin(AdminRegisVO adminLoginInfo);
	// 8. 관리자 계정관리 페이지 출력 데이터 조회
	List<AdminRegisVO> selectAdminPagingListPaging(@Param("startRow") int startRow, 
													@Param("listLimit") int listLimit);
	// 9. 관리자 계정관리 게시판 listcount 조회
	int getAdminListCount();
	
	
	
	
	// 회원관리
	// 1. 회원 테이블 정보 조회
	List<MemberVO> selectMemberInfoForEvent();
	// 2. 쿠폰, 포인트 테이블 JOIN을 통한 회원 전체 정보 조회
	List<MemberAllInfoVO> selectMemberListPaging(@Param("startRow") int startRow, 
												 @Param("listLimit") int listLimit, 
												 @Param("searchKeyword") String searchKeyword, 
												 @Param("searchContent") String searchContent);	
	// 3. 페이징 없이 회원 전체 정보 조회
	List<MemberAllInfoVO> getMemberAllInfo();
	// 4. 회원정보 게시판 listcount 조회
	int getMemberListCount(@Param("searchKeyword") String searchKeyword, 
							@Param("searchContent") String searchContent);
	// 5. 회원리스트 조회
	List<MemberVO> searchMemberList(@Param("searchKeyword") String searchKeyword,
									@Param("searchContent") String searchContent);	
	
	
	
	// 이벤트 관리
	// 1. 이벤트 등록
	void insertEventBoard(EventBoardVO eventVo);
	// 2. 전체 이벤트 목록 조회
	List<EventBoardVO> selectEventBoardList();
	// 3. 이벤트 대기 -> 진행 상태로 변경
	void updateEventStatusStart(@Param("event_code") int event_code);
	// 4. 이벤트 진행 -> 종료 상태로 변경
	void updateEventStatusEnd(@Param("event_code") int event_code);
	// 5. 단일 이벤트 정보 조회
	EventBoardVO getEventBoardList(@Param("event_code") int event_code);
	// 6. 전체 이벤트 목록 조회
	List<AdminRegisVO> getEndEventList();
	// 7. 쿠폰 당첨자 리스트 조회
	List<EventWinnerVO> selectAllEventWinner(@Param("startRow") int startRow, 
											@Param("listLimit") int listLimit, 
											@Param("searchKeyword") String searchKeyword, 
											@Param("searchContent") String searchContent); 
	// 8. 포인트 당첨자 리스트
	List<EventWinnerVO> getPointWinnerList(@Param("startRow") int startRow, 
											@Param("listLimit") int listLimit, 
											@Param("searchKeyword") String searchKeyword, 
											@Param("searchContent") String searchContent); 
	// 9. 이벤트 진행상태 확인
	EventBoardVO checkEventStatus(@Param("event_code") int event_code);
	// 10. 이벤트 당첨자 추첨 시 당첨상태 완료로 변경
	void updateEventWinnerSetStatus(@Param("event_code") int event_code);
	// 11. 이벤트 게시판 listcount 조회
	int getEventBoardListCount(@Param("searchKeyword") String searchKeyword, 
							   @Param("searchContent") String searchContent,
							   @Param("eventStatus")String eventStatus,
							   @Param("eventWinnerStatus") String eventWinnerStatus);
	// 12. 이벤트 게시판 목록 조회 최종
	List<EventBoardVO> selectEventBoardList(@Param("startRow") int startRow, 
											@Param("listLimit") int listLimit, 
											@Param("searchKeyword") String searchKeyword, 
											@Param("searchContent") String searchContent, 
											@Param("eventStatus") String eventStatus, 
											@Param("eventWinnerStatus") String eventWinnerStatus);
	
	// 쿠폰 관련
	// 1. 쿠폰 등록
	int insertCoupon(CouponVO coupon);
	// 2. 쿠폰 내역 목록 조회
	List<CouponVO> getCouponList(@Param("startRow") int startRow, 
								@Param("listLimit") int listLimit, 
								@Param("searchKeyword") String searchKeyword, 
								@Param("searchContent") String searchContent);
	// 3. 회원별 보유 쿠폰 개수 가져오기 
	List<Map<String, String>> getCouponInfo();
	// 4. 쿠폰 당첨자 listcount 조회
	int getCouponWinnerListCount(@Param("searchKeyword") String searchKeyword, 
			 					@Param("searchContent") String searchContent);	
	// 5. 쿠폰내역 listcount 조회
	int getCouponListCount(@Param("searchKeyword") String searchKeyword, 
							@Param("searchContent") String searchContent);
	
	
	// 포인트 관련
	// 1. 포인트 지급 
	int creditPoint(@Param("id") String id, 
					 @Param("point_amount") int point_amount);
	// 2. 이벤트 당첨 시 포인트 정보 추가
	int insertPointInfo(@Param("id") String id, 
			 			 @Param("event_code") int event_code, 
			 			 @Param("point_amount") int point_amount);
	// 3. 포인트 내역 목록 조회
	List<PointVO> getPointRecord(@Param("startRow") int startRow, 
								@Param("listLimit") int listLimit, 
								@Param("searchKeyword") String searchKeyword, 
								@Param("searchContent") String searchContent);
	// 4. 포인트 당첨자 listcount 조회
	int getPointWinnerListCount(@Param("searchKeyword") String searchKeyword, 
								@Param("searchContent") String searchContent);	
	// 5. 포인트 내역 listcount 조회
	int getPointListCount(@Param("searchKeyword") String searchKeyword, 
						@Param("searchContent") String searchContent);
	
	// 2, 3번 차트 월 가입자 수 조회
	int getMonthlyTotalNewMember(@Param("year")int year,
								@Param("month")int month);

	List<EventWinnerVO> getAllEventWinnerList(@Param("startRow") int startRow, 
											@Param("listLimit") int listLimit, 
											@Param("searchKeyword") String searchKeyword, 
											@Param("searchContent") String searchContent);

	int modifyEventBoard(EventBoardVO eventVo);

	int deleteEventBoard(@Param("event_code") int event_code);

	int checkEventStatusForDelete(@Param("event_code") int event_code);

	int getMemberCount(@Param("searchKeyword") String searchKeyword, @Param("searchContent") String searchContent);

	String getTotalPeriodMemberJoin(@Param("year") String year);
	
	// 회원 계정 대량 생성 매크로
	void createMembers(MemberVO member); 

	int getAllEventWinnerCount(@Param("searchKeyword") String searchKeyword, 
							  @Param("searchContent") String searchContent);

	List<EventWinnerVO> getWinnerList(@Param("event_code") int event_code);

	int getSingleEventWinnerCount(@Param("event_code") int event_code);

	List<NoticeBoardVO> getNoticeBoardList();

	List<InquiryVO> getInquiryBoardList();

	MemberVO getMyInfo(@Param("sMemberId") String sMemberId);

	String getDbPasswd(@Param("member_id") String member_id);

	int updateMyInfo(MemberVO member);
	
	// 매출 데이터 대량 생성 매크로
	void createSalesRecord(PaymentVO payment); // 매출 생성 메크로
	
	// 월 매출액 조회
	int getMonthlySales(@Param("year") int year, @Param("month") int month);
	
	// 월 총환불액 조회
	int getMonthlyRefund(@Param("year") int year, @Param("month") int month);
	
	// 전체 기간(연 단위) 매출액 출력을 위한 연 단위 매출액 조회
	int getAnnualSales(@Param("year") int year);
	
	// 연 단위 환불액 조회
	int getAnnualRefund(@Param("year") int year);
	
	// 스케줄러로 매일 09시 20분에 쿠폰 기한 만료 시 '사용불가' 처리
	void handlingExpiredCoupon(@Param("date") LocalDate date);
	
	// 이벤트 당첨자 목록 조회
	List<String> getBookingEventWinnerList(@Param("event_start_date") Date event_start_date, @Param("event_end_date") Date event_end_date);
	
	// 매출 데이터 생성에 필요한 멤버 아이디 조회 
	List<String> getMemberIdList();
	
	// 일일 매출 데이터 조회
	List<Map<String, Object>> getDailySales(@Param("firstDay") LocalDate firstDay, @Param("lastDay")LocalDate lastDay);
	
	// 관리자가 직접 포인트 지급
	void addPointInfo(@Param("id") String id, @Param("point_amount") int point_amount);
	
	// 관리자가 직접 쿠폰 지급
	int createCoupon(@Param("expiredDate") Date expiredDate, @Param("couponType") String couponType, 
					@Param("discountRate") int discountRate, @Param("discountAmount")int discountAmount, @Param("id")String id);
	
	// 기간 내 예매자가 없을 경우 이벤트 자동종료
	void endEventWithoutWinner(@Param("event_code") int event_code);
	// 이벤트 자동 시작 스케줄러 실행
	void eventAutoStart(@Param("date") LocalDate date);
	// 이벤트 자동 종료 스케줄러 실행
	void eventAutoEnd(@Param("date") LocalDate date);
	
}
