package com.bookdabang.tsh.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.CartVO;
import com.bookdabang.tsh.domain.CartProdQttDTO;
import com.bookdabang.tsh.domain.CartSelectDTO;
import com.bookdabang.tsh.persistence.CartDAO;

@Service
public class CartServiceImpl implements CartService {

	@Inject
	private CartDAO dao;
	
	@Override
	public List<CartVO> getAllCart(CartSelectDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return dao.getAllCart(dto);
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

	@Override
	public int updateCartUserId(CartSelectDTO dto) throws Exception {
		return dao.updateCartUserId(dto);
	}

	@Override
	public List<CartVO> selectCartByNo(List<Integer> cartNo) throws Exception {
		
		List<CartVO> result = new ArrayList<CartVO>();
		System.out.println(cartNo);
		for(int cart : cartNo) {
			result.add(dao.selectCartByNo(cart));
		}

		return result;
	}

	@Override
	public int countCart(CartSelectDTO dto) throws Exception {
		return dao.countCart(dto);
	}

	@Override
	public int loginCart(CartSelectDTO dto) throws Exception {
		return dao.loginCart(dto);
	}


}
