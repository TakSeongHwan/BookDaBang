package com.bookdabang.tsh.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bookdabang.common.domain.AddressVO;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.tsh.service.AddressService;

@RestController
@RequestMapping("/address/*")
public class AddressController {
	
	@Inject
	private AddressService service;
	
	@RequestMapping(value = "/all",method = RequestMethod.GET)
	public ResponseEntity<AddressVO> getAddress(HttpSession ses){
		MemberVO loginMember = (MemberVO) ses.getAttribute("loginMember"); 
		ResponseEntity<AddressVO> result = null;
		AddressVO addr =null; 
		if(loginMember != null) {
			try {
				addr = service.selectUserAddress(loginMember.getUserId());
				if(addr != null) {
					result = new ResponseEntity<AddressVO>(addr,HttpStatus.OK);
				}
			} catch (Exception e) {
				e.printStackTrace();
				result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
		}		
		return result;
	}
	
	@RequestMapping(value = "/{addressNo}",method = RequestMethod.PUT)
	public ResponseEntity<String> updateAddress(@RequestBody AddressVO address) {
		ResponseEntity<String> result = null;
		System.out.println(address);
		try {
			if(service.updateAddress(address)==1) {
				result = new ResponseEntity<String>("success",HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> insertAddress(@RequestBody AddressVO address){
		ResponseEntity<String> result = null;
		try {
			if(service.insertAddress(address)==1) {
				result = new ResponseEntity<String>("success",HttpStatus.OK);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return result;
	}

}
