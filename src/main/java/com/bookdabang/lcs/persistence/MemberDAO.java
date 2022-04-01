/**
 * 
 */
package com.bookdabang.lcs.persistence;

import javax.servlet.http.HttpServletRequest;

import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.lcs.domain.MemberDTO;

public interface MemberDAO {
	// 회원가입
	public int insertMember(MemberDTO member) throws Exception; 
	// 아이디 중복확인
	public MemberVO userIdCheck(String userId) throws Exception;
	// 닉네임 중복확인
	public MemberVO nickNameCheck(String nickName) throws Exception;
	// 회원가입 포인트 부여
	public int insertPoint(MemberPoint point) throws Exception;
	// 추천인 적을시 포인트 부여
	public int recommendPoint(String recommend) throws Exception;
}
