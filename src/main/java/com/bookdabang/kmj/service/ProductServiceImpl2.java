package com.bookdabang.kmj.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.kmj.persistence.ProductDAO;

@Service
public class ProductServiceImpl2 implements ProductService {
	
	@Inject
	private ProductDAO dao;

	@Override
	public List<ProductVO> readAllProducts() throws Exception {
		List<ProductVO> lst = dao.selectAllProducts();
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
