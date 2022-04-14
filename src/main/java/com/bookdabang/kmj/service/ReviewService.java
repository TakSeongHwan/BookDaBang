package com.bookdabang.kmj.service;

import java.util.List;

import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.common.domain.ReviewComment;

public interface ReviewService {
	// n번 상품의 리뷰들 가져오기
	public List<ReviewVO> readAllReview (int prodNo) throws Exception;
	
	// n번 리뷰의 댓글들 가져오기
	public List<ReviewComment> readAllComments (int rno) throws Exception;
	
	// n번 리뷰의 댓글 추가
	public boolean addReply (ReviewComment comment) throws Exception;
	
	// n번 리뷰의 추천수 증가/감소
	public boolean addRecommend(int reviewNo,int change) throws Exception;
	
	// 리뷰 추가하기
	public boolean addReview(ReviewVO review) throws Exception;
}
