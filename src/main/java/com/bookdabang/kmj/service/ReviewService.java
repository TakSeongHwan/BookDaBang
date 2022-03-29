package com.bookdabang.kmj.service;

import java.util.List;

import com.bookdabang.common.domain.Review;

public interface ReviewService {
	// n번 상품의 리뷰들 가져오기
	public List<Review> readAllReview (int prodNo) throws Exception;
}
