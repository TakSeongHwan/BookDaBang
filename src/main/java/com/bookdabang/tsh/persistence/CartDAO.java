package com.bookdabang.tsh.persistence;

import java.util.List;

import com.bookdabang.common.domain.CartVO;
import com.bookdabang.tsh.domain.CartProdQttDTO;

public interface CartDAO {

	// 유저아이디로 장바구니 얻어오기
	public List<CartVO> getCartByUserId(String userId) throws Exception;

	public int updateCart(CartProdQttDTO dto) throws Exception;
	
	public int deleteCart(int cartNo) throws Exception;
}
