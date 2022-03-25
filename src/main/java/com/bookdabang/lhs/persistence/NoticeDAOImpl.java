package com.bookdabang.lhs.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	@Inject
	private SqlSession ses;
	
}
