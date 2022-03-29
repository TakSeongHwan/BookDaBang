package com.bookdabang.tsh.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.Refund;

@Repository
public class RefundDAOImpl implements RefundDAO{
	
	@Inject
	private SqlSession ses;
	
	private String ns = "com.bookdabang.mapper.RefundMapper";

	@Override
	public List<Refund> selectAllRefund() throws Exception {
		return ses.selectList(ns+".selectAllRefund");
	}

}
