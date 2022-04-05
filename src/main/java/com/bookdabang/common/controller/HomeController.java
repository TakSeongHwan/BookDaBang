package com.bookdabang.common.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.service.LoginService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	
	
	@Inject
	private LoginService service;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, @RequestParam(value = "u", required = false) String sessionId) {
		logger.info("Welcome home! The client locale is {}.", locale);

		//Date date = new Date();
		//DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		//String formattedDate = dateFormat.format(date);

		//model.addAttribute("serverTime", formattedDate);
		
		if (sessionId != null) {
			
			MemberVO loginMember = null;
			System.out.println("이거 찍나 보자 " + sessionId);
			try {
				loginMember = service.findLoginSess(sessionId);
				System.out.println(loginMember.toString());
				
			} catch (Exception e) {
				
				System.out.println("홈컨트롤러에서 세션 아이디를 못받아옴");
				e.printStackTrace();
			}
			
			model.addAttribute("loginMember", loginMember);

		}
		
		return "home";
		

	}
	
	@RequestMapping(value="admin", method=RequestMethod.GET)
	public String exam2() {
		System.out.println("admin이 호출됨....");
		return "adminHome";
	}
	
}
