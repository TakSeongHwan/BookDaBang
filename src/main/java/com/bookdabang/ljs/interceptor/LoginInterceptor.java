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


// 컨트롤러 실행하기 전에
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		System.out.println("이거는 안되나?");
		// 경로 저장 : 컨트롤러에 있음
		HttpSession ses = request.getSession();

		System.out.println("뭐죠 이건? 리퀘스트 헤더(preHandle) : " + request.getHeaders("Re"));
	
			//if (ses.getAttribute("loginMember") != null) { // 만약 쿠키는 없고, 로긴은 되어있다면

				System.out.println("일단 로그인한 기록(세션) 삭제합니다..");
				ses.removeAttribute("sessionId");
			//}

		

		return true; // 이거 없으면 진행 안됨
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		ModelMap modelMap = modelAndView.getModelMap();
		System.out.println("null 체크" +(MemberVO)modelMap.get("loginMember"));
		MemberVO loginMember = (MemberVO) modelMap.get("loginMember");
		// loginPage에서 model 객체에 바인딩한 loginMember 객체를
																		// 얻어옴.
		System.out.println("postHandle : " + loginMember);
		
		HttpSession ses = request.getSession();

		if (loginMember != null) {

			System.out.println("로그인 됐나요?ㅎㅎ");
			ses.setAttribute("sessionId", loginMember.getSessionId()); // 세션 객체에 로그인 유저 정보 바인딩

			System.out.println(request.getParameter("autoLogin"));

			// 자동로그인에 체크한 다음 로그인 했을 때
			if (request.getParameter("autoLogin") != null) {
				Cookie BookDBCook = new Cookie("BookDBCookie", loginMember.getSessionId()); // 북다방 쿠키에 세션키 저장 
				BookDBCook.setMaxAge(60 * 60 * 24); // 쿠키 만료시간을 2분으로 . 60*60*24*7
				BookDBCook.setPath("/");
				response.addCookie(BookDBCook);
			}

			// response.sendRedirect("/"); // index.jsp로 리다이렉트
			String prePage = (String) ses.getAttribute("prePage");
			System.out.println("로그인 이전 경로 : " + prePage);
			ses.setMaxInactiveInterval(-1);
			
	
			if (prePage != null) {
				System.out.println("이전 페이지");
				//response.sendRedirect(prePage);
				
			} else {
				System.out.println("홈으로");
				//response.sendRedirect("/ljs/");
				
			}

		} else {
			System.out.println("로그인 실패");
			response.sendRedirect("login?status=fail");
		}
		
	}
	
}
