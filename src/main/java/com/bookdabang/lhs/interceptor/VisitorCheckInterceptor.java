package com.bookdabang.lhs.interceptor;

import java.sql.Timestamp;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bookdabang.common.etc.IPCheck;
import com.bookdabang.common.service.IPCheckService;

public class VisitorCheckInterceptor extends HandlerInterceptorAdapter {


	@Inject
	private IPCheckService service;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		try {
			String ipaddr = IPCheck.getIPAddr(request);
			System.out.println("인터셉트 작동합니다" + ipaddr);
	
			Timestamp lastAccessTime = service.checkMaxAccessDate(ipaddr);
			long currentTime = System.currentTimeMillis();
			
			if(lastAccessTime != null) {
				//System.out.println(longlat+" , "+currentTime);
				long longlat = lastAccessTime.getTime();
				if((currentTime - longlat ) > 1000 * 60*60*24) {//같은 아이피로 방문하면 하루에 한번만 최초방문시간 체크
					int result = service.insertAccessDate(ipaddr);
					System.out.println("24시간 이후 재방문 고객님 : "+result);
				}else {
					System.out.println("24시간 이내 재방문한건 세지 않습니다");
				}
			}else {
				int result = service.insertAccessDate(ipaddr);
				System.out.println("처음 방문한 고객님 : "+result);
			}
			
	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
