package com.bookdabang.kmj.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.kmj.persistence.UserProductDAO;

@Service
public class UserProductServiceImpl implements UserProductService {
	
	@Inject
	private UserProductDAO dao;

	@Override
	public List<ProductVO> readAllProducts() throws Exception {
		List<ProductVO> lst = dao.selectAllProducts();
		return lst;
	}
	
	@Override
	public List<CategoryVO> readAllCategory() throws Exception {
		List<CategoryVO> lst = dao.getCategory();
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
