package com.bookdabang.tsh.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bookdabang.common.domain.AddressVO;
import com.bookdabang.common.domain.CartVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.persistence.ProductDAO;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.tsh.domain.CartViewDTO;
import com.bookdabang.tsh.domain.ManageOrderDTO;
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
			ProductVO pvo = pdao.selectProduct(cvo.getProductNo());
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

	@Override
	public Map<String, Object> selectAllOrder(SearchCriteria sc, int pageno) throws Exception {
		PagingInfo pi =pagingProcess(pageno, sc);
		Map<String, Object> map  = new HashMap<String, Object>();
		List<ProdOrder> orderLst = odao.orderView(sc,pi);
		List<ManageOrderDTO> dto = new ArrayList<ManageOrderDTO>();
		for(ProdOrder o : orderLst) {
			ProductVO p = pdao.selectProduct(o.getProductNo());
			dto.add(new ManageOrderDTO(o.getOrderNo(), o.getUserId(), o.getProductNo(), o.getProductQtt(), o.getOrderState_code(), o.getOrderDate(), o.getAddressNo(), o.getReleaseDate(), o.getConfirm(), o.getPrice(), o.getOrderPwd(), o.getOrderBundle(), p.getTitle(), p.getCover()));
		} 
		map.put("ManageOrder", dto);
		map.put("pagingInfo", pi);
		return map;
	}
	
	private PagingInfo pagingProcess(int pageNo, SearchCriteria sc) throws Exception {
		PagingInfo pi = new PagingInfo();
		
		pi.setPostPerPage(5);
		pi.setPageCntPerBlock(5);
		
		int totalPostCnt = odao.allOrderCnt(sc);
		pi.setTotalPostCnt(totalPostCnt);
		pi.setTotalPage(pi.getTotalPostCnt());
		pi.setStartNum(pageNo);
		pi.setTotalPagingBlock(pi.getTotalPage());
		pi.setCurrentPagingBlock(pageNo);
		pi.setStartNoOfCurPagingBlock(pi.getCurrentPagingBlock());
		pi.setEndNoOfCurPagingBlock(pi.getStartNoOfCurPagingBlock());
		
		return pi;
		
	}

	
}
