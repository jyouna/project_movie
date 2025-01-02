package com.itwillbs.project_movie.mapper;

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

	// 회원 정보 조회(패스워드만)
	String selectMemberPasswd(String id);

	// 회원 탈퇴(회원 상태값 수정)
	int updateMemberStatus(@Param("id") String id, @Param("member_status") int member_status);

	// ===========================================================
	// 메일 인증 정보 조회
	EmailAuthVO selectMailAuthInfo(EmailAuthVO mailAuthInfo); //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****

	// 신규 인증 정보 등록
	void insertMailAuthInfo(EmailAuthVO mailAuthInfo); //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****

	// 기존 인증 정보 수정
	void updateMailAuthInfo(EmailAuthVO mailAuthInfo); //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****

	// 메일 인증 상태 변경
	void updateMailAuthStatus(EmailAuthVO mailAuthInfo); //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****

	// 메일 인증 정보 삭제
	void deleteMailAuthInfo(EmailAuthVO mailAuthInfo); //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
}
