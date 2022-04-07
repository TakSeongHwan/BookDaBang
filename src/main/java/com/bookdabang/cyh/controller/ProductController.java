package com.bookdabang.cyh.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.cyh.service.ProductService;


@Controller
@RequestMapping(value = "/prodManager/*")
public class ProductController {
	
	@Inject 
	private ProductService service;
	
	@RequestMapping(value = "/listAll", method=RequestMethod.GET)
	public void listAll(Model model) throws Exception { 
		List<CategoryVO> categoryLst = service.getCategory();
		model.addAttribute("category",categoryLst);
		
		
	}
	
	@RequestMapping(value = "/addProduct", method=RequestMethod.GET)
	public void addProduct(Model model) throws Exception { 
		List<CategoryVO> categoryLst = service.getCategory();
		model.addAttribute("category",categoryLst);
		
		
	}
	
	
	
}
