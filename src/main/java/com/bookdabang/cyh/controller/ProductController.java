package com.bookdabang.cyh.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.ProductQnA;
import com.bookdabang.cyh.domain.AnswerDTO;
import com.bookdabang.cyh.service.ProductService;

@Controller
@RequestMapping(value = "/prodManager/*")
public class ProductController {

	@Inject
	private ProductService service;

	@RequestMapping(value = "/listAll", method = RequestMethod.GET)
	public void listAll(Model model) throws Exception {
		List<CategoryVO> categoryLst = service.getCategory();
		model.addAttribute("category", categoryLst);

	}

	@RequestMapping(value = "/addProduct", method = RequestMethod.GET)
	public void addProduct(Model model) throws Exception {
		List<CategoryVO> categoryLst = service.getCategory();
		model.addAttribute("category", categoryLst);

	}

	@RequestMapping(value = "/listAllofQnA", method = RequestMethod.GET)
	public void listAllofQnA(Model model) throws Exception {

	}

	@RequestMapping(value = "/insertAnswer", method = RequestMethod.POST)
	public ResponseEntity<String> insertAnswer(Model model, @ModelAttribute AnswerDTO answer) {

		ResponseEntity<String> result = null;
		try {
			if (service.insertAnswer(answer)) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity<String>("fail", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		;
		return result;

	}
	@RequestMapping(value = "/prodUpdate", method = RequestMethod.GET)
	public void prodUpdate(Model model, @RequestParam("prodNo") String prodNo) throws Exception {
		List<CategoryVO> categoryLst = service.getCategory();
		model.addAttribute("category", categoryLst);
		model.addAttribute("prod", service.getProdByISBN(prodNo));
		
		return;
	}
	
	
	@RequestMapping(value = "/SearchISBN", method = RequestMethod.GET)
	public void SearchISBN() throws Exception {
		
		
	}
	
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login() throws Exception {
		
		
	}
	
	
		
	
	

}
