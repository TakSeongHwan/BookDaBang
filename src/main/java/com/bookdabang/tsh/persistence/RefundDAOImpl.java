package com.bookdabang.tsh.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Repository
public class RefundDAOImpl {
	
	@Inject
	private SqlSession ses;
	
	private String ns = "com.bookdabang.mapper.RefundMapper";

}
