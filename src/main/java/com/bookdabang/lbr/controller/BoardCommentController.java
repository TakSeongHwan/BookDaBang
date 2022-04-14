package com.bookdabang.lbr.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookdabang.common.domain.FreeBoardComment;
import com.bookdabang.lbr.service.FreeBoardService;

@Controller
@RequestMapping(value = "/comment")
public class BoardCommentController {

	
	@Inject
	private FreeBoardService service;
	
	@RequestMapping(value = "" , method = RequestMethod.POST)
	public ResponseEntity<String> insertComment(@RequestBody FreeBoardComment comment ) {
		System.out.println("댓글등록" + comment.toString());
		
		ResponseEntity<String> result = null;
		
		try {
			service.insertComment(comment);
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return result;
	}
	
	
	@RequestMapping(value = "/read/{boardno}", method = RequestMethod.GET)
	public ResponseEntity<List<FreeBoardComment>> readComment(@PathVariable("boardno") int boardno){
		System.out.println("댓글보기" + boardno);
		
		ResponseEntity<List<FreeBoardComment>> result = null;
		
		try {
			List<FreeBoardComment> lst = service.readComment(boardno);
			if(lst.size() < 1) {
				lst = null;
			}
			result = new ResponseEntity<List<FreeBoardComment>>(lst, HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		
		return result;
		
	}
	
	@RequestMapping(value = "/{cno}", method = RequestMethod.PUT)
	public ResponseEntity<String> modiComment(@RequestBody FreeBoardComment comment){
		System.out.println(comment.getCommentno() + "번댓글 수정" + comment.toString());
		
		ResponseEntity<String> result = null;
		
		try {
			service.modiComment(comment);
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return result;
		
	}
	
	@RequestMapping(value = "/{cno}", method = RequestMethod.DELETE)
	public ResponseEntity<String> delComment(@PathVariable("cno") int cno) {
		System.out.println(cno + "삭제");
		
		ResponseEntity<String> result = null;
		
		try {
			service.delComment(cno);
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		return result;
		
	}
}
