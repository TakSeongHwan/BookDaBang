package com.bookdabang.common.etc;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

public class IPCheck {
	private static String ipAddr;

	
	/**
	 * @Method name : getIPAddr
	 * @작성일 : 2022. 3. 25.
	 * @작성자 : 이한솔
	 * @변경이력 : 
	 * @Method 설명: IP주소를 체크하여 반환
	 */
	
	public static String getIPAddr() throws Exception {

		URL ipcheck = new URL("http://checkip.amazonaws.com");
		BufferedReader buffReader = new BufferedReader(new InputStreamReader(ipcheck.openStream()));
		ipAddr = buffReader.readLine();
		return ipAddr;

	}
}
