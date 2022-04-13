package com.bookdabang.tsh.persistence;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.tsh.domain.OrderDTO;
import com.bookdabang.tsh.etc.SearchCriteria;
@Repository
public class OrderDAOImpl implements OrderDAO {

	@Inject
	private SqlSession ses;
	
	private String ns = "com.bookdabang.mapper.OrderMapper";

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

	@Override
	public List<ProdOrder> selectAllOrder() throws Exception {
		return ses.selectList(ns+".selectAllOrder");
	}

	@Override
	public int allOrderCnt(SearchCriteria sc) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".orderCnt", sc);
	}

	@Override
	public List<ProdOrder> orderView(SearchCriteria sc, PagingInfo pi) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("startNum",pi.getStartNum() );
		param.put("postPerPage",pi.getPostPerPage());
		param.put("searchType", sc.getSearchType());
		param.put("searchWord", sc.getSearchWord());
		param.put("startSellDate", sc.getStartSellDate());
		param.put("endSellDate", sc.getEndSellDate());
		return ses.selectList(ns + ".orderView", param);
	}

	@Override
	public int updateOrderState(int orderState, int orderNo) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("orderState",orderState);
		param.put("orderNo",orderNo);
		int result = ses.update(ns+".updateOrderState", param);
		return result;
	}
	
	
	
}
