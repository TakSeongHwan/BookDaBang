package com.bookdabang.tsh.service;

import java.util.List;

import com.bookdabang.common.domain.CartVO;
import com.bookdabang.tsh.domain.CartProdQttDTO;
import com.bookdabang.tsh.domain.CartSelectDTO;

public interface CartService {

	// 유저아이디로 장바구니 가져오기
	public List<CartVO> getAllCart(CartSelectDTO dto) throws Exception;
	
	public List<CartVO> selectCartByNo(List<Integer> cartNo) throws Exception;
	
	// 장바구니 제품 수량 증가
	public int updateCart(CartProdQttDTO dto) throws Exception;
	
	public int updateCartUserId(CartSelectDTO dto) throws Exception;
	
	// 장바구니 삭제
	public int deleteCart(int cartNo) throws Exception;
	
	// 장바구니 insert
	public int insertCart(CartVO cart) throws Exception;

	public int countCart(CartSelectDTO dto) throws Exception;

	public int loginCart(CartSelectDTO dto) throws Exception;
}
