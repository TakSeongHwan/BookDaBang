package com.bookdabang.ljs.service;

import java.util.HashMap;
import java.util.List;

import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.domain.LoginDTO;

public interface LoginService {

	public MemberVO login(LoginDTO dto) throws Exception;
	
	public MemberVO findLoginSess(String sessionId) throws Exception;
	
	public int lastLogin(LoginDTO dto) throws Exception;
	
	public int withdrawMember(String userId) throws Exception;
	
	public List<MemberPoint> pointCheck(String userId) throws Exception;
	
	public String getAccessToken (String authorize_code) throws Exception;
	
	public HashMap<String, Object> getUserInfo(String access_Token) throws Exception;
	
}
