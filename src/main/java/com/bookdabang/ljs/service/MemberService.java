package com.bookdabang.ljs.service;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.domain.LoginDTO;

public interface MemberService {

	public MemberVO login(LoginDTO dto) throws Exception;
	
	public MemberVO findLoginSess(String sessionId) throws Exception;
	
	public int lastLogin(LoginDTO dto) throws Exception;
	
	public int withdrawMember(String userId) throws Exception;
	
	
}
