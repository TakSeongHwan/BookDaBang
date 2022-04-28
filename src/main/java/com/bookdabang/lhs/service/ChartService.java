package com.bookdabang.lhs.service;

import java.util.List;
import java.util.Map;

import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.domain.VisitorIPCheck;
import com.bookdabang.lhs.domain.AdminProduct;
import com.bookdabang.lhs.domain.CategoryTotalSales;
import com.bookdabang.lhs.domain.RecentBestSeller;
import com.bookdabang.lhs.domain.SalesChartDetail;
import com.bookdabang.lhs.domain.SalesDataDetail;
import com.bookdabang.lhs.domain.SalesDataWithDate;
import com.bookdabang.lhs.domain.StartDateEndDate;
import com.bookdabang.lhs.domain.VisitorCountWithDateFormat;

public interface ChartService {

	public List<ProductVO> getProductSort() throws Exception;

	public List<ProductVO> getRandomSelect() throws Exception;
	
	public List<VisitorCountWithDateFormat> getVisitorInfo() throws Exception;

	public int autoInsertVisitor(VisitorIPCheck vipc) throws Exception;

	public int getTodayVisitor() throws Exception;

	public int getYesterdayVisitor() throws Exception;

	public Map<String,Object> getAdminProduct(int pageNo, BoardSearch bs, String sortType) throws Exception;

	public List<CategoryTotalSales> getCategoryTotalSales() throws Exception;

	public List<RecentBestSeller> getRecentBestSellerInSalesData() throws Exception;

	public List<VisitorCountWithDateFormat> getWeekVisitor() throws Exception;

	public List<ProductVO> getLessStock() throws Exception;

	public Map<String,Object> getDetailChart(SalesChartDetail scd) throws Exception;

	public List<VisitorCountWithDateFormat> getVisitorDetailChart(SalesChartDetail scd) throws Exception;

	public int getAllSalesData()throws Exception;

	public float getBookSalesMonth() throws Exception;

	public List<SalesDataWithDate> periodSalesDetail(StartDateEndDate sded) throws Exception;



}
