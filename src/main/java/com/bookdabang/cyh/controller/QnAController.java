package com.bookdabang.cyh.controller;

import java.util.HashMap;
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

import com.bookdabang.common.domain.ProductQnA;
import com.bookdabang.cyh.domain.AnswerDTO;
import com.bookdabang.cyh.domain.ProdQnADTO;
import com.bookdabang.cyh.service.ProductService;

@Controller
@RequestMapping(value = "/prodQna/*")
public class QnAController {

	@Inject
	private ProductService service;

	
	@RequestMapping(value = "/", method = RequestMethod.POST)
	public ResponseEntity<String> InsertQnA(Model model, @ModelAttribute ProdQnADTO dto) {

		ResponseEntity<String> result = null;
		System.out.println(dto.toString());

		try {
			if (service.InsertQnA(dto)) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity<String>("fail", HttpStatus.OK);
			}

		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;

	}
	
	
	

	@RequestMapping(value = "deleteQnA", method = RequestMethod.POST)
	public ResponseEntity<String> deleteQnA(@RequestBody String question_no) {
		int questionNo = Integer.parseInt(question_no.split("=")[1]);
		System.out.println(questionNo);
		ResponseEntity<String> result = null;

		try {
			if (service.deleteQnA(questionNo)) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity<String>("fail", HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;
	}
	
	
	@RequestMapping(value = "/insertAnswer", method = RequestMethod.POST)
	public ResponseEntity<String> insertAnswer(Model model, @ModelAttribute AnswerDTO answer) {

		ResponseEntity<String> result = null;
		
		System.out.println(answer.toString());
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
		return result;

	}

}
