package com.bookdabang.tsh.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.tsh.domain.OrderDTO;
import com.bookdabang.tsh.service.OrderService;

@Controller
@RequestMapping("/order/*")
public class OrderController {

	@Inject
	private OrderService service;
	
	@RequestMapping(value = "/checkOut")
	public void checkout() {
		
	}
	
	@RequestMapping(value="/getOrder",method = RequestMethod.POST)
	public void selectOrder(OrderDTO odto, Model model) throws Exception {
		service.selectOrder(odto);
	}
	
	@RequestMapping(value="/insertOrder",method = RequestMethod.POST)
	public String insertOrder(ProdOrder order) throws Exception {
		service.insertOrder(order);
		return "redirect:/";
	}
	
	@RequestMapping(value="/confirmOrder",method = RequestMethod.POST)
	public void confirmOrder(int orderNo) throws Exception {
		service.updateOrderCofirm(orderNo);
	}
}
