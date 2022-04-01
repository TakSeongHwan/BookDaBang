package com.bookdabang.tsh.service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bookdabang.common.domain.AddressVO;
import com.bookdabang.common.domain.CartVO;
import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.common.domain.Product;
import com.bookdabang.kmj.persistence.ProductDAO;
import com.bookdabang.tsh.domain.CartViewDTO;
import com.bookdabang.tsh.domain.OrderDTO;
import com.bookdabang.tsh.domain.OrderInputDTO;
import com.bookdabang.tsh.persistence.AddressDAO;
import com.bookdabang.tsh.persistence.CartDAO;
import com.bookdabang.tsh.persistence.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Inject
	private OrderDAO odao;
	@Inject
	private CartDAO cdao;
	@Inject
	private ProductDAO pdao;
	@Inject
	public AddressDAO adao;

	@Override
	public List<ProdOrder> selectOrder(OrderDTO odto) throws Exception {
		// TODO Auto-generated method stub
		return odao.selectOrder(odto);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public String insertOrder(AddressVO addrvo, List<String> cartNo, String orderPwd) throws Exception { 
		String orderBundle = UUID.randomUUID().toString().split("-")[4];
		int address_no = 0;
		address_no = adao.nextAddressNo();
		adao.insertAddress(addrvo);
		for(String s : cartNo) {
			ProdOrder ovo = new ProdOrder();
			int cartno = Integer.parseInt(s);
			CartVO cvo = cdao.selectCartByNo(cartno);
			ovo.setUserId(addrvo.getUserId());
			ovo.setProductNo(cvo.getProductNo());
			ovo.setAddressNo(address_no);
			Product pvo = pdao.selectProduct(cvo.getProductNo());
			ovo.setPrice(pvo.getSell_price()*cvo.getProductQtt());
			ovo.setProductQtt(cvo.getProductQtt());
			if(orderPwd!=null) {
				ovo.setOrderPwd(orderPwd);
			}
//			cdao.deleteCart(cartno);
			ovo.setOrderBundle(orderBundle);
			System.out.println(ovo);
			odao.insertOrder(ovo);
		}
		return orderBundle;
	}

	@Override
	public int updateOrderCofirm(int orderNo) throws Exception {
		return odao.updateOrderCofirm(orderNo);
	}
	
}
