package com.bookdabang.ljs.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.domain.LoginDTO;

@Repository
public class LoginDAOImpl implements LoginDAO  {

	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.MyPageMapper";
	
	@Override
	public MemberVO login(LoginDTO dto) throws Exception {
		 
		return ses.selectOne(ns + ".login", dto);
	}

	@Override
	public int withdrawMember(String userId) throws Exception {
		
		return ses.update(ns + ".withdrawMember", userId);
	}

	@Override
	public int lastLogin(LoginDTO dto) {
		
		return ses.update(ns  + ".putLastLogin", dto) ;
	}

	@Override
	public MemberVO findLoginSess(String sessionId) throws Exception {
		 
		return ses.selectOne(ns + ".loginSession", sessionId);
	}


	
	

}
