package com.bookdabang.ljs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.RecentSeenProd;
import com.bookdabang.ljs.domain.LoginDTO;

@Repository
public class MyPageDAOImpl implements MyPageDAO {
	
	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.MyPageMapper";

	@Override
	public List<RecentSeenProd> showRecentSeenProd(String userId) {
		return ses.selectList(ns + ".showRecentSeenProd", userId);
	}

	@Override
	public int modifyPassword(LoginDTO passwordID) {
		return ses.update(ns+ ".updatePassword", passwordID);
	}

	@Override
	public String showOldPwd(String userId) {
		
		return ses.selectOne(ns + ".showOldPwd", userId);
	}

}
