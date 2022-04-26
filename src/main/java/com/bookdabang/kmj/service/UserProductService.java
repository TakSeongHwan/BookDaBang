package com.bookdabang.kmj.service;

import java.util.List;
import java.util.Map;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.ProductVO;

public interface UserProductService {
	// 상품 리스트 (카테고리, 페이징 포함 , 검색어 포함)
	public Map<String, Object> readAllProducts (int cno, int pageNo, int sort, String searchWord) throws Exception;
	
	// 카테고리 리스트 (검색어 포함)
	public List<CategoryVO> readAllCategory (String searchWord) throws Exception;
	
	// 상품 상세정보
	public ProductVO readProduct (int prodNo) throws Exception;
	
	// Top 상품 리스트 (판매량순, 조회수순)
	public List<ProductVO> readTopProducts (int cno,String searchWord) throws Exception;
	
}
