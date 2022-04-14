package com.bookdabang.tsh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/cart/*")
public class CartController {
	
	@RequestMapping(value="/userCart",method = RequestMethod.GET)
	public void getCart() throws Exception{

	}
	

}
