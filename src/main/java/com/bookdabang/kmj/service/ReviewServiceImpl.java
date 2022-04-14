package com.bookdabang.kmj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.common.domain.ReviewComment;
import com.bookdabang.kmj.persistence.ReviewDAO;
import com.bookdabang.ljs.persistence.LoginDAO;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	private ReviewDAO rDao;
	
	@Inject
	private LoginDAO lDao;
	
	@Override
	public List<ReviewVO> readAllReview(int prodNo) throws Exception {
		List<ReviewVO> lst = rDao.selectAllReview(prodNo);
		return lst;
	}

	@Override
	public List<ReviewComment> readAllComments(int rno) throws Exception {
		List<ReviewComment> lst = rDao.selectAllComments(rno);
		return lst;
	}

	@Override
	public boolean addReply(ReviewComment comment) throws Exception {
		// 세션아이디를 유저아이디로 변환
		MemberVO member = lDao.findLoginSess(comment.getCommenter());
		comment.setCommenter(member.getUserId());
		
		boolean result = false;
		
		if (comment.getRef() == 0) {
			// 다음 답글 번호 가져와 ref 설정
			comment.setRef(rDao.selectNextRef());
			
			// 리뷰 댓글 개수 업데이트 후 댓글 추가
			if (rDao.updateCommentNum(comment.getReviewNo()) == 1) {
				if(rDao.insertComment(comment) == 1) {
					result = true;
				}
			}
			
		} else {
			// 답글 깊이(레벨)가 같은 글에 대해 최신 답글이 더 위로 올라오도록 정렬 (이전 답글이 있을 때 바뀜
			rDao.updatePrevReply(comment);
			if (rDao.updateCommentNum(comment.getReviewNo()) == 1) {
				if (rDao.insertReply(comment) == 1) {
					result = true;
				}
			}	
		}
		
		return result;
	}

	@Override
	public boolean addRecommend(int reviewNo, int change) throws Exception {
		boolean result = false;
		if (rDao.updateRecommend(reviewNo,change) == 1 ) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean addReview(ReviewVO review) throws Exception {
		// 세션아이디를 유저아이디로 변환
		MemberVO member = lDao.findLoginSess(review.getWriter());
		review.setWriter(member.getUserId());
				
		boolean result = false;
		
		if (rDao.insertReview(review) == 1) {
			result = true;
		}
		
		return result;
	}

}
