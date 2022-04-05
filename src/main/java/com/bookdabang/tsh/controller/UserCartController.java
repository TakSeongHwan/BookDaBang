package com.bookdabang.tsh.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpRequest;
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
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.kmj.service.UserProductService;
import com.bookdabang.ljs.service.LoginService;
import com.bookdabang.tsh.domain.CartProdQttDTO;
import com.bookdabang.tsh.domain.CartSelectDTO;
import com.bookdabang.tsh.domain.CartViewDTO;
import com.bookdabang.tsh.etc.StringToArray;
import com.bookdabang.tsh.service.CartService;

@RestController
@RequestMapping("/userCart/*")
public class UserCartController {

	@Inject
	public CartService cService;
	@Inject
	public UserProductService pService;
	@Inject
	public LoginService lService;
	
	@RequestMapping(value="/count", method = RequestMethod.GET)
	public ResponseEntity<Integer> countCart(HttpSession ses){
		ResponseEntity<Integer> result = null;
		CartSelectDTO dto = new CartSelectDTO();
		try {
			String userId = null;
			String ipaddr = null;
			MemberVO loginMember = lService.findLoginSess((String)ses.getAttribute("sessionId"));
			if (loginMember != null) {
				userId = loginMember.getUserId();
			} else {
				ipaddr = (String)ses.getAttribute("ipAddr");
			}
			dto.setUserId(userId);
			dto.setIpaddr(ipaddr);
			int cntCart = cService.countCart(dto);
			result = new ResponseEntity<Integer>(cntCart,HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	@RequestMapping(value = "/cartByNo", method = RequestMethod.POST)
	public ResponseEntity<List<CartViewDTO>> getCartByCartNo(@RequestBody List<Object> cartsNo) throws Exception {
		ResponseEntity<List<CartViewDTO>> result = null;
		System.out.println("cartsNo  = " +cartsNo);
		List<CartVO> cartLst =  cService.selectCartByNo(null);
		List<CartViewDTO> cartView = new ArrayList<CartViewDTO>();
		for (CartVO cart : cartLst) {
			ProductVO product = pService.readProduct(cart.getProductNo());
			CartViewDTO cv = new CartViewDTO(product.getProduct_no(), cart.getCartNo(), product.getTitle(),
					product.getCover(), product.getSell_price(), cart.getProductQtt(),product.getStock());
			cartView.add(cv);
		}
		if(cartLst == null) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}else {
			result = new ResponseEntity<List<CartViewDTO>>(cartView, HttpStatus.OK);
		}
		return result;
	}

	@RequestMapping(value = "/all", method = RequestMethod.GET)
	public ResponseEntity<List<CartViewDTO>> getCartById(HttpSession ses, String cartsNo) throws Exception {
		ResponseEntity<List<CartViewDTO>> result = null;
		try {
			System.out.println(cartsNo);
			List<CartVO> cartLst = null;
			if (cartsNo == null) {
				CartSelectDTO dto = new CartSelectDTO();
				MemberVO loginMember =  lService.findLoginSess((String) ses.getAttribute("sessionId")); 
				String userId = null;
				String ipaddr = null;
				if (loginMember != null) {
					userId = loginMember.getUserId();
				} else {
					ipaddr = (String) ses.getAttribute("ipAddr");
				}
				dto.setUserId(userId);
				dto.setIpaddr(ipaddr);
				cartLst = cService.getAllCart(dto);
				
			} else {
				
				String[] cNos = cartsNo.split(",");
				List<Integer> cartNo = new ArrayList<Integer>();
				for (String no : cNos) {
					cartNo.add(Integer.parseInt(no));
				}
				cartLst = cService.selectCartByNo(cartNo);
			}
			List<CartViewDTO> cartView = new ArrayList<CartViewDTO>();
			for (CartVO cart : cartLst) {
				ProductVO product = pService.readProduct(cart.getProductNo());
				CartViewDTO cv = new CartViewDTO(product.getProduct_no(), cart.getCartNo(), product.getTitle(),
						product.getCover(), product.getSell_price(), cart.getProductQtt(),product.getStock());
				cartView.add(cv);
			}
			result = new ResponseEntity<List<CartViewDTO>>(cartView, HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return result;
	}

	@RequestMapping(value = "/{cartNo}", method = RequestMethod.PUT)
	public ResponseEntity<String> updateCart(@RequestBody CartProdQttDTO dto) {
		ResponseEntity<String> result = null;
		System.out.println("updateCart 실행");
		try {
			if (cService.updateCart(dto) == 1) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return result;
	}

	@RequestMapping(value = "/{cartNo}", method = RequestMethod.DELETE)
	public ResponseEntity<String> deleteCart(@PathVariable("rno") int cartNo) {
		ResponseEntity<String> result = null;
		try {
			if (cService.deleteCart(cartNo) == 1) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return result;
	}

	@RequestMapping(value = "/addCart", method = RequestMethod.POST)
	public ResponseEntity<String> insertCart(@RequestBody CartVO cart) {
		ResponseEntity<String> result = null;
		try {
			if (cService.insertCart(cart) == 1) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	
}
