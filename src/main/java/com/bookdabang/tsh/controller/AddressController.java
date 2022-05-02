package com.bookdabang.tsh.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bookdabang.common.domain.AddressVO;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.service.LoginService;
import com.bookdabang.tsh.service.AddressService;

@RestController
@RequestMapping("/address/*")
public class AddressController {

	@Inject
	private AddressService service;
	@Inject
	private LoginService lservice;

	// 사용자의 주소를 가져옴
	@RequestMapping(value = "/all", method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> getAddress(HttpSession ses) {
		ResponseEntity<Map<String,Object>> result = new ResponseEntity<>(null, HttpStatus.OK);
		AddressVO addr = null;
		Map<String,Object> m = new HashMap<String, Object>();
		try {
			MemberVO loginMember = (MemberVO) lservice.findLoginSess((String) ses.getAttribute("sessionId"));
			
			if (loginMember != null) {
				addr = service.selectUserAddress(loginMember.getUserId());
				m.put("loginMember", loginMember);
				if (addr != null) {
					m.put("addr", addr);
					System.out.println(m);
					if (addr.getPostalcode().length() > 1) {
						result = new ResponseEntity<Map<String,Object>>(m, HttpStatus.OK);
					} else {
						result = new ResponseEntity<>(m, HttpStatus.OK);
					}
				} else {
					result = new ResponseEntity<>(m, HttpStatus.OK);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return result;
	}

}
