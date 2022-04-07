package com.bookdabang.tsh.persistence;

import java.util.List;

import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.tsh.domain.OrderDTO;

public interface OrderDAO {

	public List<ProdOrder> selectOrder(OrderDTO odto) throws Exception;

	public int insertOrder(ProdOrder order) throws Exception;
	
	public int updateOrderCofirm(int orderNo) throws Exception;
	
	public List<ProdOrder> selectAllOrder() throws Exception;

	public int allOrderCnt(SearchCriteria sc) throws Exception;

	public List<ProdOrder> orderView(SearchCriteria sc, PagingInfo pi) throws Exception;
}
