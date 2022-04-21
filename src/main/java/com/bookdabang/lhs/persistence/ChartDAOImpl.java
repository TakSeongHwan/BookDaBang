package com.bookdabang.lhs.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.domain.VisitorIPCheck;
import com.bookdabang.lhs.domain.AdminPagingInfo;
import com.bookdabang.lhs.domain.AdminProduct;
import com.bookdabang.lhs.domain.CategoryTotalSales;
import com.bookdabang.lhs.domain.RecentBestSeller;
import com.bookdabang.lhs.domain.VisitorCountWithDateFormat;

@Repository
public class ChartDAOImpl implements ChartDAO {
	@Inject
	private SqlSession ses;

	private static String ns = "com.bookdabang.mapper.ChartMapper";
	
	@Override
	public List<ProductVO> getProductSort() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getSalesCount");
	}

	@Override
	public List<ProductVO> getRandomSelect() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getRandomBook");
	}

	@Override
	public List<VisitorCountWithDateFormat> getVisitorInfo() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getVisitorInfo");
	}

	@Override
	public int autoInsertVisitor(VisitorIPCheck vipc) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns+".autoInsertVisitor",vipc);
	}

	@Override
	public int getTodayVisitor() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".getTodayVisitor");
	}

	@Override
	public int getYesterdayVisitor() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".getYesterdayVisitor");
	}

	public List<AdminProduct> getAdminProduct(AdminPagingInfo pi, String sortType) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startNum", pi.getStartNum());
		map.put("postPerPage", pi.getPostPerPage());
		map.put("sortType", sortType);

		return ses.selectList(ns+".getProductInfo", map);
	}
	
	@Override
	public List<AdminProduct> getAdminProduct(AdminPagingInfo pi, BoardSearch bs, String sortType) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchType", bs.getSearchType());
		map.put("searchWord", bs.getSearchWord());
		map.put("startNum", pi.getStartNum());
		map.put("postPerPage", pi.getPostPerPage());
		map.put("sortType", sortType);
		System.out.println(map.toString());
		System.out.println(bs.toString());

		return ses.selectList(ns+".getSearchResultList", map);
	}

	@Override
	public int getTotalPost() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".getTotalPost");
	}
	@Override
	public int getSearchResultCnt(BoardSearch bs) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".getSearchResultCnt",bs);
	}

	@Override
	public List<CategoryTotalSales> getCategoryTotalSales() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getCategoryTotalSales");
	}

	@Override
	public List<RecentBestSeller> getRecentBestSellerInSalesData() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getRecentBestSellerInSalesData");
	}

	@Override
	public List<VisitorCountWithDateFormat> getWeekVisitor() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getWeekVisitor");
	}

	@Override
	public List<ProductVO> getLessStock() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getLessStock");
	}
	
	
}
