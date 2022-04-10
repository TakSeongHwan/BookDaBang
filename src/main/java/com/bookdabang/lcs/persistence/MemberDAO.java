/**
 * 
 */
package com.bookdabang.lcs.persistence;

import java.util.List;

import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.Withdraw;
import com.bookdabang.lcs.domain.IsdormantDTO;
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
	// 회원조회
	public List<MemberVO> selectMember() throws Exception;
	// 휴면회원조회
	public List<MemberVO> dormantMember() throws Exception;
	// 탈퇴회원조회
	public List<Withdraw> deleteMember() throws Exception;
	// 휴면회원 전환
	public int updatedormant(IsdormantDTO dormant) throws Exception;
	// 회원삭제
	public int delete(String userId) throws Exception;
	
}
