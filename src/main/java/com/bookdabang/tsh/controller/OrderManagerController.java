package com.bookdabang.tsh.controller;

import java.io.IOException;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bookdabang.cyh.domain.SearchCriteria;

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

		Map<String, Object> map = null;
		try {
			map = oservice.selectAllOrder(sc, pageno);
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return result;
	}
}
