package com.bookdabang.kmj.persistence;

import java.util.List;

import com.bookdabang.common.domain.ProductVO;

public interface ProductDAO {
	// 전체 상품 가져오는 메서드
	public List<ProductVO> selectAllProducts () throws Exception;
	
	// 한 상품 가져오는 메서드
	public ProductVO selectProduct (int prodNo) throws Exception;
	
	// Top 상품 가져오는 메서드
	public List<ProductVO> selectTopProducts (int category) throws Exception;
}
