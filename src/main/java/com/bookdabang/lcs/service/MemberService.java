
package com.bookdabang.lcs.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.lcs.domain.MemberDTO;

public interface MemberService {
	public boolean insertMember(MemberDTO member) throws Exception;
	
	public boolean userIdCheck(String userId) throws Exception;
	
	public boolean nickNameCheck(String nickName) throws Exception;

	public void insertEmailCode(HttpServletRequest request, HttpServletResponse response, String userEmail) throws Exception;
	
	public void confirmEmailCode(HttpServletRequest request, HttpServletResponse response, String confirmCode) throws Exception;
	
	
	

}
