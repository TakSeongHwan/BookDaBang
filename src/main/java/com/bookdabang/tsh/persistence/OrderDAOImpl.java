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
import com.bookdabang.tsh.domain.OrderViewDTO;
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
	public int updateOrderCofirm(int orderNo,String confirm) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("orderNo", orderNo);
		param.put("confirm", confirm);
		return ses.update(ns+".updateOrderCofirm", param);
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
		param.put("orderState",sc.getOrderState());
		param.put("confirm",sc.getConfirm());
		param.put("all",sc.isAll());
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

	@Override
	public int getNextOrderNo() throws Exception {
		if(ses.selectOne(ns+".getNextOrderNo") == null) {
			return 1;
		}
		return ses.selectOne(ns+".getNextOrderNo");
	}

	@Override
	public List<OrderViewDTO> orderStatus(String userId,PagingInfo pi) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId",userId);
		param.put("startNum",pi.getStartNum() );
		param.put("postPerPage",pi.getPostPerPage());
		return ses.selectList(ns+".orderStatus", param);
	}

	@Override
	public List<OrderViewDTO> orderCheck(ProdOrder po) throws Exception {
		return ses.selectList(ns+".orderCheck",po);
	}

	@Override
	public int orderStatusCnt(String userId) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".orderStatusCnt",userId);
	}
	
	
	
}
