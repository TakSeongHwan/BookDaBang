package com.bookdabang.tsh.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.CartVO;
import com.bookdabang.tsh.domain.CartProdQttDTO;


@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	private SqlSession ses;
	
	private String ns = "com.bookdabang.mapper.CartMapper";

	@Override
	public List<CartVO> getCartByUserId(String userId) throws Exception {
		return ses.selectList(ns+".getCartByUserId", userId);
	}
	
	@Override
	public int updateCart(CartProdQttDTO dto) throws Exception{
		return ses.update(ns+".updateCartProdQtt", dto);
	}

	@Override
	public int deleteCart(int cartNo) throws Exception {
		return ses.delete(ns+".deleteCart",cartNo);
	}
	
}
