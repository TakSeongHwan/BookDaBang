package com.bookdabang.lhs.controller;


import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.VisitorIPCheck;
import com.bookdabang.lhs.domain.CategoryTotalSales;
import com.bookdabang.lhs.domain.RecentBestSeller;
import com.bookdabang.lhs.domain.SalesChartDetail;
import com.bookdabang.lhs.domain.SalesDataDetail;
import com.bookdabang.lhs.domain.SalesDataWithDate;
import com.bookdabang.lhs.domain.StartDateEndDate;
import com.bookdabang.lhs.domain.VisitorCountWithDateFormat;
import com.bookdabang.lhs.service.ChartService;

@Controller
@RequestMapping("/chart/*")
public class ChartController {

	@Inject
	ChartService service;

	@RequestMapping("getVisitorInfo")
	public ResponseEntity<List<VisitorCountWithDateFormat>> getVisitorInfo(Model m) {

		List<VisitorCountWithDateFormat> list = new ArrayList<VisitorCountWithDateFormat>();
		ResponseEntity<List<VisitorCountWithDateFormat>> result = null;
		try {

			list = service.getVisitorInfo();
			System.out.println(list);

			result = new ResponseEntity<List<VisitorCountWithDateFormat>>(list, HttpStatus.OK);

		} catch (Exception e) {
			result = new ResponseEntity<List<VisitorCountWithDateFormat>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return result;

	}

	@RequestMapping(value = "autoInsertVisitor", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>> autoInsertVisitor(@RequestBody VisitorIPCheck vipc) {

		ResponseEntity<Map<String, String>> result = null;
//		Map<String, String> map = new HashMap<String, String>();
//		System.out.println(vipc);
//		try {
//			if(service.autoInsertVisitor(vipc) == 1){
//				map.put("result", "success");
//				result = new ResponseEntity<Map<String,String>>(map, HttpStatus.OK);
//			}
//			
//		} catch (Exception e) {
//			result = new ResponseEntity<Map<String,String>>( HttpStatus.BAD_REQUEST);
//			e.printStackTrace();
//		}
		return result;

	}

	@RequestMapping("getTodayVisitor")
	public ResponseEntity<Map<String, Integer>> getTodayVisitor() {

		ResponseEntity<Map<String, Integer>> result = null;
		Map<String, Integer> map = new HashMap<String, Integer>();
		try {
			int visitor = service.getTodayVisitor();
			System.out.println(visitor);
			map.put("todayVisitor", visitor);
			result = new ResponseEntity<Map<String, Integer>>(map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<Map<String, Integer>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping("getYesterdayVisitor")
	public ResponseEntity<Map<String, Integer>> getYesterdayVisitor() {

		ResponseEntity<Map<String, Integer>> result = null;
		Map<String, Integer> map = new HashMap<String, Integer>();
		try {
			int visitor = service.getYesterdayVisitor();
			System.out.println(visitor);
			map.put("yesterdayVisitor", visitor);
			result = new ResponseEntity<Map<String, Integer>>(map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<Map<String, Integer>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping("getCategoryTotalSales")
	public ResponseEntity<Map<String, Object>> getCategoryTotalSales() {
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();

		try {
			List<CategoryTotalSales> cts = service.getCategoryTotalSales();
			map.put("cts", cts);
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;

	}

	@RequestMapping("getRecentBestSellerInSalesData")
	public ResponseEntity<Map<String, Object>> getRecentBestSellerInSalesData() {

		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<RecentBestSeller> list = service.getRecentBestSellerInSalesData();
			map.put("recentBestSeller", list);
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return result;

	}

	@RequestMapping("getWeekVisitor")
	public ResponseEntity<Map<String, Object>> getWeekVisitor() {
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<VisitorCountWithDateFormat> list = service.getWeekVisitor();
			map.put("weekVisitor", list);
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;

	}

	@RequestMapping(value = "getDetailChart", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getDetailChart(@RequestBody SalesChartDetail scd) {
		ResponseEntity<Map<String, Object>> result = null;
		System.out.println("통신?");

		System.out.println(scd.toString());
		try {
			Map<String, Object> map = service.getDetailChart(scd);
			System.out.println(map.toString());
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="getVisitorDetailChart", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getVisitorDetailChart(@RequestBody SalesChartDetail scd) {
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			System.out.println(scd);
			List<VisitorCountWithDateFormat> list = service.getVisitorDetailChart(scd);
			map.put("visitorDetail", list);
			result = new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return result;
		
	}
	@RequestMapping("getSalesData")
	public ResponseEntity<Map<String, Object>> getSalesData() {
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			int allSales = service.getAllSalesData();
			map.put("allSales", allSales);
			result = new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	@RequestMapping("getBookSalesMonth")
	public ResponseEntity<Map<String, Object>> getBookSalesMonth() {
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			float bookSalesMonth = service.getBookSalesMonth();
			map.put("bookSalesMonth", bookSalesMonth);
			result = new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	
	@RequestMapping(value="periodSalesDetail",method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> periodSalesDetail(@RequestBody StartDateEndDate sded){
		System.out.println(sded.toString());
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<SalesDataWithDate> list = new ArrayList<SalesDataWithDate>();
		try {
			list = service.periodSalesDetail(sded);
			System.out.println(list);
			map.put("periodSalesDetail", list);
			result = new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return result;
	}
}
