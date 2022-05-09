
package com.bookdabang.lcs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.Refund;
import com.bookdabang.lcs.service.RefundService;

@Controller
@RequestMapping(value = "admin/refundBoard/*")
public class RefundController {
	
	@Inject
	private RefundService service;
	
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public void Board(Model model, @RequestParam("pageNo") int pageNo) throws Exception { 
		Map<String, Object> map = service.adminRefundList(pageNo);
		List<Refund> list = (List<Refund>)map.get("lst");
		System.out.println(list);
		model.addAttribute("refund", list );
		model.addAttribute("pi", (PagingInfo)map.get("pi"));
		System.out.println(pageNo +"여기오니");
	}
	
	@RequestMapping(value = "/refunUpdate", method = RequestMethod.POST)
	public ResponseEntity<String> refunUpdate(int refundNo){
		ResponseEntity<String> result = null;
		
		try {
			if (service.refundUpdate(refundNo)) {
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
