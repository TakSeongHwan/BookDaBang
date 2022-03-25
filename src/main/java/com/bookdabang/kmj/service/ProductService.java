package com.bookdabang.kmj.service;

import java.util.List;

import com.bookdabang.common.domain.Product;

public interface ProductService {
	// 상품 리스트
	public List<Product> readAllProducts () throws Exception;
	
	// 상품 상세정보
	public Product readProduct (int prodNo) throws Exception;
}
