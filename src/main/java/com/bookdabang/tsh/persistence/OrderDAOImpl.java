package com.bookdabang.tsh.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.tsh.domain.OrderDTO;
@Repository
public class OrderDAOImpl implements OrderDAO {

	@Inject
	private SqlSession ses;
	
	private String ns = "com.bookdabang.mapper.CartMapper";

	@Override
	public List<ProdOrder> selectOrder(OrderDTO odto) throws Exception {
		return ses.selectList(ns+".selectOrder",odto);
	}

	@Override
	public int insertOrder(ProdOrder order) throws Exception {
		return ses.insert(ns+".insertOrder", order);
	}

	@Override
	public int updateOrderCofirm(int orderNo) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns+".updateOrderCofirm", orderNo);
	}
	
}
