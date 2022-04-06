package com.bookdabang.ljs.persistence;

import java.util.List;

import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.domain.LoginDTO;

public interface LoginDAO {

	public MemberVO login(LoginDTO dto) throws Exception;
	
	public MemberVO findLoginSess(String sessionId) throws Exception;
	
	public int withdrawMember(String userId) throws Exception;
	
	public int lastLogin(LoginDTO dto);

	public List<MemberPoint> pointCheck(String userId);
	
	
	
}
