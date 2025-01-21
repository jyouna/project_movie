package com.itwillbs.project_movie.mapper;

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
import com.itwillbs.project_movie.vo.PointVO;

@Mapper
public interface AdminManageMapper {

	int insertAccount(AdminRegisVO adminVo);

	int deleteAdminAccount(@Param("id") String id);

	void insertEventBoard(EventBoardVO eventVo);

	List<EventBoardVO> selectEventBoardList();

	void updateEventStatusStart(@Param("event_code") int event_code);

	void updateEventStatusEnd(@Param("event_code") int event_code);

	EventBoardVO getEventBoardList(@Param("event_code") int event_code);

	String checkAdminId(@Param("id") String id);

	int getBoardListCount();

	AdminRegisVO selectAdminAccountInfo(@Param("admin_id") String admin_id);

	void adminAccountModify(AdminRegisVO modifyVo);

	AdminRegisVO adminLogin(AdminRegisVO adminLoginInfo);

	List<AdminRegisVO> getEndEventList();

	List<MemberVO> selectMemberInfoForEvent();

	int insertCoupon(CouponVO coupon);

	List<EventWinnerVO> selectAllEventWinner(@Param("startRow") int startRow, 
											@Param("listLimit") int listLimit, 
											@Param("searchKeyword") String searchKeyword, 
											@Param("searchContent") String searchContent); // 쿠폰 당첨자 리스트
	
	List<EventWinnerVO> getPointWinnerList(@Param("startRow") int startRow, 
										   @Param("listLimit") int listLimit, 
										   @Param("searchKeyword") String searchKeyword, 
										   @Param("searchContent") String searchContent); // 포인트 당첨자 리스트

	EventBoardVO checkEventStatus(@Param("event_code") int event_code);

	void creditPoint(@Param("id") String id, 
					 @Param("point_amount") int point_amount);

	void insertPointInfo(@Param("id") String id, 
			 			 @Param("event_code") int event_code, 
			 			 @Param("point_amount") int point_amount);

	List<PointVO> getPointRecord(@Param("startRow") int startRow, 
								@Param("listLimit") int listLimit, 
								@Param("searchKeyword") String searchKeyword, 
								@Param("searchContent") String searchContent);

	List<CouponVO> getCouponList(@Param("startRow") int startRow, 
								@Param("listLimit") int listLimit, 
								@Param("searchKeyword") String searchKeyword, 
								@Param("searchContent") String searchContent);

	List<Map<String, String>> getCouponInfo();

	void updateEventWinnerSetStatus(@Param("event_code") int event_code);

	List<MemberAllInfoVO> getMemberAllInfo();

	List<AdminRegisVO> selectAdminPagingListPaging(@Param("startRow") int startRow, 
												   @Param("listLimit") int listLimit);
	
	List<MemberAllInfoVO> selectMemberListPaging(@Param("startRow") int startRow, 
												 @Param("listLimit") int listLimit, 
												 @Param("searchKeyword") String searchKeyword, 
												 @Param("searchContent") String searchContent);
	
	int getAdminListCount();
	
	int getMemberListCount(@Param("searchKeyword") String searchKeyword, 
						   @Param("searchContent") String searchContent);
	
	int getEventBoardListCount(@Param("searchKeyword") String searchKeyword, 
							   @Param("searchContent") String searchContent);
	
	int getCouponWinnerListCount(@Param("searchKeyword") String searchKeyword, 
								 @Param("searchContent") String searchContent);

	int getPointWinnerListCount(@Param("searchKeyword") String searchKeyword, 
								@Param("searchContent") String searchContent);

	int getCouponListCount(@Param("searchKeyword") String searchKeyword, 
							@Param("searchContent") String searchContent);

	int getPointListCount(@Param("searchKeyword") String searchKeyword, 
						@Param("searchContent") String searchContent);

	List<MemberVO> searchMemberList(@Param("searchKeyword") String searchKeyword, 
									@Param("searchContent") String searchContent);

	List<EventBoardVO> selectEventBoardList(@Param("startRow") int startRow, 
											@Param("listLimit") int listLimit, 
											@Param("searchKeyword") String searchKeyword, 
											@Param("searchContent") String searchContent);

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

	void createMembers(MemberVO member); // 회원 계정 생성 메크로

	int getAllEventWinnerCount(@Param("searchKeyword") String searchKeyword, 
							  @Param("searchContent") String searchContent);

	List<EventWinnerVO> getWinnerList(@Param("event_code") int event_code);

	int getSingleEventWinnerCount(@Param("event_code") int event_code);

	List<NoticeBoardVO> getNoticeBoardList();

	List<InquiryVO> getInquiryBoardList();

//	int getMonthlyNewMember(@Param("year")int year, @Param("month")int month);

}
