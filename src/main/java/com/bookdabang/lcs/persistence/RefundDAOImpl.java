
package com.bookdabang.lcs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.Refund;

@Repository
public class RefundDAOImpl implements RefundDAO {

	@Inject
	private SqlSession sql;
	private static String ns = "com.bookdabang.mapper.RefundMapper";

	@Override
	public List<Refund> refundList() throws Exception {
		return sql.selectList(ns + ".refundList");
	}
	@Override
	public List<Refund> adminRefundList() throws Exception {
		return sql.selectList(ns + ".selectAllRefund");
	}
	@Override
	public int refundUpdate() throws Exception {
	
		return sql.update(ns + ".refundUpdate");
	}

}
