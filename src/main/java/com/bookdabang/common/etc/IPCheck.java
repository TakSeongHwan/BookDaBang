package com.bookdabang.common.etc;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.bookdabang.common.service.IPCheckService;
import com.bookdabang.common.service.IPCheckServiceImpl;

public class IPCheck {
   private static String ipAddr;


	public static String getIPAddr(HttpServletRequest request) throws Exception {

//		URL ipcheck = new URL("http://checkip.amazonaws.com");
//		BufferedReader buffReader = new BufferedReader(new InputStreamReader(ipcheck.openStream()));
//		ipAddr = buffReader.readLine();

		request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

		ipAddr = request.getHeader("X-Forwarded-For");

		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getHeader("Proxy-Client-IP");
		}
		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getHeader("X-Real-IP");
		}
		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getHeader("X-RealIP");
		}
		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getHeader("REMOTE_ADDR");
		}
		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getRemoteAddr();
		}

		HttpSession session = request.getSession();
		session.setAttribute("ipAddr", ipAddr);
		System.out.println("세션에 들어가있는 ip주소 " + session.getAttribute("ipAddr"));
		return ipAddr;

	}

}
