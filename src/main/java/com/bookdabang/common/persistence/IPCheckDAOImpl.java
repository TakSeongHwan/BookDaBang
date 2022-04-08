package com.bookdabang.common.persistence;

import java.sql.Timestamp;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.VisitorIPCheck;

@Repository
public class IPCheckDAOImpl implements IPCheckDAO{

	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.CommonMapper";
	
	@Override
	public Timestamp checkMaxAccessDate(String ipaddr) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".maxAccessDate",ipaddr);
	}

	@Override
	public int insertAccessDate(String ipaddr) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns+".insertAccessDate",ipaddr);
	}


}
