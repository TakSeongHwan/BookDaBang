package com.bookdabang.ljs.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.domain.LoginDTO;

@Repository
public class MemberDAOImpl implements MemberDAO  {

	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.TestMapper";
	
	@Override
	public MemberVO login(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".login", dto);
	}

}
