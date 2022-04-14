package com.bookdabang.ljs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/cs/*")
public class CSBoardController {

	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String csBoardAll () {
		
		return "cs/readAllCSBoard";
	}
	
	
}
