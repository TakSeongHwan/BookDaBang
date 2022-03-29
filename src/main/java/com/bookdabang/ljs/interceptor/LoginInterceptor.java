package com.bookdabang.ljs.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bookdabang.common.domain.MemberVO;



public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession ses = request.getSession();
		
		System.out.println(request.getHeaders("Re"));
		
		// 이전에 로그인한 기록이 남아있다면... 이전 로그인 기록 삭제
		if (ses.getAttribute("loginMember") != null) {
			System.out.println("이전에 로그인한 기록을 삭제합니다..");
			ses.removeAttribute("loginMember");
		}
		
		return true; // 이거 없으면 진행 안됨
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// member/loginPost 에서 loginPost()실행 후 수행
		ModelMap modelMap = modelAndView.getModelMap();
		MemberVO loginMember = (MemberVO)modelMap.get("loginMember"); // loginPost()에서 model 객체에 바인딩한 객체를 얻어옴.
		System.out.println("postHandle : " + loginMember);
		
		HttpSession ses = request.getSession();
		
		if (loginMember != null) {
			System.out.println("로그인 됐나요?ㅎㅎ");
			ses.setAttribute("loginMember", loginMember); // 세션 객체에 로그인 유저 정보 바인딩
			
			System.out.println(request.getParameter("remember"));
			
			// 자동로그인 여부가 여기까지 온다.
			if(request.getParameter("remember") != null) {// 자동로그인 체크박스에 체크가 되어있다면...
				// loginCook 이라는 이름으로 세션 ID값을 쿠키에 저장 
				Cookie loginCook = new Cookie("loginCook", ses.getId());
				loginCook.setMaxAge(60 * 60 * 24); // 쿠키 만료시간을 2분으로 . 60*60*24*7
				loginCook.setPath("/");
				response.addCookie(loginCook);
			}
			
			//response.sendRedirect("/"); // index.jsp로 리다이렉트
			String dest = (String)ses.getAttribute("dest");
			System.out.println("로그인 이전 경로 : " + dest);
			
			if (dest != null) {
				response.sendRedirect(dest);
			} else {
				response.sendRedirect("/");	
			}
			
		} else {
			System.out.println("로그인 실패");
			response.sendRedirect("/member/login?status=fail");
		}
	}

	
}
