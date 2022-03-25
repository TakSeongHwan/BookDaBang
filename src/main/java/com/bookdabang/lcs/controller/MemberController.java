package com.bookdabang.lcs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookdabang.common.domain.MemberVO;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@RequestMapping(value = "/registerMember", method = RequestMethod.GET)
	public void registerMember(MemberVO member, Model model) {
		
		System.out.println("회원가입하러옴");
	}
	
}
