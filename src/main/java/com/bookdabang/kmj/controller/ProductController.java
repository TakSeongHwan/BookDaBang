package com.bookdabang.kmj.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.Product;
import com.bookdabang.kmj.service.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Inject
	private ProductService service;
	
	
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public void productList (Model model) throws Exception {
		System.out.println("상품 리스트 페이지");
		
		List<Product> lst = service.readAllProducts();
		
		model.addAttribute("productList", lst);
	}
	
	@RequestMapping(value = "/detail", method=RequestMethod.GET)
	public void productDetail (Model model , @RequestParam("no") String no) throws Exception {
		int prodNo = Integer.parseInt(no);
		
		System.out.println(prodNo + "번 상품 상세페이지");
		
		Product product = service.readProduct(prodNo);
		
		model.addAttribute("product", product);
	}
}
