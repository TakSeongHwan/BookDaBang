package com.bookdabang.tsh.service;

import java.util.List;

import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.tsh.domain.OrderDTO;

public interface OrderService {
	public List<ProdOrder> selectOrder(OrderDTO odto) throws Exception;

	public int insertOrder(ProdOrder order) throws Exception;
	
	public int updateOrderCofirm(int orderNo) throws Exception;
}
