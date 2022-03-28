package com.bookdabang.tsh.service;

import java.util.List;

import com.bookdabang.common.domain.CartVO;
import com.bookdabang.tsh.domain.CartProdQttDTO;

public interface CartService {

	// 유저아이디로 장바구니 가져오기
	public List<CartVO> getCartByUserId(String userId) throws Exception;
	
	// 장바구니 제품 수량 증가
	public int updateCart(CartProdQttDTO dto) throws Exception;
	
	// 장바구니 삭제
	public int deleteCart(int cartNo) throws Exception;
	
	// 장바구니 insert
	public int insertCart(CartVO cart) throws Exception;
}
