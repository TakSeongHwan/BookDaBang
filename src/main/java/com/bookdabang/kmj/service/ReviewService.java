package com.bookdabang.kmj.service;

import java.util.List;

import com.bookdabang.common.domain.Review;
import com.bookdabang.common.domain.ReviewComment;

public interface ReviewService {
	// n번 상품의 리뷰들 가져오기
	public List<Review> readAllReview (int prodNo) throws Exception;
	
	// n번 리뷰의 댓글들 가져오기
	public List<ReviewComment> readAllComments (int rno) throws Exception;
}
