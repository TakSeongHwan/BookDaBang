package com.bookdabang.ljs.controller;






import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.domain.LoginDTO;
import com.bookdabang.ljs.service.LoginService;




/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/*")
public class LoginController {
	
	@Inject
	private LoginService service;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPage(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		// 먼저 자동로그인 쿠키가 있는지 없는지부터 체크하기
		HttpSession ses = request.getSession();
		
		Cookie cookies[] = request.getCookies(); // 현재 저장된 쿠키들을 불러와서
		
		for ( Cookie c : cookies) {
			
			String cookName = c.getName();
			if (cookName.equals("BookDBCookie")) {
				// 만약 저장한 북다방 쿠키가 있다면.
				
				System.out.println(c.getValue());
				MemberVO loginMember = service.findLoginSess(c.getValue());
				
				// null 예외가  뜬다 - 세션이 바뀌었음.
				// 쿠키에 저장한 세션키와 DB에 저장한 세션키가 일치하지 않는 오류 발생함.
				// 자동로그인을 체크하고 로그인 했을 경우 
				// 자동로그인을 체크하지 않고 로그인 했을 경우
				
				System.out.println(loginMember.toString());
				
				if (loginMember != null) {
					
					model.addAttribute("loginMember", loginMember);
					LoginDTO dto = new LoginDTO(loginMember.getUserId(), loginMember.getUserPwd(), true, ses.getId());
					System.out.println(dto.toString());
					int result = service.lastLogin(dto); // 세션 아이디/ 최종 로그인 시간 업데이트 했으니까 쿠키에도 바꿔줘야됨
					Cookie BookDBCook = new Cookie("BookDBCookie", dto.getSessionId()); // 북다방 쿠키에 세션키 저장 
					BookDBCook.setMaxAge(60 * 60 * 24); // 쿠키 만료시간을 2분으로 . 60*60*24*7
					BookDBCook.setPath("/");
					response.addCookie(BookDBCook);

					System.out.println("최종 로그인 시간 결과" + result);					
					//response.sendRedirect("/ljs/mypage/");
				} 
			} 
		}
		
		System.out.println("쿠키 있니 없니");
		return "loginPage";
				
	}
	
	
	@RequestMapping(value="/login", method = RequestMethod.GET) 
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		try {
			loginPage(request, response, model);
			
		} catch (Exception e) {
			System.out.println("쿠키 유무 판별 실패");
			e.printStackTrace();
		}
		
		
		
		return "login";
	}
	
	@RequestMapping(value = "/loginSign", method = RequestMethod.POST)
	public String loginSign(LoginDTO dto, Model model, HttpSession ses) {
	
				System.out.println("로그인 첫걸음" + dto.toString());
				dto.setSessionId(ses.getId());
				System.out.println("세션 아이디 DTO에 넣었니?" + dto.getSessionId());
				MemberVO loginMember = null;
			
				// 비밀번호가 틀렸을 때 어떻게 처리해야하나.
				try {
					
					loginMember = service.login(dto);
					
					if (loginMember == null) {
						
						System.out.println("해당 멤버의 정보없습니다.");
						
						// 만약 로그인 정보가 틀렸을 때는 어떤 값을 보내야 하지?
						
					} else {
						
						model.addAttribute("loginMember", loginMember);
						
						int result = service.lastLogin(dto);
						System.out.println(result);
						
						 // 
						System.out.println("로그인한 멤버 정보 : " + model.toString());
					
//						if (dto.isAutoLogin()) { // 자동 로그인에 체크되어 있다면.
//							
						
//										/* 참고 코드*/							
////							Timestamp loginlimit = new Timestamp(System.currentTimeMillis() + (1000 * 60 * 60 * 24)); //long type으로 하루
////							service.keepLogin(new KeepLoginDTO(dto.getUserId(), ses.getId(), loginlimit));
//						}
						
					}
					
					
				} catch (Exception e) {
					System.out.println("로그인 실패");
				} 
				

				return "/loginSign";
	}
	
	
	
		
		@RequestMapping(value = "/mypage/", method = RequestMethod.GET)
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
		
		// 마이페이지를 눌렀는데 로그인이 안된 상태일때 이 요청으로 들어옴
		// 인터셉터가 실행되도록 보내고, 여기서는 이전 경로 저장이 이루어지도록.
		
		@RequestMapping(value="/returnPrePage")
		public String returnPrePage(HttpSession ses) {
			
			System.out.println("마이페이지 경로 저장하자");
			// 세션에 저장함
			ses.setAttribute("prePage", "/");
			// 다시 로그인하러 보냄
			return "redirect:/mypage/login";
		}

		@RequestMapping(value="/logout", method=RequestMethod.GET)
		public void logout(HttpSession session, HttpServletResponse resp, HttpServletRequest req) throws Exception {
			
				
				Cookie BookDBCook = new Cookie("BookDBCookie", null);
				BookDBCook.setMaxAge(0); // 유효시간을 0으로 설정
				BookDBCook.setPath("/");
				resp.addCookie(BookDBCook);
				session.invalidate();

			
		
			// return?
			resp.sendRedirect("/ljs/");
		}
		
		
	
}
