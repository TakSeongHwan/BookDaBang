package com.bookdabang.ljs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.RecentSeenProd;
import com.bookdabang.ljs.domain.LoginDTO;
import com.bookdabang.ljs.persistence.MyPageDAO;

@Service
public class MyPageServiceImpl implements MyPageService {

	@Inject
	private MyPageDAO mdao;
	
	
	@Override
	public List<RecentSeenProd> showRecentSeenProd(String userId) throws Exception {
		
		return mdao.showRecentSeenProd(userId);
	}


	@Override
	public int modifyPassword(LoginDTO passwordID) throws Exception {
		
		return mdao.modifyPassword(passwordID);
	}
	
	@Override
	public String showOldPwd(String userId) throws Exception {
		
		return mdao.showOldPwd(userId);
	}
	
	

}
