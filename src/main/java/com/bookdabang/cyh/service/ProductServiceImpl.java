package com.bookdabang.cyh.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.cyh.persistence.ProductDAO;

@Service
public class ProductServiceImpl implements ProductService {
	@Inject
	private ProductDAO pdao;

	@Override
	public List<CategoryVO> getCategory() throws Exception {
		return pdao.getCategory();

	}

	

	@Override
	public Map<String, Object> conditionProdView(SearchCriteria sc, int pageno) throws Exception {
		PagingInfo pi =pagingProcess(pageno, sc);
		Map<String, Object> map  = new HashMap<String, Object>();
		map.put("product", pdao.conditionProdView(sc,pi));
		map.put("pagingInfo", pi);
		return map;
		
	}
	
	private PagingInfo pagingProcess(int pageNo, SearchCriteria sc) throws Exception {
		PagingInfo pi = new PagingInfo();
		pi.setPostPerPage(10);
		pi.setPageCntPerBlock(5);
		
		int totalPostCnt = pdao.conditionProdCnt(sc);
		
		
		pi.setTotalPostCnt(totalPostCnt);
		//전체 페이지 수
		pi.setTotalPage(pi.getTotalPostCnt());
		// 현재 페이제에서 출력 시작할 글번호
		pi.setStartNum(pageNo);
		// 전체 페이징 블럭
		pi.setTotalPagingBlock(pi.getTotalPage());
		//현재 페이지 블럭
		pi.setCurrentPagingBlock(pageNo);
		//현재 페이지에서의 시작 페이징 블럭
		pi.setStartNoOfCurPagingBlock(pi.getCurrentPagingBlock());
		//현재 페이지에서의 끝 페이징 블럭
		pi.setEndNoOfCurPagingBlock(pi.getStartNoOfCurPagingBlock());
		
		System.out.println(pi.toString());
		
		return pi;
		
	}
	
	
	

}
