package com.bookdabang.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.kmj.service.ReviewService;
import com.bookdabang.kmj.service.UserProductService;

import com.bookdabang.lhs.domain.AdminPagingInfo;
import com.bookdabang.lhs.domain.AdminProduct;
import com.bookdabang.lhs.service.ChartService;
import com.bookdabang.ljs.service.LoginService;

@Controller
@RequestMapping("/admin/")
public class AdminController {
	
	@Inject
	ChartService cService;
	@Inject
	LoginService lService;
	
	@Inject
	private ReviewService rService;
	
	@Inject
	private UserProductService pService;
	
	@RequestMapping("/adminOrder/orderListAll")
	public void listAll(){
		
	}
	@RequestMapping("adminStatistics/adminProductStatistics")
	public void productStatistics(Model m, @RequestParam(value="pageNo",required=false, defaultValue="1") String currPg, 
			@RequestParam(value="sortType",required=false, defaultValue="product_no") String sortType, @ModelAttribute BoardSearch bs) {
		Map<String,Object> map = new HashMap<String, Object>();
		List<AdminProduct> list = new ArrayList<AdminProduct>();
		int pageNo = 1;
		if(!currPg.equals("") || currPg != null) {
			pageNo = Integer.parseInt(currPg);
		}
		if(bs.getSearchWord() == null) {
			bs.setSearchWord("");
		}
		if(bs.getSearchType() == null) {
			bs.setSearchType("");
		}
		AdminPagingInfo pi = null;
		try {
			map = cService.getAdminProduct(pageNo, bs, sortType);
			
			list = (List<AdminProduct>) map.get("adminProduct");
			pi = (AdminPagingInfo) map.get("pagingInfo");
			m.addAttribute("adminProduct",list);
			m.addAttribute("pagingInfo", pi);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	@RequestMapping("adminStatistics/visitorChartDetail")
	public void visitorChartDetail(Model m, HttpServletRequest request) {
		
		String sessionId = request.getSession().getId();
		System.out.println(sessionId);
		
		try {
			MemberVO member = lService.findLoginSess(sessionId);
			m.addAttribute("member",member);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	@RequestMapping("adminStatistics/salesDataDetail")
	public void salesDataDetail(Model m, HttpServletRequest request) {
		String sessionId = request.getSession().getId();
		System.out.println(sessionId);
		
		try {
			MemberVO member = lService.findLoginSess(sessionId);
			m.addAttribute("member",member);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping("adminStatistics/allSalesDetail")
	public void allSalesDetail(Model m, HttpServletRequest request){
		String sessionId = request.getSession().getId();
		System.out.println(sessionId);
		
		try {
			MemberVO member = lService.findLoginSess(sessionId);
			m.addAttribute("member",member);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("reviewBoard/list")
	public void reviewList() {
		System.out.println("리뷰게시판 관리자 페이지");
	}
	
	@RequestMapping("reviewBoard/detail")
	public void reviewDetail(Model model , @RequestParam("no") int reviewNo) {
		System.out.println("리뷰상세조회 관리자 페이지");
		
		Map<String, Object> resultMap;
		try {
			resultMap = rService.readReview(reviewNo);
			ReviewVO review = (ReviewVO) resultMap.get("review");
			List<AttachFileVO> fileList = (List<AttachFileVO>) resultMap.get("fileList");
			
			review.setContent(review.getContent().replace("<br/>", "\n"));
			
			ProductVO product = pService.readProduct(review.getProductNo());
			
			model.addAttribute("review", review);
			model.addAttribute("fileList", fileList);
			model.addAttribute("product", product);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	
}
