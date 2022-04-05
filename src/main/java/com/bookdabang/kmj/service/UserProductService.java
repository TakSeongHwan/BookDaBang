package com.bookdabang.kmj.service;

import java.util.List;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.ProductVO;

public interface UserProductService {
	// 상품 리스트
	public List<ProductVO> readAllProducts () throws Exception;
	
	// 카테고리 리스트
	public List<CategoryVO> readAllCategory () throws Exception;
	
	// 상품 상세정보
	public ProductVO readProduct (int prodNo) throws Exception;
	
	// Top 상품 리스트
	public List<ProductVO> readTopProducts (int category) throws Exception;
}
