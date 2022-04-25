package com.bookdabang.tsh.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.AddressVO;
import com.bookdabang.common.domain.CartVO;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.ProdOrder;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.service.ProductService;
import com.bookdabang.kmj.service.UserProductService;
import com.bookdabang.ljs.service.LoginService;
import com.bookdabang.tsh.domain.CartSelectDTO;
import com.bookdabang.tsh.domain.CartViewDTO;
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
	@Inject
	private LoginService lService;
	@Inject
	private UserProductService pService;

	@RequestMapping(value = "/checkOut")
	public String checkout(HttpSession ses, Model model) throws Exception {
		System.out.println("GET방식 checkOut");
		CartSelectDTO dto = new CartSelectDTO();
		MemberVO loginMember = lService.findLoginSess((String) ses.getAttribute("sessionId"));
		String userId = null;
		String ipaddr = null;
		if (loginMember != null) {
			userId = loginMember.getUserId();
		} else {
			ipaddr = (String) ses.getAttribute("ipAddr");
		}
		dto.setUserId(userId);
		dto.setIpaddr(ipaddr);
		int cntCart = cService.countCart(dto);
		System.out.println(cntCart);
		if(cntCart < 1) {
			return "redirect:/?cart=null";
		}
		List<Integer> cartNo = cService.allCartNo(dto);
//		List<CartVO> cartLst = cService.selectCartByNo(cartNo);
//		List<CartViewDTO> cartView = new ArrayList<CartViewDTO>();
//		for (CartVO cart : cartLst) {
//			ProductVO product = pService.readProduct(cart.getProductNo());
//			CartViewDTO cv = new CartViewDTO(product.getProduct_no(), cart.getCartNo(), product.getTitle(),
//					product.getCover(), product.getSell_price(), cart.getProductQtt(), product.getStock());
//			cartView.add(cv);
//		}
		model.addAttribute("cartLst", cartNo);
		return "/order/checkOut";
	}
	
	@RequestMapping(value = "/checkOut", method = RequestMethod.POST)
	public void postCheckout(@ModelAttribute ArrayList<CartViewDTO> dto,HttpServletRequest req, HttpSession ses,Model model) throws Exception{
		System.out.println(dto);
		String[] cartNo = req.getParameterValues("cartNo");
		String[] cover = req.getParameterValues("cover");
		String[] product_no = req.getParameterValues("product_no");
		String[] productQtt = req.getParameterValues("productQtt");
		String[] sell_price = req.getParameterValues("sell_price");
		String[] stock = req.getParameterValues("stock");
		String[] title = req.getParameterValues("title");
		String[] checkCart = req.getParameterValues("checkCart");
		List<Integer> cartLst = new ArrayList<Integer>();
		for(String cart : checkCart) {
			cartLst.add(Integer.parseInt(cart));
		}
		model.addAttribute("cartLst", cartLst);
		
	}
	
	@RequestMapping(value="/getOrder",method = RequestMethod.POST)
	public void selectOrder(OrderDTO odto, Model model) throws Exception {
		service.selectOrder(odto);
	}
	
	@RequestMapping(value="/insertOrder",method = RequestMethod.POST)
	public String insertOrder(String sessionId,AddressVO addrvo ,OrderInputDTO dto,String deliverymessage) throws Exception {
		System.out.println(deliverymessage);
		System.out.println(dto);
		System.out.println(sessionId);
		addrvo.setUserId(lService.findLoginSess(sessionId).getUserId());
		addrvo.setAddress_no(dto.getAddressNo());
		System.out.println(addrvo);
		String orderPwd = dto.getOrderPwd();
		System.out.println(orderPwd);
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
