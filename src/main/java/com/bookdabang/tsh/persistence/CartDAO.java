package com.bookdabang.tsh.persistence;

import java.util.List;

import com.bookdabang.common.domain.CartVO;
import com.bookdabang.tsh.domain.CartProdQttDTO;
import com.bookdabang.tsh.domain.CartSelectDTO;

public interface CartDAO {

	// 유저아이디로 장바구니 얻어오기
	public List<CartVO> getAllCart(CartSelectDTO dto) throws Exception;
	
	public CartVO selectCartByNo(int cartNo) throws Exception;

	public int updateCart(CartProdQttDTO dto) throws Exception;
	
	public int updateCartUserId(CartSelectDTO dto) throws Exception;
	
	public int deleteCart(int cartNo) throws Exception;
	
	public int insertCart(CartVO cart) throws Exception;

	public int countCart(CartSelectDTO dto) throws Exception;
	
	public int loginCart(CartSelectDTO dto) throws Exception;
}
