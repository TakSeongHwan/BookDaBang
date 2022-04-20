package com.bookdabang.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.lhs.domain.AdminPagingInfo;
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
		System.out.println("검색 : "+bs);
		System.out.println(sortType);
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
}
