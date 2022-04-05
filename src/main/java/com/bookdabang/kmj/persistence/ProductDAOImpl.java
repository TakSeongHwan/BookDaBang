package com.bookdabang.kmj.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.Product;

@Repository
public class ProductDAOImpl implements ProductDAO {
	
	@Inject
	private SqlSession ses; // SqlSessionTemplete 객체 주입
	
	private static String ns = "com.bookdabang.mapper.productMapper"; // mapper의 namespace

	@Override
	public List<Product> selectAllProducts() throws Exception {
		return ses.selectList(ns + ".selectAllProducts");
	}
	
	@Override
	public List<CategoryVO> getCategory() throws Exception {
		return ses.selectList(ns + ".getCategory");
	}

	@Override
	public Product selectProduct(int prodNo) throws Exception {
		return ses.selectOne(ns + ".selectProduct", prodNo);
	}

	@Override
	public List<Product> selectTopProducts(int category) throws Exception {
		return ses.selectList(ns + ".selectTopProducts", category);
	}

	

}
