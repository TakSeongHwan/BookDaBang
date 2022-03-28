package com.bookdabang.tsh.controller; 


import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.CartVO;
import com.bookdabang.tsh.domain.CartProdQttDTO;
import com.bookdabang.tsh.service.CartService;

@Controller
@RequestMapping("/cart")
public class CartController {
	
	@Inject
	public CartService service;
	
	@RequestMapping(value="/userCart",method = RequestMethod.POST)
	public void getCartById(@RequestParam(value = "userId")String userId,Model model) throws Exception{
		List<CartVO> cartLst = service.getCartByUserId(userId);
		model.addAttribute("cart", cartLst);
	}
	
	@RequestMapping(value="/updateCart",method = RequestMethod.POST)
	public ResponseEntity<String> updateCart(CartProdQttDTO dto) throws Exception {
		ResponseEntity<String> result = null;
		if(service.updateCart(dto)==1) {
			result = new ResponseEntity<String>("success",HttpStatus.OK);
		}else {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	@RequestMapping(value="/deleteCart", method = RequestMethod.POST)
	public ResponseEntity<String> deleteCart(int cartNo) throws Exception{
		ResponseEntity<String> result = null;
		if(service.deleteCart(cartNo)==1) {
			result = new ResponseEntity<String>("success",HttpStatus.OK);
		}else {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	
	public ResponseEntity<String> insertCart(CartVO cart) throws Exception{
		ResponseEntity<String> result = null;
		if(service.insertCart(cart)==1) {
			result = new ResponseEntity<String>("success",HttpStatus.OK);
		}else {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
		}
		return result;
	}
}
