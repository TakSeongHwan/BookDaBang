package com.bookdabang.common.etc;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class IPCheck {
	private static String ipAddr;

	
	/**
	 * @Method name : getIPAddr
	 * @작성일 : 2022. 3. 25.
	 * @작성자 : 이한솔
	 * @변경이력 : 
	 * @Method 설명: IP주소를 체크하여 반환
	 */
	
	public static String getIPAddr(HttpServletRequest request) throws Exception {

		URL ipcheck = new URL("http://checkip.amazonaws.com");
		BufferedReader buffReader = new BufferedReader(new InputStreamReader(ipcheck.openStream()));
		ipAddr = buffReader.readLine();
		HttpSession session = request.getSession();
		session.setAttribute("ipAddr", ipAddr);
		//System.out.println("세션에 들어가있는 ip주소 " +session.getAttribute("ipAddr"));
		return ipAddr;

	}
	
}
