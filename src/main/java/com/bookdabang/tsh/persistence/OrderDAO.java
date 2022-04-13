package com.bookdabang.tsh.persistence;

import java.sql.Timestamp;
import java.util.List;

import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.tsh.domain.OrderDTO;
import com.bookdabang.tsh.etc.SearchCriteria;

public interface OrderDAO {

	public List<ProdOrder> selectOrder(OrderDTO odto) throws Exception;

	public int insertOrder(ProdOrder order) throws Exception;
	
	public int updateOrderCofirm(int orderNo) throws Exception;
	
	public List<ProdOrder> selectAllOrder() throws Exception;

	public int allOrderCnt(SearchCriteria sc) throws Exception;

	public List<ProdOrder> orderView(SearchCriteria sc, PagingInfo pi) throws Exception;

	public int updateOrderState(int orderState, int orderNo) throws Exception;
}
