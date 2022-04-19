package com.bookdabang.lhs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.domain.VisitorIPCheck;
import com.bookdabang.lhs.domain.AdminPagingInfo;
import com.bookdabang.lhs.domain.AdminProduct;
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
	public List<AdminProduct> getAdminProduct() throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.getAdminProduct();
	}
	
//	private AdminPagingInfo pagingProcess(int pageNo, BoardSearch bs) {
//		AdminPagingInfo pi = new AdminPagingInfo();
//		System.out.println("페이지 프로세스 : "+bs);
//		try{
//			if(bs.getSearchWord().equals("") || bs.getSearchType().equals("")) {
//				int cnt = chartDAO.getTotalPost();
//				pi.setTotalPostCnt(chartDAO.getTotalPost());
//				System.out.println("검색결과 갯수 : "+cnt);
//			}else {
//				int cnt = chartDAO.getSearchResultCnt(bs);
//				System.out.println("검색결과 갯수 : "+cnt);
//				pi.setTotalPostCnt(chartDAO.getSearchResultCnt(bs));
//			}
//		}catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		
//		
//		pi.setTotalPage(pi.getTotalPostCnt());
//		
//		pi.setStartNum(pageNo);
//		
//		pi.setTotalPagingBlock(pi.getTotalPage());
//		
//		pi.setCurrentPagingBlock(pageNo);
//		
//		pi.setStartNoOfCurPagingBlock(pi.getCurrentPagingBlock());
//		
//		pi.setEndNoOfCurPagingBlock(pi.getStartNoOfCurPagingBlock());
//		
//		System.out.println(pi.toString());
//		return pi;
//	
//		
//	}

}
