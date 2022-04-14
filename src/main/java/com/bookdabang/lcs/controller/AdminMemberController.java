/**
 * 
 */
package com.bookdabang.lcs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.Withdraw;
import com.bookdabang.lcs.domain.IsdormantDTO;
import com.bookdabang.lcs.service.MemberService;
import com.mysql.cj.xdevapi.Result;

@Controller
@RequestMapping(value = "/admin/*")
public class AdminMemberController {

	@Inject
	private MemberService service; //媛앹껜 二쇱엯
	
	@RequestMapping (value = "/adminMember/listAll", method = RequestMethod.GET)
	public  String adminMember(Model model) throws Exception {
		// model �럹�씠吏��씠�룞 - url�씠 諛붽톲�븣
		List<MemberVO> lst = service.selectMember();
		List<MemberVO> dormantLst = service.dormantMember();
		List<Withdraw> deleteLst = service.deleteMember();
		
		model.addAttribute("memberList", lst);
		model.addAttribute("dormantMember", dormantLst);
		model.addAttribute("deleteMeber", deleteLst);

		return "/admin/adminMember/listAll";
		
	}
	@RequestMapping(value = "/adminMember/dormantUpdate", method = RequestMethod.POST)
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
	@RequestMapping(value = "/adminMember/delete", method = RequestMethod.GET)
	public String deleteMember(@RequestParam String userId) throws Exception {
		System.out.println(userId);
		System.out.println(service.delete(userId));
		String result = null;
		return result;
	}

}
