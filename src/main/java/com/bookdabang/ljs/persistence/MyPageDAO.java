package com.bookdabang.ljs.persistence;

import java.util.List;

import com.bookdabang.common.domain.RecentSeenProd;
import com.bookdabang.ljs.domain.LoginDTO;

public interface MyPageDAO {
	
	public List<RecentSeenProd> showRecentSeenProd(String userId);

	public int modifyPassword(LoginDTO passwordID);
	
	public String showOldPwd(String userId);
	

}
