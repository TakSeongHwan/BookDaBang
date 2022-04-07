package com.bookdabang.tsh.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.tsh.domain.OrderDTO;
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
		return ses.selectOne(ns + ".allOrderCnt", sc);
	}

	@Override
	public List<ProdOrder> orderView(SearchCriteria sc, PagingInfo pi) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("searchType", sc.getSearchType());
		param.put("searchWord", sc.getSearchWord());
		param.put("category_code",sc.getCategory_code());
		param.put("startNum",pi.getStartNum() );
		param.put("postPerPage",pi.getPostPerPage());
		param.put("sortWord", sc.getSortWord());
		param.put("sortMethod", sc.getSortMethod());
		param.put("startRgDate", sc.getStartRgDate());
		param.put("endRgDate", sc.getEndRgDate());
		param.put("display_status",sc.getDisplay_status());
		param.put("sales_status",sc.getSales_status());
		return ses.selectList(ns + ".orderView", param);
	}
	
	
	
}
