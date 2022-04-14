
package com.bookdabang.lcs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bookdabang.common.domain.Refund;
import com.bookdabang.lcs.service.RefundService;

@Controller
@RequestMapping(value = "userRefundBoard/*")
public class RefundBoardController {

	@Inject
	private RefundService service;

	@RequestMapping(value = "/board")
	public void refundBoard(Model model) throws Exception {
		List<Refund> lst = service.refundList();
		System.out.println(lst);
	}

}
