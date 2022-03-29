package com.bookdabang.tsh.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class AddressDAOImpl implements AddressDAO {
	@Inject
	private SqlSession ses;
	
	private String ns = "com.bookdabang.mapper.AddressMapper";
	
	
}
