package com.bookdabang.tsh.service;

import java.util.List;

import com.bookdabang.common.domain.AddressVO;
import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.tsh.domain.OrderDTO;
import com.bookdabang.tsh.domain.OrderInputDTO;

public interface OrderService {
	public List<ProdOrder> selectOrder(OrderDTO odto) throws Exception;
	
	public int updateOrderCofirm(int orderNo) throws Exception;

	public String insertOrder(AddressVO addrvo, List<String> cartNo, String orderPwd) throws Exception;

}
