package com.bookdabang.cyh.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.ProdDTO;
import com.bookdabang.cyh.domain.ProdInfo;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.cyh.domain.UpdateProdDTO;
import com.bookdabang.cyh.domain.deleteProdDTO;
import com.bookdabang.cyh.etc.UploadImageProcess;
import com.bookdabang.cyh.service.ProductService;

@RestController
@RequestMapping(value = "/api.prod.com", method = RequestMethod.POST)
public class ProdRest {

	@Inject
	private ProductService service;

	// 상품조회
	@RequestMapping(value = "/prods/{pageno}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listAll(Model model, @ModelAttribute SearchCriteria sc,
			@PathVariable("pageno") int pageno) {
		ResponseEntity<Map<String, Object>> result = null;

		Map<String, Object> map;
		try {
			map = service.conditionProdView(sc, pageno);
			System.out.println(sc.toString());
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return result;
	}

	// 상품 등록
	@RequestMapping(value = "/post", method = RequestMethod.POST)
	public ResponseEntity<String> insertProd(Model model, @ModelAttribute ProdDTO product) {

		System.out.println(product.toString());
		ResponseEntity<String> result = null;

		try {
			if (service.insertProd(product)) {
				result = new ResponseEntity("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity("fail", HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;
	}

	// 상품 업데이트
	@RequestMapping(value = "/put", method = RequestMethod.PUT)
	public ResponseEntity<String> updateProd(Model model, @ModelAttribute ProdDTO product) {

		System.out.println(product.toString());
		ResponseEntity<String> result = null;

		try {
			if (service.updateProd(product)) {
				result = new ResponseEntity("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity("fail", HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;
	}

}
