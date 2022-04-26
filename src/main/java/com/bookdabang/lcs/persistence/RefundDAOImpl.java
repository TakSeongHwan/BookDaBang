
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
	public List<Refund> refundList(String userId) throws Exception {
		return sql.selectList(ns + ".refundList",userId);
	}
	@Override
	public List<Refund> adminRefundList() throws Exception {
		return sql.selectList(ns + ".selectAllRefund");
	}
	@Override
	public int refundUpdate(int refundNo) throws Exception {
	
		return sql.update(ns + ".refundUpdate",refundNo);
	}
	@Override
	public int getOrderNo(int refundNo) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(ns+".getOrderNo",refundNo);
	}

}
