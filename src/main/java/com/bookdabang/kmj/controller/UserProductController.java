package com.bookdabang.kmj.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.domain.Review;
import com.bookdabang.common.domain.ReviewComment;
import com.bookdabang.kmj.service.UserProductService;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.kmj.service.ReviewService;
 
@Controller
@RequestMapping("/product/*")
public class UserProductController {
	
	@Inject
	private UserProductService pService;
	
	@Inject
	private ReviewService rService;
	
	
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public void productList (Model model, @RequestParam(value="pageNo", required=false, defaultValue ="1") String tmp) throws Exception {
		// 상품 리스트
		int cno = 0;
		int pageNo = 1;
		if (tmp.equals("") || tmp != null) {
			pageNo = Integer.parseInt(tmp);
		}
		
		System.out.println(pageNo + "번 상품 리스트 페이지");
		
		Map<String, Object> map = pService.readAllProducts(cno,pageNo,0);
		List<ProductVO> lst = (List<ProductVO>) map.get("productList"); // 업캐스팅해서 들어갔으니 다운캐스팅으로 빼줘야함
		PagingInfo pi = (PagingInfo)map.get("pagingInfo");
		
		// 카테고리 리스트
		List<CategoryVO> lst2 = pService.readAllCategory();
		
		model.addAttribute("productList", lst);
		model.addAttribute("pagingInfo", pi);
		model.addAttribute("categoryList", lst2);	
	}
	
	@RequestMapping(value = "/list/{cno}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> productListByCategory (@PathVariable("cno") int cno,
			@RequestParam(value="pageNo", required=false, defaultValue ="1") String tmp,
			@RequestParam("sort") String so) {
		
		int pageNo = 1;
		if (tmp.equals("") || tmp != null) {
			pageNo = Integer.parseInt(tmp);
		}
		
		int sort = 0;
		if (so.equals("") || so != null) {
			sort = Integer.parseInt(so);
		}
		
		System.out.println("카데고리 번호 : " + cno + "인 상품들의 " + pageNo + "번 페이지 정렬방법" + sort);
		
		ResponseEntity<Map<String, Object>> result = null;
		
		try {
			Map<String, Object> map = pService.readAllProducts(cno,pageNo,sort);
			List<ProductVO> lst = (List<ProductVO>) map.get("productList");
			if(lst.size() < 1) {
				lst = null;
				map.put("productList", lst);
			}
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);	
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);	
		}
		
		return result;
	}
	
	@RequestMapping(value = "/detail", method=RequestMethod.GET)
	public void productDetail (Model model , @RequestParam("no") String no) throws Exception {
		int prodNo = Integer.parseInt(no);
		
		System.out.println(prodNo + "번 상품 상세페이지");
		
		// 상품 상세정보
		ProductVO product = pService.readProduct(prodNo);
		
		// top10 상품들
		int category = product.getCategory_code();
		List<ProductVO> lst = pService.readTopProducts(category);
		
		// 해당 상품의 리뷰들
		List<Review> lst2 = rService.readAllReview(prodNo);
		
		model.addAttribute("product", product);
		model.addAttribute("topList", lst);
		model.addAttribute("reviewList", lst2);
		
	}
	
	
}
