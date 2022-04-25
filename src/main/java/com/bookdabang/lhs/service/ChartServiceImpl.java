package com.bookdabang.lhs.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.NoticeVO;
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
import com.bookdabang.lhs.persistence.ChartDAO;


@Service
public class ChartServiceImpl implements ChartService {

	
	@Inject
	ChartDAO chartDAO;

	@Override
	public List<ProductVO> getProductSort() throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.getProductSort();
	}

	@Override
	public List<ProductVO> getRandomSelect() throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.getRandomSelect();
	}

	@Override
	public List<VisitorCountWithDateFormat> getVisitorInfo() throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.getVisitorInfo();
	}

	@Override
	public int autoInsertVisitor(VisitorIPCheck vipc) throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.autoInsertVisitor(vipc);
	}

	@Override
	public int getTodayVisitor() throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.getTodayVisitor();
	}

	@Override
	public int getYesterdayVisitor() throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.getYesterdayVisitor();
	}

	@Override
	public Map<String,Object> getAdminProduct(int pageNo, BoardSearch bs, String sortType) throws Exception {
		AdminPagingInfo pi = pagingProcess(pageNo, bs);
		List<AdminProduct> list = new ArrayList<AdminProduct>();
		System.out.println(bs.toString());
		
		if(bs.getSearchWord().equals("") || bs.getSearchType().equals("")) {
			list = chartDAO.getAdminProduct(pi,sortType);
		}else {
			list = chartDAO.getAdminProduct(pi, bs, sortType); 
		}
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("adminProduct", list);
		map.put("pagingInfo", pi);
		return map;
	}
	
	private AdminPagingInfo pagingProcess(int pageNo, BoardSearch bs) {
		AdminPagingInfo pi = new AdminPagingInfo();
		System.out.println("페이지 프로세스 : "+bs);
		try{
			if(bs.getSearchWord().equals("") || bs.getSearchType().equals("")) {
				int cnt = chartDAO.getTotalPost();
				pi.setTotalPostCnt(chartDAO.getTotalPost());
				System.out.println("검색결과 갯수 : "+cnt);
			}else {
				int cnt = chartDAO.getSearchResultCnt(bs);
				System.out.println("검색결과 갯수 : "+cnt);
				pi.setTotalPostCnt(chartDAO.getSearchResultCnt(bs));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		pi.setTotalPage(pi.getTotalPostCnt());
		
		pi.setStartNum(pageNo);
		
		pi.setTotalPagingBlock(pi.getTotalPage());
		
		pi.setCurrentPagingBlock(pageNo);
		
		pi.setStartNoOfCurPagingBlock(pi.getCurrentPagingBlock());
		
		pi.setEndNoOfCurPagingBlock(pi.getStartNoOfCurPagingBlock());
		
		System.out.println(pi.toString());
		return pi;
	
		
	}

	@Override
	public List<CategoryTotalSales> getCategoryTotalSales() throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.getCategoryTotalSales();
	}

	@Override
	public List<RecentBestSeller> getRecentBestSellerInSalesData() throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.getRecentBestSellerInSalesData();
	}

	@Override
	public List<VisitorCountWithDateFormat> getWeekVisitor() throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.getWeekVisitor();
	}

	@Override
	public List<ProductVO> getLessStock() throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.getLessStock();
	}

	@Override
	public Map<String,Object> getDetailChart(SalesChartDetail scd) throws Exception {
		
		System.out.println("?");
		
		Map<String,Object> map = new HashMap<String, Object>();
		Map<String,Object> dtoMap = new HashMap<String, Object>();
	
		if(scd.getSearchType().equals("age")) {
			Map<String,Integer> ageMap = new HashMap<String, Integer>();
			Map<String,Object> result = new HashMap<String, Object>();
			ageMap.put("ten", 10);
			ageMap.put("twent", 20);
			ageMap.put("thirt",30);
			ageMap.put("fourt",40);
			ageMap.put("fifty",50);
			ageMap.put("sixty",60);
			ageMap.put("sevent",70);
			ageMap.put("eight",80);
			
			dtoMap.put("SalesChartDetail", scd);
			dtoMap.put("ageMap",ageMap);
			Map<String,Object> resultMap = chartDAO.getDetailChartAge(dtoMap);
			for(int i = 0; i < resultMap.size(); i++) {
				System.out.println((i+1)*10);
				String key = (i+1)*10+"";
				System.out.println(resultMap.get(key));
			}
			
			
			result = chartDAO.getDetailChartAge(dtoMap);
			map.put("ageResult",result);
			
		}else if(scd.getSearchType().equals("category")) {
			
			map.put("categoryResult", chartDAO.getDetailChartCategory(scd));
			
		}else if(scd.getSearchType().equals("gender")) {
			Map<String,String> genderMap = new HashMap<String, String>();
			
			genderMap.put("male", "male");
			genderMap.put("female", "female");
			
			dtoMap.put("SalesChartDetail", scd);
			dtoMap.put("genderMap",genderMap);
			map.put("genderResult",chartDAO.getDetailChartGender(dtoMap));
			
		}
		
	
		
		
		
		return map;
	}

	@Override
	public List<VisitorCountWithDateFormat> getVisitorDetailChart(StartDateEndDate sded) throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.getVisitorDetailChart(sded);
	}

}
