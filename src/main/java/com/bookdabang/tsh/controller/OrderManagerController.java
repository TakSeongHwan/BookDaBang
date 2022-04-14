package com.bookdabang.tsh.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bookdabang.tsh.etc.SearchCriteria;
import com.bookdabang.tsh.service.OrderService;

@RestController
@RequestMapping("/orderManager/*")
public class OrderManagerController {

	@Inject
	private OrderService oservice;
	

	@RequestMapping(value = "/getAll/{pageno}",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getAllorder(Model model, @ModelAttribute SearchCriteria sc,
			@PathVariable("pageno") int pageno) {
		ResponseEntity<Map<String, Object>> result = null;
		System.out.println(sc);
		Map<String, Object> map = null;
		try {
			map = oservice.selectAllOrder(sc, pageno);
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return result;
	}
	
	@RequestMapping(value = "/orderState/{orderNo}",method = RequestMethod.PUT)
	public ResponseEntity<String> updateOrderState(@RequestBody String orderState ,@PathVariable("orderNo") int orderNo){
		ResponseEntity<String> result = null;
		orderState = orderState.split("=")[1];
		System.out.println(orderState);
		try {
			int r = oservice.updateOrderState(Integer.parseInt(orderState),orderNo);
			if(r == 1) {
				result = new ResponseEntity<String>("success",HttpStatus.OK);
			}else {
				result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return result;
	}
	
	@RequestMapping(value = "/confirm/{orderNo}",method = RequestMethod.PUT)
	public ResponseEntity<String> updateConfirm(@RequestBody String confirm ,@PathVariable("orderNo") int orderNo){
		ResponseEntity<String> result = null;
		confirm = confirm.split("=")[1];
		System.out.println(confirm);
		result = new ResponseEntity<String>("success",HttpStatus.OK);
		return result;
	}
}
