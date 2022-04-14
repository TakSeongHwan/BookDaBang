package com.bookdabang.kmj.persistence;

import java.util.List;

import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.common.domain.ReviewComment;

public interface ReviewDAO {
	// n번 상품의 리뷰들 가져오는 메서드
	public List<ReviewVO> selectAllReview (int prodNo) throws Exception;
	
	// n번 리뷰의 댓글들 가져오는 메서드
	public List<ReviewComment> selectAllComments(int rno) throws Exception;
	
	// 다음 댓글 번호 가져오는 메서드
	public int selectNextRef() throws Exception;
	
	// n번 리뷰의 댓글 추가하는 메서드
	public int insertComment(ReviewComment comment) throws Exception;
	
	// n번 리뷰의 댓글 수 추가하는 메서드
	public int updateCommentNum (int reviewNo) throws Exception;
	
	// 최신순 정렬 위해 이전 답글 변경하는 메서드
	public int updatePrevReply (ReviewComment comment) throws Exception;
	
	// 답글 추가하는 메서드
	public int insertReply (ReviewComment comment) throws Exception;
	
	// n번 리뷰의 추천수 바꿔주는 메서드 
	public int updateRecommend(int reviewNo, int change) throws Exception;
	
	// 리뷰 추가하는 메서드
	public int insertReview(ReviewVO review) throws Exception;
}
