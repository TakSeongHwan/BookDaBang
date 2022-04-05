package com.bookdabang.lhs.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ChartDAOImpl implements ChartDAO {
	@Inject
	private SqlSession ses;
	
	
}
