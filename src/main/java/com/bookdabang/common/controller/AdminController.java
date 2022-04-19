package com.bookdabang.common.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bookdabang.lhs.domain.AdminProduct;
import com.bookdabang.lhs.service.ChartService;

@Controller
@RequestMapping("/admin/")
public class AdminController {
	
	@Inject
	ChartService cService;
	
	@RequestMapping("/adminOrder/orderListAll")
	public void listAll(){
		
	}
	@RequestMapping("adminStatistics/adminProductStatistics")
	public void productStatistics(Model m) {
		List<AdminProduct> list = new ArrayList<AdminProduct>();
		try {
			list = cService.getAdminProduct();
			m.addAttribute("adminProduct",list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
