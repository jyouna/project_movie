package com.itwillbs.project_movie.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_movie.mapper.MemberMapper;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EmailAuthVO; //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.GetGiveCouponInfoVO;
import com.itwillbs.project_movie.vo.MemberVO;
import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_movie.mapper.AdminManageMapper;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.GetGiveCouponInfoVO;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.MemberAllInfoVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;
import com.itwillbs.project_movie.vo.PaymentVO;
import com.itwillbs.project_movie.vo.PointVO;

import net.nurigo.sdk.message.model.Count;
//민기

@Service
public class MemberService {
   @Autowired
   private MemberMapper mapper;

   // 회원 등록 요청
   public int registMember(MemberVO member) {
      // MemberMapper - insertMember()
      return mapper.insertMember(member);
   }

   // 회원 로그인을 위한 아이디, 패스워드 판별 요청
   public String loginMember(MemberVO member) {
      // MemberMapper - selectMemberIdForLogin()
      return mapper.selectMemberIdForLogin(member);
   }
   

   // 회원 상세정보 조회 요청
   public MemberVO getMember(String id) {
      // MemberMapper - selectMember()
      return mapper.selectMember(id);
   }

   // 회원 정보 수정 요청 
   public int modifyMember(Map<String, String> map) {
      // MemberMapper - updateMember()
      return mapper.updateMember(map);
   }

   // 회원 정보 중 패스워드만 조회 요청
   public String getMemberPasswd(String id) {
      // MemberMapper - selectMemberPasswd()
      return mapper.selectMemberPasswd(id);
   }

   public int withdrawMember(String id) {
      // MemberMapper - updateMemberStatus()
      return mapper.updateMemberStatus(id, 3);
   }

//   public void registMailAuthInfo(EmailAuthVO emailAuthVO) {
//      // TODO Auto-generated method stub
//      
//   }
   
   // 아이디 찾기 조회 요청
	public String findMemberId(String member_name, Date birth_date, String email) {
		// TODO Auto-generated method stub
	    return mapper.findIdMember(member_name, birth_date, email);
	}
   // 비밀번호  찾기 조회 요청
	public String findMemberPasswd(String member_id, String member_name, Date birth_date, String email) {
		return mapper.findPasswdMember(member_id,member_name, birth_date, email);
		
	}

	public boolean isIdDuplicate(String member_id) {
		// TODO Auto-generated method stub
	    return mapper.checkIdDuplicate(member_id) > 0; // 중복된 아이디가 있으면 true
	}

	
	
	
	
// ===========================================================================	
	
	
	
	
    //관리자 후기 관리 - 장민기 20250123 시작 **********
	//리뷰 등록창
	//무비로그 - 관람평 글 전체 가져오기
	public int getReviewListCount() {
		// TODO Auto-generated method stub
		return mapper.selectReviewListCount();
	}
	//무비로그 - 관람평 시작번호 끝번호
	public List<Map<String, Object>> getReviewList(int startRow, int listLimit, String searchType, String seachKeyword) {
		return mapper.selectReviewList(startRow, listLimit, searchType, seachKeyword);
	}
	//관람한 영화 리뷰 수정 
	public int getReviewModify(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.updateReview(map);
	}
	//관람한 영화 리뷰 삭제
	public int removeReview(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.deleteReview(map);
	}
	//관리자 후기 관리 - 장민기 20250123 끝 **********


}
