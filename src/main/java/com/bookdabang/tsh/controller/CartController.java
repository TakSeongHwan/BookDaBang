package com.bookdabang.tsh.controller; 


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bookdabang.common.domain.CartVO;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.Product;
import com.bookdabang.kmj.service.ProductService;
import com.bookdabang.tsh.domain.CartProdQttDTO;
import com.bookdabang.tsh.domain.CartSelectDTO;
import com.bookdabang.tsh.domain.CartViewDTO;
import com.bookdabang.tsh.service.CartService;


@Controller
@RequestMapping("/cart/*")
public class CartController {
	
	@Inject
	public CartService cService;
	@Inject
	public ProductService pService;
	
	@RequestMapping(value="/userCart",method = RequestMethod.GET)
	public void getCart() throws Exception{

	}
	
	@RequestMapping(value="/cartInfo",method = RequestMethod.GET)
	public ResponseEntity<List<CartViewDTO>> getCartById(HttpSession ses) throws Exception{
		CartSelectDTO dto = new CartSelectDTO();
		ResponseEntity<List<CartViewDTO>> result = null;
		MemberVO loginMember = (MemberVO) ses.getAttribute("loginMember"); 
		String userId = null;
		String ipaddr = null;
		if(loginMember!=null) {
			userId = loginMember.getUserId();
		}else {
			ipaddr = "211.197.18.247";
		}
		dto.setUserId(userId);
		dto.setIpaddr(ipaddr);
		List<CartVO> cartLst = cService.getAllCart(dto);
		List<CartViewDTO> cartView = new ArrayList<CartViewDTO>(); 
		for(CartVO cart : cartLst) {
			Product product =  pService.readProduct(cart.getProductNo());
			CartViewDTO cv = new CartViewDTO(product.getProduct_no(), cart.getCartNo(), product.getTitle(),product.getCover(), product.getSell_price(), cart.getProductQtt());
			cartView.add(cv);
		}
		result = new ResponseEntity<List<CartViewDTO>>(cartView,HttpStatus.OK);
		return result;
	}
	
	@RequestMapping(value="/updateCart",method = RequestMethod.POST)
	public ResponseEntity<String> updateCart(CartProdQttDTO dto) throws Exception {
		ResponseEntity<String> result = null;
		System.out.println("updateCart 실행" );
		if(cService.updateCart(dto)==1) {
			result = new ResponseEntity<String>("success",HttpStatus.OK);
		}else {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	
	
	@RequestMapping(value="/deleteCart", method = RequestMethod.POST)
	public ResponseEntity<String> deleteCart(@PathVariable("rno") int cartNo) throws Exception{
		ResponseEntity<String> result = null;
		if(cService.deleteCart(cartNo)==1) {
			result = new ResponseEntity<String>("success",HttpStatus.OK);
		}else {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	
	@RequestMapping(value="/insertCart", method = RequestMethod.POST)
	public ResponseEntity<String> insertCart(CartVO cart) throws Exception{
		ResponseEntity<String> result = null;
		if(cService.insertCart(cart)==1) {
			result = new ResponseEntity<String>("success",HttpStatus.OK);
		}else {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
		}
		return result;
	}
}
