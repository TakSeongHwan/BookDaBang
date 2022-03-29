package com.bookdabang.kmj.persistence;

import java.util.List;

import com.bookdabang.common.domain.Product;

public interface ProductDAO {
	// 전체 상품 가져오는 메서드
	public List<Product> selectAllProducts () throws Exception;
	
	// 한 상품 가져오는 메서드
	public Product selectProduct (int prodNo) throws Exception;
	
	// Top 상품 가져오는 메서드
	public List<Product> selectTopProducts (int category) throws Exception;
}
