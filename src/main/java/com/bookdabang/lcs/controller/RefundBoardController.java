
package com.bookdabang.lcs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.Refund;
import com.bookdabang.lcs.service.RefundService;
import com.bookdabang.ljs.service.LoginService;

@Controller
@RequestMapping(value = "userRefundBoard/*")
public class RefundBoardController {

	@Inject
	private RefundService service;
	@Inject
	private LoginService lservice;

	@RequestMapping(value = "/board")
	public void refundBoard(Model model, HttpSession ses) throws Exception {
		String sessionId = (String) ses.getAttribute("sessionId");
		List<Refund> lst = service.refundList(sessionId);
		model.addAttribute("userRefund", lst);
		System.out.println(lst);
	}
	

	@RequestMapping(value = "/insertRefund",method = RequestMethod.POST)
	public String insertRefund(int code,int orderNo, String userId, Model model, HttpSession ses) throws Exception {
		Refund refund = new Refund();
		System.out.println(userId);
		refund.setOrderNo(orderNo);
		refund.setRefundReason(code);
		String sessionId = (String) ses.getAttribute("sessionId");
		
		userId = lservice.findLoginSess(sessionId).getUserId();
		refund.setUserId(userId);
		
		service.insertRefund(refund);
		
		List<Refund> lst = service.refundList(sessionId);
		model.addAttribute("userRefund", lst);
		
		return "/userRefundBoard/board";
	}

}
