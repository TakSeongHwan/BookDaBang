package com.bookdabang.cyh.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.cyh.service.ProductService;

@RestController
@RequestMapping(value = "/prodQnARest", method = RequestMethod.POST)
public class ProdQnARest {
	
	@Inject
	private ProductService service;
	
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listAllOfNotAnswer(@RequestParam("pageNo") int pageNo, @RequestParam("answerStatus") int answerStatus,  @RequestParam(value="isbn", required=false, defaultValue="1") String isbn ){
		
		
		System.out.println("isbn ="+ isbn);
		
		ResponseEntity<Map<String, Object>> result = null;
		System.out.println(pageNo + "");
		System.out.println(answerStatus + "");

		Map<String, Object> map = null;
		try {
			map = service.selectProdQnA(pageNo, answerStatus, isbn);
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return result;
	}
	
	
	@RequestMapping(value = "/{sessionId}", method = RequestMethod.GET,  produces = "application/text; charset=utf8")
	public ResponseEntity<String> getuserNickName(@PathVariable("sessionId") String sessionId) {
		
		System.out.println("세션아이디" + sessionId);

		ResponseEntity<String> result = null;
		

		try {
			String userNickName = service.validSession(sessionId);
			System.out.println(userNickName);
			
			result = new ResponseEntity<String>(userNickName, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;

	}

	

}
