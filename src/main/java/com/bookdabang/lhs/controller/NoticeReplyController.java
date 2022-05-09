package com.bookdabang.lhs.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bookdabang.common.domain.NoticeReplyVO;
import com.bookdabang.lhs.service.NoticeService;


@RestController
@RequestMapping("/noticeReply/*")
public class NoticeReplyController {
	
	@Inject
	NoticeService service;
	
	@RequestMapping(value="/all/{boardNo}", method = RequestMethod.GET)
	public ResponseEntity<List<NoticeReplyVO>> getEntiresReplies(@PathVariable("boardNo") int boardNo) {
		System.out.println("공지사항" +boardNo);
		
		ResponseEntity<List<NoticeReplyVO>> result = null;
		List<NoticeReplyVO> list = new ArrayList<NoticeReplyVO>();
		try {
			list = service.getAllReply(boardNo);
			System.out.println(list);
			result = new ResponseEntity<List<NoticeReplyVO>>(list, HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			result = new ResponseEntity<List<NoticeReplyVO>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return result;
		
	}

	@RequestMapping(value="addReply", method=RequestMethod.POST)
	public ResponseEntity<String> addReply(@RequestBody NoticeReplyVO reply ){
		ResponseEntity<String> result = null;
		System.out.println("댓글 : "+ reply.toString());
		
		try {
			int maxReplyNo = service.getMaxReplyNo();
			int ref = service.getMaxReplyNo()+1;
			reply.setRef(ref);
			reply.setStep(0);
			reply.setRefOrder(0);
			System.out.println(reply);
			if(service.insertReply(reply) == 1) {
				service.replyCountIncrese(reply.getBoardNo());
				result = new ResponseEntity<String>("success",HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return result;
		
		
	}
	
	@RequestMapping(value="/{replyNo}",method=RequestMethod.PUT)
	public @ResponseBody String modiReply(@RequestBody NoticeReplyVO nr){
		String result = null;

		try {
			service.updateReply(nr);
			result = "success";
			
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping(value = "/{replyNo}", method=RequestMethod.DELETE)
	public ResponseEntity<String> delReply(@PathVariable("replyNo") int replyNo){
		ResponseEntity<String> result = null;
		
		try {
			int no = service.getBoardNoByReplyNo(replyNo).getBoardNo();
			if(service.deleteReply(replyNo) == 1) {
				System.out.println(no);
				service.replyCountDecrease(no);
				result = new ResponseEntity<String>("success",HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return result;
		
	}
	@RequestMapping(value="rereply", method=RequestMethod.POST)
	public ResponseEntity<String> addRereply(@RequestBody NoticeReplyVO reply){
		ResponseEntity<String> result = null;
		
		try {
			NoticeReplyVO nr = service.getBoardNoByReplyNo(reply.getReplyNo());
			reply.setRef(nr.getRef());
			reply.setStep(nr.getStep() +1);
			reply.setRefOrder(nr.getRefOrder()+1);
			
			System.out.println(reply.toString());
			service.insertReply(reply);
			service.replyCountIncrese(reply.getBoardNo());
			result = new ResponseEntity<String>("success",HttpStatus.OK);
			
		} catch (Exception e) {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		
		return result;
		
	}
	
}
