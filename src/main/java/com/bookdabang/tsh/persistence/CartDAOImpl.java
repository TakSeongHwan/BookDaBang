package com.bookdabang.tsh.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.CartVO;
import com.bookdabang.tsh.domain.CartProdQttDTO;
import com.bookdabang.tsh.domain.CartSelectDTO;


@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	private SqlSession ses;
	
	private String ns = "com.bookdabang.mapper.CartMapper";

	@Override
	public List<CartVO> getAllCart(CartSelectDTO dto) throws Exception {
		return ses.selectList(ns+".getAllCart", dto);
	}
	
	@Override
	public int updateCart(CartProdQttDTO dto) throws Exception{
		return ses.update(ns+".updateCartProdQtt", dto);
	}
	
	@Override
	public int updateCartUserId(CartSelectDTO dto) throws Exception {
		return ses.update(ns+".updateCartUserId", dto);
	}

	@Override
	public int deleteCart(int cartNo) throws Exception {
		return ses.delete(ns+".deleteCart",cartNo);
	}

	@Override
	public int insertCart(CartVO cart) throws Exception {
		return ses.insert(ns+".insertCart", cart);
	}

	@Override
	public CartVO selectCartByNo(int cartNo) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".selectCartByNo", cartNo);
	}

	@Override
	public int countCart(CartSelectDTO dto) throws Exception {
		return ses.selectOne(ns+".countCart",dto);
	}
	
	
}
