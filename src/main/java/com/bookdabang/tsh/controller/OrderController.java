package com.bookdabang.tsh.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
import com.bookdabang.tsh.domain.OrderViewDTO;
import com.bookdabang.tsh.service.AddressService;
import com.bookdabang.tsh.service.CartService;
import com.bookdabang.tsh.service.OrderService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mysql.cj.xdevapi.JsonArray;

@Controller
@RequestMapping("/order/*")
public class OrderController {

	@Inject
	private OrderService service;
	@Inject
	private CartService cService;
	@Inject
	private LoginService lService;

	// 모든 장바구니 구매
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
		if (cntCart < 1) {
			return "redirect:/?cart=null";
		}
		List<Integer> cartNo = cService.allCartNo(dto);
		model.addAttribute("cartLst", cartNo);
		return "/order/checkOut";
	}

	// 선택한 장바구니 구매
	@RequestMapping(value = "/checkOut", method = RequestMethod.POST)
	public void postCheckout(@ModelAttribute ArrayList<CartViewDTO> dto, HttpServletRequest req, HttpSession ses,
			Model model) throws Exception {
		String[] checkCart = req.getParameterValues("checkCart");
		List<Integer> cartLst = new ArrayList<Integer>();
		for (String cart : checkCart) {
			cartLst.add(Integer.parseInt(cart));
		}
		model.addAttribute("cartLst", cartLst);

	}

	@RequestMapping(value = "/getOrder", method = RequestMethod.POST)
	public void selectOrder(OrderDTO odto, Model model) throws Exception {
		service.selectOrder(odto);
	}

	// 주문 저장
	@RequestMapping(value = "/insertOrder", method = RequestMethod.POST)
	public String insertOrder(String sessionId, AddressVO addrvo, OrderInputDTO dto, String deliverymessage)
			throws Exception {
		MemberVO mem = lService.findLoginSess(sessionId);
		if (mem != null) {
			addrvo.setUserId(mem.getUserId());
		} else {
			addrvo.setUserId(null);
		}
		addrvo.setAddress_no(dto.getAddressNo());
		String orderPwd = dto.getOrderPwd();
		List<String> cartNo = new ArrayList<String>();
		String[] cartsNo = dto.getCartsNo().split(",");
		for (int i = 0; i < cartsNo.length; i++) {
			cartNo.add(cartsNo[i]);
		}
		System.out.println(cartNo);
		String orderBundle = service.insertOrder(addrvo, cartNo, orderPwd);

		return "redirect:/?orderBundle=" + orderBundle;
	}

	// 주문 구매 확인
	@RequestMapping(value = "/confirmOrder", method = RequestMethod.POST)
	public ResponseEntity<String> confirmOrder(int orderNo) {
		ResponseEntity<String> result = null;
		try {
			if (service.updateOrderCofirm(orderNo, "Y") == 1) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity<String>("fail", HttpStatus.OK);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return result;
	}

	// 회원 주문 조회
	@RequestMapping(value = "/orderstatus/{pageNo}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> orderStatus(String sessionId, @PathVariable("pageNo") int pageno) {
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = null;
		try {
			map = service.orderStatus(sessionId, pageno);
			if (map.isEmpty()) {
				result = new ResponseEntity<>(null, HttpStatus.OK);
			} else {
				result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		System.out.println(sessionId);
		return result;
	}

	// 비회원 주문 조회
	@RequestMapping(value = "/orderCheck", method = RequestMethod.GET)
	public ResponseEntity<List<OrderViewDTO>> orderCheck(String orderBundle, String orderPwd) {
		ResponseEntity<List<OrderViewDTO>> result = null;
		ProdOrder po = new ProdOrder();
		po.setOrderBundle(orderBundle);
		po.setOrderPwd(orderPwd);
		System.out.println(po);
		try {
			List<OrderViewDTO> lst = service.orderCheck(po);
			if (lst.isEmpty()) {
				result = new ResponseEntity<>(null, HttpStatus.OK);
			} else {
				result = new ResponseEntity<List<OrderViewDTO>>(lst, HttpStatus.OK);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		System.out.println(result);
		return result;
	}

	@RequestMapping(value = "/orderCheck", method = RequestMethod.POST)
	public void orderCheck(Model m, String orderBundle, String orderPwd) {
		m.addAttribute("orderBundle",orderBundle);
		m.addAttribute("orderPwd", orderPwd);
	}
	
}
