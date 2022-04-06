package com.bookdabang.cyh.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.common.persistence.ProductDAO;

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
	
	@Override
	public List<ProductVO> selectProdView(List<String> checkProd) throws Exception {
		
		List<ProductVO> prodLst = new ArrayList<ProductVO>();
		for(String prodNo : checkProd) {
			prodLst.add(pdao.selectProdView(prodNo));
		}
		
		return prodLst;
	}
	
	private PagingInfo pagingProcess(int pageNo, SearchCriteria sc) throws Exception {
		PagingInfo pi = new PagingInfo();
		pi.setPostPerPage(10);
		pi.setPageCntPerBlock(5);
		
		int totalPostCnt = pdao.conditionProdCnt(sc);
		
		
		pi.setTotalPostCnt(totalPostCnt);
		//�쟾泥� �럹�씠吏� �닔
		pi.setTotalPage(pi.getTotalPostCnt());
		// �쁽�옱 �럹�씠�젣�뿉�꽌 異쒕젰 �떆�옉�븷 湲�踰덊샇
		pi.setStartNum(pageNo);
		// �쟾泥� �럹�씠吏� 釉붾윮
		pi.setTotalPagingBlock(pi.getTotalPage());
		//�쁽�옱 �럹�씠吏� 釉붾윮
		pi.setCurrentPagingBlock(pageNo);
		//�쁽�옱 �럹�씠吏��뿉�꽌�쓽 �떆�옉 �럹�씠吏� 釉붾윮
		pi.setStartNoOfCurPagingBlock(pi.getCurrentPagingBlock());
		//�쁽�옱 �럹�씠吏��뿉�꽌�쓽 �걹 �럹�씠吏� 釉붾윮
		pi.setEndNoOfCurPagingBlock(pi.getStartNoOfCurPagingBlock());
		
		System.out.println(pi.toString());
		
		return pi;
		
	}



	
	
	
	
	
	

}
