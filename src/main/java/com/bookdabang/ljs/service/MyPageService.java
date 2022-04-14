package com.bookdabang.ljs.service;

import java.util.List;

import com.bookdabang.common.domain.RecentSeenProd;
import com.bookdabang.ljs.domain.LoginDTO;

public interface MyPageService {
	
	public List<RecentSeenProd> showRecentSeenProd(String userId) throws Exception; 
	
	public int modifyPassword(LoginDTO passwordID) throws Exception;

	public String showOldPwd(String userId) throws Exception;
	
	
	

}
