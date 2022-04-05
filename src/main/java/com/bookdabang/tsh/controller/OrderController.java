package com.bookdabang.tsh.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.AddressVO;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.tsh.domain.CartSelectDTO;
import com.bookdabang.tsh.domain.OrderDTO;
import com.bookdabang.tsh.domain.OrderInputDTO;
import com.bookdabang.tsh.service.AddressService;
import com.bookdabang.tsh.service.CartService;
import com.bookdabang.tsh.service.OrderService;

@Controller
@RequestMapping("/order/*")
public class OrderController {

	@Inject
	private OrderService service;
	@Inject
	private CartService cService;
	
	@RequestMapping(value = "/checkOut")
	public String checkout(HttpSession ses) throws Exception {
		System.out.println("GET방식 checkOut");
		CartSelectDTO dto = new CartSelectDTO();
		MemberVO loginMember = (MemberVO) ses.getAttribute("loginMember");
		String userId = null;
		String ipaddr = null;
		if (loginMember != null) {
			userId = loginMember.getUserId();
		} else {
			ipaddr = "211.197.18.247";
		}
		dto.setUserId(userId);
		dto.setIpaddr(ipaddr);
		int cntCart = cService.countCart(dto);
		System.out.println(cntCart);
		if(cntCart < 1) {
			return "redirect:/?cart=null";
		}
		return "/order/checkOut";
	}
	
	@RequestMapping(value = "/checkOut", method = RequestMethod.POST)
	public void postCheckout(@RequestParam ArrayList<Integer> cartNo, HttpSession ses,Model model) throws Exception{
		System.out.println("cartNo"+cartNo);
		model.addAttribute("cartsNo", cartNo);
	}
	
	@RequestMapping(value="/getOrder",method = RequestMethod.POST)
	public void selectOrder(OrderDTO odto, Model model) throws Exception {
		service.selectOrder(odto);
	}
	
	@RequestMapping(value="/insertOrder",method = RequestMethod.POST)
	public String insertOrder(AddressVO addrvo ,OrderInputDTO dto,String deliverymessage) throws Exception {
		System.out.println(deliverymessage);
		System.out.println(dto);
		addrvo.setAddress_no(dto.getAddressNo());
		System.out.println(addrvo);
		String orderPwd = dto.getOrderPwd();
		List<String> cartNo = new ArrayList<String>();
		String[] cartsNo = dto.getCartsNo().split(",");
		for(int i = 0; i < cartsNo.length; i++) {
			cartNo.add(cartsNo[i]);
		}
		System.out.println(cartNo);
		String orderBundle = service.insertOrder(addrvo,cartNo,orderPwd);
		
		return "redirect:/?orderBundle="+orderBundle;
	}
	
	@RequestMapping(value="/confirmOrder",method = RequestMethod.POST)
	public void confirmOrder(int orderNo) throws Exception {
		service.updateOrderCofirm(orderNo);
	}
}
