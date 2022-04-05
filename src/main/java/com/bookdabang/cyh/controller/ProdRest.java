package com.bookdabang.cyh.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.cyh.service.ProductService;

@RestController
@RequestMapping(value = "/prodRest", method = RequestMethod.POST)
public class ProdRest {

	@Inject
	private ProductService service;

	@RequestMapping(value = "/all/{pageno}", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> listAll(Model model, @ModelAttribute SearchCriteria sc, 
			@PathVariable("pageno") int pageno) {
		ResponseEntity<Map<String, Object>> result = null;

		Map<String, Object> map;
		try {
			map = service.conditionProdView(sc, pageno);
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return result;
	}
	
	@RequestMapping(value = "/up", method = RequestMethod.POST)
	public ResponseEntity<List<ProductVO>> updateListView(Model model, @RequestParam(value="checkBoxs[]")List<String> checkProd) {
		System.out.println("!!");
		ResponseEntity<List<ProductVO>> result = null;
		try {
			List<ProductVO> lst =service.selectProdView(checkProd);
			result = new ResponseEntity<List<ProductVO>>(lst, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return result;
		
	}

}
