package com.bookdabang.ljs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.domain.LoginDTO;
import com.bookdabang.ljs.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Inject
	private MemberDAO mdao;
	
	
	@Override
	public MemberVO login(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return mdao.login(dto);
	}

}
