
package com.bookdabang.lcs.service;

import java.io.PrintWriter;
import java.util.UUID;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.lcs.domain.MemberDTO;
import com.bookdabang.lcs.etc.SendMail;
import com.bookdabang.lcs.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO memberDAO; // 객체 주입
	

	@Override
	public boolean insertMember(MemberDTO member) throws Exception {
		boolean result = false;
		int num = memberDAO.insertMember(member);
		MemberPoint point = new MemberPoint(member.getUserId(), 10, null, "회원가입", null);
		int r1 = memberDAO.insertPoint(point);
		
		
		System.out.println("insert 성공여부 :" + num);
		System.out.println("insert 성공여부 :" + r1);
		if (num != 0) {
			result = true;
		}

		return result;

	}

	@Override
	public boolean userIdCheck(String userId) throws Exception {
		MemberVO userIdCheck = null;
		userIdCheck = memberDAO.userIdCheck(userId);
		System.out.println(userIdCheck);
		boolean result = false;

		if(userIdCheck != null) {
			result = true;
		} 
		
		return result;
	}

	@Override
	public boolean nickNameCheck(String nickName) throws Exception {
		MemberVO nickNameCheck = null;
		nickNameCheck = memberDAO.nickNameCheck(nickName);
		boolean result = false;
		
		if(nickNameCheck != null) {
			result = true;
		}
		return result;
		
	}

	@Override
	public void insertEmailCode(HttpServletRequest request, HttpServletResponse response, String userEmail) throws Exception {
		response.setContentType("application/json; charset=utf-8;");
		PrintWriter out = response.getWriter();

		String sendMailAddr = userEmail;
		System.out.println("인증 코드 보낼 메일 주소 : " + sendMailAddr);
		
		String confirmCode = UUID.randomUUID().toString();
		System.out.println("인증 코드 : " + confirmCode);
		
		HttpSession ses = request.getSession();
		ses.setAttribute("confirmCode", confirmCode);
		try {
			SendMail.send(sendMailAddr, confirmCode);
			JSONObject json = new JSONObject();
			json.put("status", "success");
			out.print(json);

		}catch (MessagingException e) {
			  JSONObject json = new JSONObject();
		      json.put("status", "fail");
		      json.put("errMsg", e.getMessage());
		      out.print(json);
		}

	}

	@Override
	public void confirmEmailCode(HttpServletRequest request, HttpServletResponse response, String confirmCode)
			throws Exception {
		response.setContentType("application/json; charset=utf-8;");
		PrintWriter out = response.getWriter();
		
		String userCode = request.getParameter("confirmCode");
		HttpSession ses = request.getSession();
		confirmCode = (String)ses.getAttribute("confirmCode");
		JSONObject json = new JSONObject();
		if(userCode.equals(confirmCode)) {
			json.put("status", "success");
		} else {
			json.put("status", "fail");
		}
		out.print(json);
		
	}




	}
	


