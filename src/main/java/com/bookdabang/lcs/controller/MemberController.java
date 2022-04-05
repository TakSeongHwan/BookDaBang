package com.bookdabang.lcs.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.inject.Inject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.lcs.domain.MemberDTO;
import com.bookdabang.lcs.etc.SendMail;
import com.bookdabang.lcs.service.MemberService;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import org.json.simple.JSONObject;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Inject
	private MemberService service;

	@RequestMapping(value = "/registerMember", method = RequestMethod.GET)
	public void registerMember(MemberVO member, Model model, HttpServletRequest req) {
		System.out.println(req.getContextPath());
	}

	@RequestMapping(value = "/insertMember", method = RequestMethod.POST)
	public String insertMember(MemberDTO member, RedirectAttributes rttr) throws Exception {
//		System.out.println("recommend : " + recommend.toString());
		System.out.println("member :  " + member.toString());
		String redirctAdrr = "redirect:/";
		if (service.insertMember(member)) {
			rttr.addAttribute("result", "success");
		} else {
			rttr.addAttribute("result", "fail");
			redirctAdrr = "redirect:/registerMember.jsp";
		}

		return redirctAdrr;

	}

	@RequestMapping(value = "/userIdCheck", method = RequestMethod.POST)
	public @ResponseBody String userIdCheck(HttpServletRequest request) throws Exception {
		boolean userIdCheck = service.userIdCheck(request.getParameter("userId"));
		String result = "fail";
		if (!userIdCheck) {
			result = "success";
		}
		System.out.println(result);
		System.out.println("userId " + request.getParameter("userId"));
		return result;
	}

	@RequestMapping(value = "/nickNameCheck", method = RequestMethod.POST)
	public @ResponseBody String nickNameCheck(HttpServletRequest request) throws Exception {
		boolean nickNameCheck = service.nickNameCheck(request.getParameter("nickName"));
		String result = "fail";
		if (!nickNameCheck) {
			result = "success";
		}
		System.out.println(result);
		System.out.println("nickName " + request.getParameter("nickName"));
		return result;

	}

	@RequestMapping(value="/sendCode", method = RequestMethod.POST)
	public void insertEmailCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
	service.insertEmailCode(request, response, request.getParameter("userEmail"));
	}
	@RequestMapping(value="/confirmEmailCode", method = RequestMethod.POST)
	public void confirmEmailCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
	service.confirmEmailCode(request, response, request.getParameter("emailConfirm"));
	}
}

