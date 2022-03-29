package com.bookdabang.tsh.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bookdabang.tsh.service.RefundService;

@Controller
@RequestMapping("/refund/*")
public class RefundController {

	@Inject
	private RefundService service;
	
	@RequestMapping("/allRefund")
	public void allRefund(Model model) throws Exception {
		model.addAttribute("refund",service.selectAllRefund()); 
	}

}
