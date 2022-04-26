package com.bookdabang.tsh.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bookdabang.common.domain.CartVO;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.persistence.ProductDAO;
import com.bookdabang.tsh.domain.CartProdQttDTO;
import com.bookdabang.tsh.domain.CartSelectDTO;
import com.bookdabang.tsh.domain.CartViewDTO;
import com.bookdabang.tsh.persistence.CartDAO;

@Service
public class CartServiceImpl implements CartService {

	@Inject
	private CartDAO dao;
	@Inject
	private ProductDAO pdao;
	
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
		CartVO existingCart = dao.selectProdCart(cart);
		System.out.println(existingCart);
		System.out.println(cart);
		int result = 0;
		if(existingCart != null) {
			CartProdQttDTO dto = new CartProdQttDTO(existingCart.getCartNo(), existingCart.getProductQtt()+cart.getProductQtt());
			result = dao.updateCart(dto);
		}else {
			cart.setCartNo(dao.nextCartNo());
			result = dao.insertCart(cart);
			
		}
		return result;
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
	@Transactional(rollbackFor = Exception.class)
	public int loginCart(CartSelectDTO dto) throws Exception {
		CartSelectDTO checkCart = new CartSelectDTO();
		checkCart.setIpaddr(dto.getIpaddr());
		List<CartVO> ipLst = dao.getAllCart(checkCart);
		List<CartVO> idLst = dao.getAllCart(dto);
		for(CartVO ipCart : ipLst) {
			for(CartVO idCart : idLst) {
				if(ipCart.getProductNo() == idCart.getProductNo()) {
					CartProdQttDTO cd = new CartProdQttDTO(idCart.getCartNo(), idCart.getProductQtt()+ipCart.getProductQtt());
					dao.updateCart(cd);
					dao.deleteCart(ipCart.getCartNo());
				}
			}
		}
		return dao.loginCart(dto);
	}

	@Override
	public List<CartViewDTO> getCartView(List<CartVO> cartLst) throws Exception {
		List<CartViewDTO> cartView = new ArrayList<CartViewDTO>();
		for (CartVO cart : cartLst) {
			ProductVO product = pdao.selectProduct(cart.getProductNo());
			CartViewDTO cv = new CartViewDTO(product.getProduct_no(), cart.getCartNo(), product.getTitle(),
					product.getCover(), product.getSell_price(), cart.getProductQtt(), product.getStock());
			cartView.add(cv);
		}
		return cartView;
	}

	@Override
	public List<Integer> allCartNo(CartSelectDTO dto) throws Exception {
		return dao.allCartNo(dto);
	}


}
