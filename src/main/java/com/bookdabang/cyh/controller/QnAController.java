package com.bookdabang.cyh.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.cyh.service.ProductService;

@Controller
@RequestMapping(value = "/prodQna/*")
public class QnAController {

	@Inject
	private ProductService service;

	@RequestMapping(value = "/{sessionId}", method = RequestMethod.GET)
	public ResponseEntity<String> validSession(Model model, @PathVariable("sessionId") String sessoinId) {
		
		System.out.println(sessoinId);

		ResponseEntity<String> result = null;

		try {
			String userId = service.validSession(sessoinId);
			result = new ResponseEntity<String>(userId, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;

	}

}
