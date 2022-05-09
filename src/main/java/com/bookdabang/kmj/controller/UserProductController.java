package com.bookdabang.kmj.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.common.etc.IPCheck;
import com.bookdabang.kmj.service.UserProductService;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.kmj.domain.ReviewStatisticsVO;
import com.bookdabang.kmj.service.ReviewService;
 
@Controller
@RequestMapping("/product/*")
public class UserProductController {
	
	@Inject
	private UserProductService pService;
	
	@Inject
	private ReviewService rService;
	
	
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public void productList (Model model, @RequestParam(value="pageNo", required=false, defaultValue ="1") int pageNo,
			@RequestParam(value="searchWord", required=false, defaultValue ="") String searchWord) throws Exception {
		// 상품 리스트
		int cno = 0;
		System.out.println(pageNo + "번 상품 리스트 페이지, 검색어 : " + searchWord);
		
		Map<String, Object> map = pService.readAllProducts(cno,pageNo,0,searchWord);
		List<ProductVO> lst = (List<ProductVO>) map.get("productList");
		PagingInfo pi = (PagingInfo)map.get("pagingInfo");
		
		// 카테고리 리스트
		List<CategoryVO> lst2 = pService.readAllCategory(searchWord);
		
		model.addAttribute("productList", lst);
		model.addAttribute("pagingInfo", pi);
		model.addAttribute("categoryList", lst2);
	}
	
	@RequestMapping(value = "/list/{cno}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> productListByCategory (@PathVariable("cno") int cno,
			@RequestParam("pageNo") int pageNo, @RequestParam("sort") String so,
			@RequestParam(value="searchWord", required=false, defaultValue ="") String searchWord) {
		int sort = 0;
		if (so.equals("") || so != null) {
			sort = Integer.parseInt(so);
		}
		
		System.out.println("카데고리 번호 : " + cno + "인 상품들의 " + pageNo + "번 페이지 정렬방법" + sort);
		System.out.println("검색어 : " + searchWord);
		
		ResponseEntity<Map<String, Object>> result = null;
		
		try {
			Map<String, Object> map = pService.readAllProducts(cno,pageNo,sort,searchWord);
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
	public void productDetail (Model model , @RequestParam("no") int prodNo, HttpServletRequest request,
			@RequestParam(value="pageNo", required=false, defaultValue ="1") int pageNo) throws Exception {
		System.out.println(prodNo + "번 상품 상세페이지");
		
		// 조회수 증가
		String ipaddr = null;
		ipaddr = IPCheck.getIPAddr(request);
		pService.addProductView(prodNo,ipaddr);
		
		// 상품 상세정보
		ProductVO product = pService.readProduct(prodNo);
		
		// top10 상품들
		int cno = product.getCategory_code();
		List<ProductVO> lst = pService.readTopProducts(cno,"");
		
		// 카데고리 이름
		String categoryName = pService.getCategoryName(cno);
		
		// 해당 상품의 리뷰들(페이징,첨부파일 포함)
		Map<String, Object> resultMap = rService.readAllReview(prodNo,pageNo,1);
		List<ReviewVO> lst2 = (List<ReviewVO>) resultMap.get("reviewList");
		PagingInfo pi = (PagingInfo) resultMap.get("pagingInfo");
		List<AttachFileVO> lst3 = (List<AttachFileVO>) resultMap.get("fileList");
		
		// 리뷰 통계(등급별 개수,총개수,평균)
		ReviewStatisticsVO reviewStatistics = rService.getReviewStatistics(prodNo);
		
		model.addAttribute("product", product);
		model.addAttribute("topList", lst);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("reviewList", lst2);
		model.addAttribute("pagingInfo", pi);
		model.addAttribute("fileList", lst3);
		model.addAttribute("reviewStatistics", reviewStatistics);
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public ResponseEntity<List<ProductVO>> searchProduct(@RequestParam("searchWord") String searchWord) {
		System.out.println("검색어 : " + searchWord + " 자동완성리스트");
		ResponseEntity<List<ProductVO>> result = null;
		List<ProductVO> lst = null;
		try {
			lst = pService.readTopProducts(0,searchWord); 
			result = new ResponseEntity<List<ProductVO>>(lst, HttpStatus.OK);	
		} catch (Exception e) {
			result = new ResponseEntity<List<ProductVO>>(lst, HttpStatus.BAD_REQUEST);	
			e.printStackTrace();
		}
		
		return result;
	}
}
