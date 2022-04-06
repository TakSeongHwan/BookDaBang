package com.bookdabang.kmj.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.Review;
import com.bookdabang.common.domain.ReviewComment;
import com.bookdabang.kmj.persistence.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	private ReviewDAO dao;
	
	@Override
	public List<Review> readAllReview(int prodNo) throws Exception {
		List<Review> lst = dao.selectAllReview(prodNo);
		return lst;
	}

	@Override
	public List<ReviewComment> readAllComments(int rno) throws Exception {
		List<ReviewComment> lst = dao.selectAllComments(rno);
		return lst;
	}

}