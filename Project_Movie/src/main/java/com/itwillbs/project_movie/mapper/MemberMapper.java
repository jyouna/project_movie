package com.itwillbs.project_movie.mapper;

import java.sql.Date;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.EmailAuthVO; //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
import com.itwillbs.project_movie.vo.MemberVO;
//민기

@Mapper
public interface MemberMapper {

	// 회원 등록
	int insertMember(MemberVO member);

	// 회원 로그인을 위한 아이디, 패스워드 판별
	String selectMemberIdForLogin(MemberVO member);

	// 회원 상세정보 조회
	MemberVO selectMember(String id);

	// 회원 정보 수정
	int updateMember(Map<String, String> map);
	
	
	int updateMemberWithoutPasswd(Map<String, String> map);


	// 회원 정보 조회(패스워드만)
	String selectMemberPasswd(String id);

	// 회원 탈퇴(회원 상태값 수정)
	int updateMemberStatus(@Param("id") String id, @Param("member_status") int member_status);

	// ===========================================================
	// 메일 인증 정보 조회
	EmailAuthVO selectMailAuthInfo(EmailAuthVO email_auth); //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****

	// 신규 인증 정보 등록
	void insertMailAuthInfo(EmailAuthVO email_auth); //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****

	// 기존 인증 정보 수정
	void updateMailAuthInfo(EmailAuthVO email_auth); //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
 
	
	
	// 메일 인증 상태 변경
	void updateMailAuthStatus(EmailAuthVO email_auth); //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****

	// 메일 인증 정보 삭제
	void deleteMailAuthInfo(EmailAuthVO email_auth); //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
	
	
	// =============================
	// 추가 기능: 이메일 인증 상태 확인 메서드
	// 이메일 인증 여부 확인을 위한 메서드 추가
	int checkEmailAuthStatus(@Param("email") String email);
	// ============================

	String findIdMember(@Param("member_name") String member_name, 
			@Param("birth_date") Date birth_date,
			@Param("email") String email);

	String findPasswdMember(@Param("member_id") String member_id, 
			@Param("member_name") String member_name, 
			@Param("birth_date") Date birth_date,
			@Param("email") String email);

	
	
	
	//비밀번호찾기시 인증이 완료후 이메일을 통해 임시비밀번호를 보내기전에
	//임시비밀번호를 비밀번호에 update한다.
	int updateMemberPassword(MemberVO member);

	int checkIdDuplicate(String member_id);

	

	
	
	
}
