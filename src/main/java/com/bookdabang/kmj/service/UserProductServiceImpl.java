package com.bookdabang.kmj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.persistence.ProductDAO;
import com.bookdabang.common.domain.PagingInfo;

@Service
public class UserProductServiceImpl implements UserProductService {
	
	@Inject
	private ProductDAO dao;
	
	@Override
	public Map<String, Object> readAllProducts(int cno, int pageNo, int sort) throws Exception {
		PagingInfo pi = pagingProcess(pageNo,cno);
		List<ProductVO> lst = null;
		if (cno == 0) {
			lst = dao.selectAllProducts(pi,sort);
		} else {
			lst = dao.selectAllProducts(cno,pi,sort);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productList", lst);
		map.put("pagingInfo", pi);
		
		return map;
	}
	
	// 페이징 처리 작업 전담 메서드
	private PagingInfo pagingProcess(int pageNo, int cno) throws Exception {
		PagingInfo pi = new PagingInfo();
		
		// 1페이지당 보여 줄 글의 개수 & 1개의 블럭에 보여줄 페이지 수
		pi.setPostPerPage(9);
		pi.setPageCntPerBlock(5);
		
		// 전체 게시물 개수
		if (cno == 0) {
			pi.setTotalPostCnt(dao.getTotalPost());
		} else {
			pi.setTotalPostCnt(dao.getTotalPost(cno));
		}
		
		// 전체 페이지 수
		pi.setTotalPage(pi.getTotalPostCnt());
		// 현재 페이지에서 출력 시작할 글번호
		pi.setStartNum(pageNo);
		// 전체 페이징 블럭
		pi.setTotalPagingBlock(pi.getTotalPage());
		// 현재 페이징 블럭
		pi.setCurrentPagingBlock(pageNo);
		// 현재 페이지에서의 시작 페이징블럭
		pi.setStartNoOfCurPagingBlock(pi.getCurrentPagingBlock());
		// 현재 페이지에서의 끝 페이징블럭
		pi.setEndNoOfCurPagingBlock(pi.getStartNoOfCurPagingBlock());

		System.out.println(pi.toString());

		return pi;
	}
	
	@Override
	public List<CategoryVO> readAllCategory() throws Exception {
		List<CategoryVO> lst = dao.selectCategory();
		return lst;
	}

	@Override
	public ProductVO readProduct(int prodNo) throws Exception {
		ProductVO product = dao.selectProduct(prodNo);
		return product;
	}

	@Override
	public List<ProductVO> readTopProducts(int category) throws Exception {
		List<ProductVO> lst = dao.selectTopProducts(category);
		return lst;
	}

	

	

}
