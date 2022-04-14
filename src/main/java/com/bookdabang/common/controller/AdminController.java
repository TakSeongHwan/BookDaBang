package com.bookdabang.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/")
public class AdminController {
	
	@RequestMapping("/adminOrder/orderListAll")
	public void listAll(){
		
	}
}
