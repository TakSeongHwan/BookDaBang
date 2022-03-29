package com.bookdabang.ljs.controller;




import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.domain.LoginDTO;
import com.bookdabang.ljs.service.MemberService;



/**
 * Handles requests for the application home page.
 */
@Controller
public class MemberController {
	
	@Inject
	private MemberService service;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login() {
				
	}
	
	@RequestMapping(value = "/loginPage", method = RequestMethod.POST)
	public void loginPage(LoginDTO dto, Model model, HttpSession ses) {
				System.out.println("여기까지 왔나?" + dto.toString());
				
				MemberVO loginMember = null;
				
				// 비밀번호가 틀렸을 때 어떻게 처리해야하나.
				
				try {
					System.out.println("!!");
					loginMember = service.login(dto);
					System.out.println(loginMember);
					if (loginMember != null) {
					
						System.out.println("로그인한 멤버 정보" + loginMember.toString());
						
						
					} else {
						
						System.out.println("로그인 실패");
						
					}
					
					model.addAttribute("loginMember", loginMember);
					ses.setAttribute("loginMember", loginMember);
					System.out.println(ses.toString());
					
				} catch (Exception e) {
					System.out.println("로그인 실패");
				} 
				
				
				//model.addAttribute("loginMember", loginMember);
				
				
	}
	
	@RequestMapping(value = "mypage/memberinfo", method = RequestMethod.GET)
	public void memberinfo() {
				
	}
	
}
