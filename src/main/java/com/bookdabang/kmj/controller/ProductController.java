package com.bookdabang.kmj.controller;

import java.util.List;

import javax.inject.Inject;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.Product;
import com.bookdabang.common.domain.Review;
import com.bookdabang.kmj.service.ProductService;
import com.bookdabang.kmj.service.ReviewService;
 
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Inject
	private ProductService pService;
	
	@Inject
	private ReviewService rService;
	
	
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public void productList (Model model) throws Exception {
		System.out.println("상품 리스트 페이지");
		
		// 상품 리스트
		List<Product> lst = pService.readAllProducts();
		
		// 카테고리 리스트
		List<CategoryVO> lst2 = pService.readAllCategory();
		
		model.addAttribute("productList", lst);
		model.addAttribute("categoryList", lst2);	
	}
	
	@RequestMapping(value = "/detail", method=RequestMethod.GET)
	public void productDetail (Model model , @RequestParam("no") String no) throws Exception {
		int prodNo = Integer.parseInt(no);
		
		System.out.println(prodNo + "번 상품 상세페이지");
		
		// 상품 상세정보
		Product product = pService.readProduct(prodNo);
		
		// top10 상품들
		int category = product.getCategory_code();
		List<Product> lst = pService.readTopProducts(category);
		
		// 해당 상품의 리뷰들
		List<Review> lst2 = rService.readAllReview(prodNo);
		
		model.addAttribute("product", product);
		model.addAttribute("topList", lst);
		model.addAttribute("reviewList", lst2);
		
	}
	
	
}
