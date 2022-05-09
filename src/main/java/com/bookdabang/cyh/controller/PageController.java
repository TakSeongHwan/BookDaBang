package com.bookdabang.cyh.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.multipart.MultipartFile;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.ProductQnA;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.AnswerDTO;
import com.bookdabang.cyh.domain.ProdInfo;
import com.bookdabang.cyh.domain.UpdateProdDTO;
import com.bookdabang.cyh.domain.deleteProdDTO;
import com.bookdabang.cyh.etc.UploadImageProcess;
import com.bookdabang.cyh.service.ProductService;

@Controller
@RequestMapping(value = "/prodManager/*")
public class PageController {

	@Inject
	private ProductService service;

	// listAll 페이지 이동 및 categoryList 바인딩
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
	
	@RequestMapping(value = "/prodUpdate", method = RequestMethod.GET)
	public void prodUpdate(Model model, @RequestParam("prodNo") String prodNo) throws Exception {
		List<CategoryVO> categoryLst = service.getCategory();
		model.addAttribute("category", categoryLst);
		model.addAttribute("prod", service.getProdByISBN(prodNo));

		return;
	}
	
	@RequestMapping(value = "/listAllofQnA", method = RequestMethod.GET)
	public void listAllofQnA(Model model) throws Exception {

	}

		
	@RequestMapping(value = "/SearchISBN", method = RequestMethod.GET)
	public void SearchISBN() throws Exception {

	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login() throws Exception {

	}

}
