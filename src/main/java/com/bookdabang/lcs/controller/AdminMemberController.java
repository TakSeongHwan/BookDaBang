/**
 * 
 */
package com.bookdabang.lcs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.Withdraw;
import com.bookdabang.lcs.domain.IsdormantDTO;
import com.bookdabang.lcs.service.MemberService;
import com.mysql.cj.xdevapi.Result;

@Controller
@RequestMapping(value = "/admin/adminMember/*")
public class AdminMemberController {

	@Inject
	private MemberService service; //
	
	@RequestMapping (value = "/getList", method = RequestMethod.GET)
	public  ResponseEntity<Map<String, Object>> adminMember(Model model,@RequestParam("pageNo") int pageNo, @RequestParam("answerStatus") int answerStatus) {
		
		ResponseEntity<Map<String, Object>> result = null;
		System.out.println(pageNo + " " + answerStatus);
		
		try {
			Map<String, Object> map = service.selectMember(pageNo, answerStatus);
			result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			System.out.println(map);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
	
		return result;
		
	}
	@RequestMapping (value = "/listAll", method = RequestMethod.GET)
	public void listAll () throws Exception {
		
		
	}
	@RequestMapping(value = "/dormantUpdate", method = RequestMethod.POST)
	public ResponseEntity<String> dormantMember(@ModelAttribute IsdormantDTO dormant) {
		ResponseEntity<String> result = null;
		
		System.out.println(dormant.toString());
		
		try {
			if(service.updatedormant(dormant)) {
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
	@RequestMapping(value = "/delete/{userId}", method = RequestMethod.GET)
	public ResponseEntity<String> deleteMember(@PathVariable("userId") String userId)  {
		ResponseEntity<String> result = null;
		
		try {
			if(service.delete(userId)) {
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
