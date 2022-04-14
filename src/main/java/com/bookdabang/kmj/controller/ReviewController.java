package com.bookdabang.kmj.controller;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.kmj.service.ReviewService;

@Controller 
@RequestMapping("/review")
public class ReviewController {
	
	@Inject
	private ReviewService rService;
	
	@RequestMapping(value="", method=RequestMethod.POST)
	public String addReview(ReviewVO review,RedirectAttributes rttr) throws Exception {
		System.out.println("리뷰 등록 시작!" + review.toString());
		
		if (rService.addReview(review)) {
			rttr.addFlashAttribute("result", "success");
		} else {
			rttr.addFlashAttribute("result", "fail");
		}
		
		return "redirect:/product/detail?no=" + review.getProductNo();
		
	}
	
	@RequestMapping(value = "/like", method=RequestMethod.GET)
	public ResponseEntity<String> reviewLike (@RequestParam("no") String no,@RequestParam("change") String ch) {
		int reviewNo = Integer.parseInt(no);
		int change = Integer.parseInt(ch);
		
		ResponseEntity<String> result = null;
		
		try {
			if (rService.addRecommend(reviewNo,change)) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		System.out.println(result);
		return result;
		
	}
}
