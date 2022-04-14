package com.bookdabang.kmj.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.common.domain.ReviewComment;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	
	@Inject
	private SqlSession ses; // SqlSessionTemplete 객체 주입
	
	private static String ns = "com.bookdabang.mapper.ReviewMapper"; // mapper의 namespace
	
	@Override
	public List<ReviewVO> selectAllReview(int prodNo) throws Exception {
		return ses.selectList(ns + ".selectAllReview", prodNo);
	}

	@Override
	public List<ReviewComment> selectAllComments(int rno) throws Exception {
		return ses.selectList(ns + ".selectAllComments", rno);
	}
	
	@Override
	public int selectNextRef() throws Exception {
		return ses.selectOne(ns + ".selectNextRef");
	}

	@Override
	public int insertComment(ReviewComment comment) throws Exception {
		return ses.insert(ns + ".insertComment", comment);
	}

	@Override
	public int updateCommentNum(int reviewNo) throws Exception {
		return ses.update(ns + ".updateCommentNum", reviewNo);
	}

	@Override
	public int updatePrevReply(ReviewComment comment) throws Exception {
		return ses.update(ns + ".updatePrevReply", comment);
	}

	@Override
	public int insertReply(ReviewComment comment) throws Exception {
		return ses.insert(ns + ".insertReply", comment);
	}

	@Override
	public int updateRecommend(int reviewNo, int change) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("reviewNo", reviewNo);
		param.put("change", change);
		return ses.update(ns + ".updateRecommend", param);
	}

	@Override
	public int insertReview(ReviewVO review) throws Exception {
		return ses.insert(ns + ".insertReview", review);
	}

	

}
