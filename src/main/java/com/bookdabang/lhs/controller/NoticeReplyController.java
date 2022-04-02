package com.bookdabang.lhs.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bookdabang.common.domain.NoticeReply;
import com.bookdabang.lhs.service.NoticeService;


@RestController
@RequestMapping("/noticeReply/*")
public class NoticeReplyController {
	
	@Inject
	NoticeService service;
	
	@RequestMapping(value="/all/{boardNo}", method = RequestMethod.GET)
	public ResponseEntity<List<NoticeReply>> getEntiresReplies(@PathVariable("boardNo") int boardNo) {
		System.out.println("공지사항" +boardNo);
		
		ResponseEntity<List<NoticeReply>> result = null;
		List<NoticeReply> list = new ArrayList<NoticeReply>();
		try {
			list = service.getAllReply(boardNo);
			System.out.println(list);
			result = new ResponseEntity<List<NoticeReply>>(list, HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			result = new ResponseEntity<List<NoticeReply>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return result;
		
	}

	@RequestMapping(value="addReply", method=RequestMethod.POST)
	public ResponseEntity<String> addReply(@RequestBody NoticeReply reply ){
		ResponseEntity<String> result = null;
		System.out.println("댓글 : "+ reply.toString());
		try {
			if(service.insertReply(reply) == 1) {
				result = new ResponseEntity<String>("success",HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return result;
		
		
	}
	
}
