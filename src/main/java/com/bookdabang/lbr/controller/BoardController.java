package com.bookdabang.lbr.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.lbr.service.BoardService;


@Controller
@RequestMapping(value = "/board/*")
public class BoardController {

	@Inject 
	private BoardService service;
	
	@RequestMapping(value ="listAllFreeBoard", method = RequestMethod.GET)
	public void listAllFreeBoard(Model model) throws Exception {
		System.out.println("글");
		List<FreeBoard> lst = service.listAllBoards();
		model.addAttribute("freeBoard", lst);
		
	}
}
