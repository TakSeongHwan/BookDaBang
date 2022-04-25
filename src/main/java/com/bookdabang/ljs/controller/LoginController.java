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
		
		returnPrePage(ses, request); // 경로 저장
		
		Cookie cookies[] = request.getCookies(); // 현재 저장된 쿠키들을 불러와서
		
		for ( Cookie c : cookies) {
			
			String cookName = c.getName();
			if (cookName.equals("BookDBCookie")) {
				// 만약 저장한 북다방 쿠키가 있다면.
				
				System.out.println(c.getValue());
				MemberVO loginMember = service.findLoginSess(c.getValue()); // 일단 쿠키에 담긴 옛날 세션키로 멤버 담아와서
					
				System.out.println(loginMember.toString());
				
				if (loginMember != null) {  // 멤버가 있으면
					
					LoginDTO dto = new LoginDTO(loginMember.getUserId(), loginMember.getUserPwd(), true, loginMember.getSessionId()); // DTO에 현재 세션키 넣어서 업데이트 해주고 || 옛날 세션 키 그대로 로그인
					int result = service.lastLogin(dto); 
					// 세션 아이디/ 최종 로그인 시간 업데이트 했으니까 쿠키에도 바꿔줘야됨 || 그냥 옛날 세션키로 계속 로그인 되게? - 그러면 시간만 업데이트 됨
					
					// 일단 구 세션으로 로그인 하는걸로
//					Cookie BookDBCook = new Cookie("BookDBCookie", loginMember.getSessionId()); // 북다방 쿠키에 세션키 저장 
//					BookDBCook.setMaxAge(60 * 60 * 24); // 쿠키 만료시간을 2분으로 . 60*60*24*7
//					BookDBCook.setPath("/");
//					response.addCookie(BookDBCook);

					System.out.println("최종 자동 로그인 시간 업데이트 결과" + result);
					ses.setAttribute("sessionId", loginMember.getSessionId()); // 혼동 주의. 자동 로그인 시에는 쿠키에 있는(구) 세션키로 로그인.
					
					String prePage = (String)ses.getAttribute("prePage");
					
					if (prePage != null) {
						
						//ses.setAttribute("prePage", prePage);
						response.sendRedirect(prePage);
						
						System.out.println( "이전의" + prePage + "로 이동" );
					} else {
						response.sendRedirect("/");
						System.out.println("이전 페이지 없어서 홈으로 보냈다");
					}
					
				} 
			} 
			
			
		}
		
		System.out.println("쿠키 있니 없니");
		return "loginPage";
				
	}
	
	
	@RequestMapping(value="/login", method = RequestMethod.GET) 
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		
		returnPrePage(request.getSession(), request);
		
		
		return "login";
	}
	
	@RequestMapping(value = "/loginSign", method = RequestMethod.POST)
	public String loginSign(LoginDTO dto, Model model, HttpSession ses) {
	
				System.out.println("로그인 첫걸음" + dto.toString());
				MemberVO loginMember = null;

				// 
				try {
					// 만약 loginMember가 있으면
					loginMember = service.login(dto);
					if (loginMember == null) {
						
						System.out.println("해당 멤버의 정보없습니다.");
						
						// 만약 로그인 정보가 틀렸을 때는 어떤 값을 보내야 하지?
						
					} else {
						
						System.out.println("현재 세션아이디 :  " + ses.getId());
						dto.setSessionId(ses.getId());
						System.out.println("세션 아이디 DTO에 넣었니?" + dto.getSessionId());
						int result = service.lastLogin(dto); // 세션 아이디/ 최종 로그인 시간 업데이트 후에
						
						
						System.out.println("세션 값/ 로그인 시간 업데이트 결과 : " + result);
						loginMember = service.login(dto);
						
						model.addAttribute("loginMember", loginMember); // 모델에 담아서 보낸다
						
						
						 // 
						System.out.println("로그인한 멤버 정보 : " + model.toString());
						
						
	
						
					}
					
					
				} catch (Exception e) {
					System.out.println("로그인 실패");
				} 
				

				return "loginSign";
	}
	

		
		// 마이페이지를 눌렀는데 로그인이 안된 상태일때 이 요청으로 들어옴
		// 인터셉터가 실행되도록 보내고, 여기서는 이전 경로 저장이 이루어지도록.
		
		public void returnPrePage(HttpSession ses, HttpServletRequest req) {
			
			// 세션에 저장함
			String prePage = req.getHeader("REFERER");
			ses.setAttribute("prePage", prePage);
			
		}

		@RequestMapping(value="/logout", method=RequestMethod.GET)
		public void logout(HttpSession session, HttpServletResponse resp, HttpServletRequest req) throws Exception {
			
				
				Cookie BookDBCook = new Cookie("BookDBCookie", null);
				BookDBCook.setMaxAge(0); // 유효시간을 0으로 설정
				BookDBCook.setPath("/");
				resp.addCookie(BookDBCook);
				session.invalidate();

			
		
			// return?
			resp.sendRedirect("/");
		}
		
		
	
}
