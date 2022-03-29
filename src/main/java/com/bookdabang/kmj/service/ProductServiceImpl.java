package com.bookdabang.kmj.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.Product;
import com.bookdabang.kmj.persistence.ProductDAO;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Inject
	private ProductDAO dao;

	@Override
	public List<Product> readAllProducts() throws Exception {
		List<Product> lst = dao.selectAllProducts();
		return lst;
	}

	@Override
	public Product readProduct(int prodNo) throws Exception {
		Product product = dao.selectProduct(prodNo);
		return product;
	}

	@Override
	public List<Product> readTopProducts(int category) throws Exception {
		List<Product> lst = dao.selectTopProducts(category);
		return lst;
	}

}
