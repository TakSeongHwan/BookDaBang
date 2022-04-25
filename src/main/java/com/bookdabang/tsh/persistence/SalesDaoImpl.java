package com.bookdabang.tsh.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.Sales;

@Repository
public class SalesDaoImpl implements SalesDAO {

	@Inject
	private SqlSession ses;
	
	private String ns = "com.bookdabang.mapper.OrderMapper";
	
	@Override
	public int insertSales(Sales sale) throws Exception {
		return ses.insert(ns+".insertSales", sale);
	}

	
}
