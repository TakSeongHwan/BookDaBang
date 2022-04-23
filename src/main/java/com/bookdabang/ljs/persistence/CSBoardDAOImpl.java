package com.bookdabang.ljs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.CustomerService;

@Repository
public class CSBoardDAOImpl implements CSBoardDAO {
	
	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.csBoardMapper";

	@Override
	public List<CustomerService> showEntireCSBoard() {
		
		return ses.selectList(ns + ".showEntireCSBoard");
	}

	@Override
	public CustomerService readCSPost(int postNo) {
		 
		return ses.selectOne(ns + ".readCSPost", postNo);
	}

	@Override
	public int writeCSPost(CustomerService csPost) {
		
		return ses.insert(ns + ".writeCSPost", csPost);
	}

}
