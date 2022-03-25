package com.bookdabang.lbr.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.FreeBoard;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.boardMapper";
	
	@Override
	public List<FreeBoard> getListAllFreeBoards() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns + ".listAllFreeBoard");
	}

}
