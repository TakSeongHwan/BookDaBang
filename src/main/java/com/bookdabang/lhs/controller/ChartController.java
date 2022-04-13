package com.bookdabang.lhs.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookdabang.common.domain.VisitorIPCheck;
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
	
	@RequestMapping(value="autoInsertVisitor", method = RequestMethod.POST)
	public ResponseEntity<Map<String,String>> autoInsertVisitor(@RequestBody VisitorIPCheck vipc ) {
		
		ResponseEntity<Map<String,String>> result = null;
		Map<String, String> map = new HashMap<String, String>();
		System.out.println(vipc);
		try {
			if(service.autoInsertVisitor(vipc) == 1){
				map.put("result", "success");
				result = new ResponseEntity<Map<String,String>>(map, HttpStatus.OK);
			}
			
		} catch (Exception e) {
			result = new ResponseEntity<Map<String,String>>( HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return result;
		
	}
	
	
}
