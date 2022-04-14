
package com.bookdabang.lcs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookdabang.common.domain.Refund;
import com.bookdabang.lcs.service.RefundService;

@Controller
@RequestMapping(value = "admin/refundBoard/*")
public class RefundController {
	
	@Inject
	private RefundService service;
	
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public void Board(Model model) throws Exception { 
		List<Refund> lst = service.adminRefundList();
		model.addAttribute("refund", lst);
		System.out.println(lst);
	}
	@RequestMapping(value = "/refunUpdate", method = RequestMethod.POST)
	public ResponseEntity<String> refunUpdate(){
		ResponseEntity<String> result = null;
		
		try {
			if (service.refundUpdate()) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity<String>("fail", HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return result;
	}
}
