package com.bookdabang.kmj.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bookdabang.common.domain.ReviewComment;
import com.bookdabang.kmj.service.ReviewService;

@RestController // 현재 클래스가 REST방식의 컨트롤러임을 명시 // rest방식은 쿼리스트링이 안먹는다
@RequestMapping("/comment/*")
public class CommentController {
	
	@Inject
	private ReviewService rService;
	
	@RequestMapping(value = "/all/{rno}", method = RequestMethod.GET)
	public ResponseEntity<List<ReviewComment>> getAllComments(@PathVariable("rno") int rno) {
		System.out.println("리뷰 번호 : " + rno + "의 모든 댓글을 가져와 출력하자");
		
		ResponseEntity<List<ReviewComment>> result = null;
		
		try {
			List<ReviewComment> lst = rService.readAllComments(rno);
			if(lst.size() < 1) {
				lst = null;
			}
			result = new ResponseEntity<List<ReviewComment>>(lst, HttpStatus.OK);	
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);	
		}
		
		return result;
	}
}