package com.bookdabang.kmj.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.Review;
import com.bookdabang.common.domain.ReviewComment;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	
	@Inject
	private SqlSession ses; // SqlSessionTemplete 객체 주입
	
	private static String ns = "com.bookdabang.mapper.ReviewMapper"; // mapper의 namespace
	
	@Override
	public List<Review> selectAllReview(int prodNo) throws Exception {
		return ses.selectList(ns + ".selectAllReview", prodNo);
	}

	@Override
	public List<ReviewComment> selectAllComments(int rno) throws Exception {
		return ses.selectList(ns + ".selectAllComments", rno);
	}

}
