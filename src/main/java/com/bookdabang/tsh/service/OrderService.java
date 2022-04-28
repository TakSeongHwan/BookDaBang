package com.bookdabang.tsh.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.bookdabang.common.domain.AddressVO;
import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.tsh.domain.ManageOrderDTO;
import com.bookdabang.tsh.domain.OrderDTO;
import com.bookdabang.tsh.domain.OrderInputDTO;
import com.bookdabang.tsh.domain.OrderViewDTO;
import com.bookdabang.tsh.etc.SearchCriteria;

public interface OrderService {
	public List<ProdOrder> selectOrder(OrderDTO odto) throws Exception;
	
	public int updateOrderCofirm(int orderNo, String confirm) throws Exception;

	public String insertOrder(AddressVO addrvo, List<String> cartNo, String orderPwd) throws Exception;
	
	public Map<String, Object> selectAllOrder(SearchCriteria sc, int pageno) throws Exception;

	public int updateOrderState(int orderState, int orderNo) throws Exception;

	public Map<String, Object> orderStatus(String sessionId,int pageno) throws Exception;

	public List<OrderViewDTO> orderCheck(ProdOrder po) throws Exception;

}
