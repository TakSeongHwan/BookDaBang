package com.bookdabang.cyh.controller;

import java.util.Locale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping(value = "/prodManager/*")
public class ProductController {
	
	@RequestMapping(value = "/listAll", method=RequestMethod.GET)
	public void listAll(Model model) throws Exception { 
		System.out.println("!!!!");
		
	}
	
}
