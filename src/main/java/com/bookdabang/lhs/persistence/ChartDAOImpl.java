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
import com.bookdabang.lhs.domain.SalesChartDetail;
import com.bookdabang.lhs.domain.SalesDataDetail;
import com.bookdabang.lhs.domain.StartDateEndDate;
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

	@Override
	public List<SalesDataDetail> getDetailChartCategory(SalesChartDetail scd) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getDetailChartCategory",scd);
	}

	@Override
	public Map<String,Object> getDetailChartAge(Map<String, Object> map) throws Exception {
		System.out.println("???");
		SalesChartDetail scd = (SalesChartDetail)map.get("SalesChartDetail");
		Map<String, Object> ageMap = (Map<String,Object>)map.get("ageMap");
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
		Map<String,Object> dtoMap = new HashMap<String, Object>();
		
		dtoMap.put("startDate", scd.getStartDate());
		dtoMap.put("endDate",scd.getEndDate());
		dtoMap.put("ageStart",ageMap.get("ten"));
		dtoMap.put("ageEnd",ageMap.get("twent"));
		resultMap.put("10", ses.selectList(ns+".getAge",dtoMap));
		
		dtoMap.put("ageStart",ageMap.get("twent"));
		dtoMap.put("ageEnd",ageMap.get("thirt"));
		resultMap.put("20", ses.selectList(ns+".getAge",dtoMap)); 
		
		dtoMap.put("ageStart",ageMap.get("thirt"));
		dtoMap.put("ageEnd",ageMap.get("fourt"));
		resultMap.put("30", ses.selectList(ns+".getAge",dtoMap));
		
		dtoMap.put("ageStart",ageMap.get("fourt"));
		dtoMap.put("ageEnd",ageMap.get("fifty"));
		resultMap.put("40", ses.selectList(ns+".getAge",dtoMap));

		dtoMap.put("ageStart",ageMap.get("fifty"));
		dtoMap.put("ageEnd",ageMap.get("sixty"));
		resultMap.put("50", ses.selectList(ns+".getAge",dtoMap));
		
		dtoMap.put("ageStart",ageMap.get("sixty"));
		dtoMap.put("ageEnd",ageMap.get("sevent"));
		resultMap.put("60", ses.selectList(ns+".getAge",dtoMap));
		
		dtoMap.put("ageStart",ageMap.get("sevent"));
		dtoMap.put("ageEnd",ageMap.get("eight"));
		resultMap.put("70", ses.selectList(ns+".getAge",dtoMap));
		
		return resultMap;
	}

	@Override
	public Map<String, Object> getDetailChartGender(Map<String, Object> map) throws Exception {
		Map<String,Object> genderMap = (Map<String,Object>)map.get("genderMap");
		SalesChartDetail scd = (SalesChartDetail)map.get("SalesChartDetail");
		
		Map<String, Object> dtoMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(scd.toString());
		dtoMap.put("startDate",scd.getStartDate());
		dtoMap.put("endDate",scd.getEndDate());
		dtoMap.put("gender",genderMap.get("male"));
		resultMap.put("male", ses.selectList(ns+".getGender",dtoMap));
		
		dtoMap.put("gender",genderMap.get("female"));
		resultMap.put("female", ses.selectList(ns+".getGender",dtoMap));
		
		return resultMap;
	}

	@Override
	public List<VisitorCountWithDateFormat> getVisitorDetailChart(StartDateEndDate sded) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getVisitorDetailChart",sded);
	}
	
	
}
