package com.bookdabang.tsh.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.tsh.domain.OrderDTO;
import com.bookdabang.tsh.persistence.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Inject
	private OrderDAO dao;

	@Override
	public List<ProdOrder> selectOrder(OrderDTO odto) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectOrder(odto);
	}

	@Override
	public int insertOrder(ProdOrder order) throws Exception {
		return dao.insertOrder(order);
	}

	@Override
	public int updateOrderCofirm(int orderNo) throws Exception {
		return dao.updateOrderCofirm(orderNo);
	}
	
}
