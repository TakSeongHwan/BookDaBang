package com.bookdabang.kmj.persistence;

import java.util.List;

import com.bookdabang.common.domain.Review;
import com.bookdabang.common.domain.ReviewComment;

public interface ReviewDAO {
	// n번 상품의 리뷰들 가져오는 메서드
	public List<Review> selectAllReview (int prodNo) throws Exception;
	
	// n번 리뷰의 댓글들 가져오는 메서드
	public List<ReviewComment> selectAllComments(int rno) throws Exception;
}
