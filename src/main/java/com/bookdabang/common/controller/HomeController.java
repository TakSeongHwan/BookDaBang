package com.bookdabang.common.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.Product;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.lhs.service.ChartService;
import com.bookdabang.ljs.service.LoginService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	
	
	@Inject
	private LoginService service;
	
	@Inject
	ChartService cService;
	
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
				// Null point Exception
				e.printStackTrace();
			}
			
			model.addAttribute("loginMember", loginMember);

		}
		
			List<ProductVO> bestSellerlist = new ArrayList<ProductVO>();
			try {
				bestSellerlist = cService.getProductSort();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			model.addAttribute("product",bestSellerlist);
		
			List<ProductVO> randomList = new ArrayList<ProductVO>();
			try {
				randomList = cService.getRandomSelect();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			model.addAttribute("randomBook",randomList);
			
			
		
		return "home";
		

	}
	
	@RequestMapping(value="admin", method=RequestMethod.GET)
	public String exam2(Model m, HttpServletRequest request) {
		
		String sessionId = request.getSession().getId();
		System.out.println(sessionId);
		
		try {
			MemberVO member = service.findLoginSess(sessionId);
			List<ProductVO> list = cService.getLessStock();
			m.addAttribute("product",list);
			m.addAttribute("member",member);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		System.out.println("admin이 호출됨....");
		return "adminHome";
	}
	
}
