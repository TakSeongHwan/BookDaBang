package com.bookdabang.ljs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BoardController {
	
	@RequestMapping(value = "customerservice", method = RequestMethod.GET)
	public void home() {
				
	}
}
