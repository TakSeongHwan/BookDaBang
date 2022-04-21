package com.bookdabang.lhs.persistence;

import java.util.List;

import com.bookdabang.common.domain.BoardSearch;

import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.domain.VisitorIPCheck;
import com.bookdabang.lhs.domain.AdminPagingInfo;
import com.bookdabang.lhs.domain.AdminProduct;
import com.bookdabang.lhs.domain.CategoryTotalSales;
import com.bookdabang.lhs.domain.RecentBestSeller;
import com.bookdabang.lhs.domain.VisitorCountWithDateFormat;

public interface ChartDAO {

	public List<ProductVO> getProductSort() throws Exception;

	public List<ProductVO> getRandomSelect() throws Exception;

	public List<VisitorCountWithDateFormat> getVisitorInfo() throws Exception;

	public int autoInsertVisitor(VisitorIPCheck vipc) throws Exception;

	public int getTodayVisitor() throws Exception;

	public int getYesterdayVisitor() throws Exception;

	public List<AdminProduct> getAdminProduct(AdminPagingInfo pi, BoardSearch bs, String sortType) throws Exception;

	public List<AdminProduct> getAdminProduct(AdminPagingInfo pi, String sortType) throws Exception;

	public int getTotalPost() throws Exception;

	public int getSearchResultCnt(BoardSearch bs) throws Exception;

	public List<CategoryTotalSales> getCategoryTotalSales() throws Exception;

	public List<RecentBestSeller> getRecentBestSellerInSalesData() throws Exception;

	public List<VisitorCountWithDateFormat> getWeekVisitor() throws Exception;

	public List<ProductVO> getLessStock() throws Exception;

}
