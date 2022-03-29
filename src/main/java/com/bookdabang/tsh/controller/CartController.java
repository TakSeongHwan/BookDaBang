package com.bookdabang.tsh.controller; 


import java.util.List;

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
import com.bookdabang.tsh.domain.CartProdQttDTO;
import com.bookdabang.tsh.domain.CartSelectDTO;
import com.bookdabang.tsh.service.CartService;


@Controller
@RequestMapping("/cart/*")
public class CartController {
	
	@Inject
	public CartService service;
	
	@RequestMapping(value="/userCart",method = RequestMethod.GET)
	public void getCartById(Model model,HttpSession ses) throws Exception{
		CartSelectDTO dto = new CartSelectDTO();
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
		List<CartVO> cartLst = service.getAllCart(dto);
		System.out.println("getCartById : "+cartLst);
		model.addAttribute("cart",cartLst);
	}
	
	@RequestMapping(value="/updateCart",method = RequestMethod.POST)
	public ResponseEntity<String> updateCart(CartProdQttDTO dto) throws Exception {
		ResponseEntity<String> result = null;
		System.out.println("updateCart 실행" );
		if(service.updateCart(dto)==1) {
			result = new ResponseEntity<String>("success",HttpStatus.OK);
		}else {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	
	
	@RequestMapping(value="/deleteCart", method = RequestMethod.POST)
	public ResponseEntity<String> deleteCart(@PathVariable("rno") int cartNo) throws Exception{
		ResponseEntity<String> result = null;
		if(service.deleteCart(cartNo)==1) {
			result = new ResponseEntity<String>("success",HttpStatus.OK);
		}else {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	
	@RequestMapping(value="/insertCart", method = RequestMethod.POST)
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
