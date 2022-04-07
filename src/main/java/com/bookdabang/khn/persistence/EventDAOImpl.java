package com.bookdabang.khn.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class EventDAOImpl implements EventDAO {

	@Inject
	private SqlSession ses;
	private static String ns = "com.bookdabang.mapper.eventMapper";
	
	
	@Override
	public List allEventList() throws Exception {
		return ses.selectList(ns + ".allEventList");
	}

}
