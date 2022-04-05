package com.bookdabang.ljs.persistence;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.domain.LoginDTO;

public interface MemberDAO {

	public MemberVO login(LoginDTO dto) throws Exception;
	
	public MemberVO findLoginSess(String sessionId) throws Exception;
	
	public int withdrawMember(String userId) throws Exception;
	
	public int lastLogin(LoginDTO dto);
	
	
	
}
