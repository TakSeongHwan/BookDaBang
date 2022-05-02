package com.bookdabang.tsh.persistence;

import java.sql.Timestamp;
import java.util.List;

import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.tsh.domain.OrderDTO;
import com.bookdabang.tsh.domain.OrderViewDTO;
import com.bookdabang.tsh.etc.SearchCriteria;

public interface OrderDAO {

	public List<ProdOrder> selectOrder(OrderDTO odto) throws Exception;

	public int insertOrder(ProdOrder order) throws Exception;
	
	public int updateOrderCofirm(int orderNo,String confirm) throws Exception;
	
	public List<ProdOrder> selectAllOrder() throws Exception;

	public int allOrderCnt(SearchCriteria sc) throws Exception;

	public List<ProdOrder> orderView(SearchCriteria sc, PagingInfo pi) throws Exception;

	public int updateOrderState(int orderState, int orderNo) throws Exception;

	public int getNextOrderNo() throws Exception;

	public List<OrderViewDTO> orderStatus(String userId, PagingInfo pi) throws Exception;

	public List<OrderViewDTO> orderCheck(ProdOrder po) throws Exception;

	public int orderStatusCnt(String userId) throws Exception;

	public int confirmUpdate(int orderNo)throws Exception;
}
