package com.bookdabang.tsh.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.CartVO;
import com.bookdabang.tsh.domain.CartProdQttDTO;
import com.bookdabang.tsh.persistence.CartDAO;

@Service
public class CartServiceImpl implements CartService {

	@Inject
	private CartDAO dao;
	
	@Override
	public List<CartVO> getCartByUserId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return dao.getCartByUserId(userId);
	}

	@Override
	public int updateCart(CartProdQttDTO dto) throws Exception {
		return dao.updateCart(dto);
	}

	@Override
	public int deleteCart(int cartNo) throws Exception {
		return dao.deleteCart(cartNo);
	}

	@Override
	public int insertCart(CartVO cart) throws Exception {
		// TODO Auto-generated method stub
		return dao.insertCart(cart);
	}

}
