package com.bookdabang.ljs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.service.LoginService;

@Controller
@RequestMapping("/mypage/*")
public class MyPageController {
	
	@Inject
	private LoginService service;
	
	@RequestMapping(value = "/memberinfo", method = RequestMethod.GET)
	public String memberinfo(@RequestParam("u") String sessionId, Model model) {
		
		MemberVO loginMember = null;
		System.out.println(sessionId);
		
		try {
			loginMember = service.findLoginSess(sessionId);
			
		} catch (Exception e) {
			System.out.println("세션값으로 멤버 찾기 실패하였습니당");
		}
		
		model.addAttribute("loginMember", loginMember);
		
				return "mypage/memberinfo";
	}
	
	
	
	@RequestMapping(value = "viewPoint.do", method = RequestMethod.POST)
	public List<MemberPoint> pointCheck(@RequestParam("ses") String sessionId) {
		
		System.out.println("접속한사람 : " +sessionId);
	
				
				MemberVO loginMember = null;
				List<MemberPoint> pointHistory = null;
					try {
						
						loginMember = service.findLoginSess(sessionId);
						String userId = loginMember.getUserId();
						pointHistory = service.pointCheck(userId);
						
						
						System.out.println(pointHistory.toString());
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						System.out.println("포인트 적립 세션아이디 에러");
					}
					
	
				return pointHistory;
	}
	
	@RequestMapping(value = "withdrawMember.do", method = RequestMethod.POST)
	@ResponseBody
	public int withdrawMember(@RequestParam("ses") String memberSess) {
		
				System.out.println(memberSess + " 탈퇴시키러 여기에 올까요?");
				
				int result = 0;
				try {
					result = service.withdrawMember(memberSess);	 
					
				if(result == 1) {
					System.out.println("탈퇴 성공하였습니다.");
				}
					
				
				} catch (Exception e) {
					
					e.printStackTrace();
					System.out.println("탈퇴 실패하였습니다.");
					
				}
				
				return result;
	}
	
//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	public void home(@RequestParam("ses") String sessionId) {
//		
//	}
}
