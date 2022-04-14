package com.bookdabang.ljs.interceptor;



import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;


public class AuthInterceptor extends HandlerInterceptorAdapter {

//	@Inject
//	private MemberService service;
//
//	
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		
//		boolean result = false;
//		// 특정 경로에 접근하면 
//		HttpSession ses = request.getSession();
//		System.out.println("!");
//		if (ses.getAttribute("loginMember") == null) { // 로그인 하지 않음.
//			System.out.println("로그인 하지 않음!!!");
//			
//			saveDestination(request);
//			
//			// 쿠키에 loginCook 이라는 이름의 쿠키가 있는지 확인하고 
//			Cookie loginCook = WebUtils.getCookie(request, "loginCook");
//			
//			if (loginCook != null) {
//				MemberVO autoLoginUser = service.isAutoLogin(loginCook.getValue());
//				if( autoLoginUser != null) { 
//					ses.setAttribute("loginMember", autoLoginUser);
//					result = true;
//					String dest = (String)ses.getAttribute("dest");
//					System.out.println("로그인 인터셉터 이전경로 : " + dest);
//					if (dest != null) {
//						response.sendRedirect(dest);
//					} else {
//						response.sendRedirect("/");	
//					}
//				};
//			}
//			
//			response.sendRedirect("/member/login"); // 로그인 하러 보냄(로그인 페이지로 리다이렉트)
//			result = false;
//			
//		} else {
//			result = true;
//			
//		}
//		return result;
//	}
//	
//	// 로그인 전에 있었던 페이지 경로를 남김
//	private void saveDestination(HttpServletRequest request) {
//		// URI + 쿼리스트링을 저장해야함
//		System.out.println("이전 경로 : " +  request.getRequestURI());
//		System.out.println("쿼리스트링 : " + request.getQueryString());
//		
//		String uri = request.getRequestURI();
//		String queryString = request.getQueryString();
//		
//		if (queryString == null) {
//			queryString = "";
//		} else {
//			queryString = "?" + queryString;
//		}
//		
//		System.out.println("로그인 후 이동할 페이지 : " + (uri + queryString));
//		
//		request.getSession().setAttribute("dest", (uri + queryString));
//	}
//	
//
//	
//
//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//			ModelAndView modelAndView) throws Exception {
//		// 로그인 하고나서. 
//		super.postHandle(request, response, handler, modelAndView);
//	}


}
