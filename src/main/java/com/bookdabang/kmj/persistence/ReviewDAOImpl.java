package com.bookdabang.kmj.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.RecommendVO;
import com.bookdabang.common.domain.ReviewComment;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	
	@Inject
	private SqlSession ses; // SqlSessionTemplete 객체 주입
	
	private static String ns = "com.bookdabang.mapper.ReviewMapper"; // mapper의 namespace
	
	@Override
	public List<ReviewVO> selectAllReview(int prodNo,PagingInfo pi) throws Exception {
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("prodNo", prodNo);
		param.put("startNum", pi.getStartNum());
		param.put("postPerPage", pi.getPostPerPage());
		
		return ses.selectList(ns + ".selectAllReview", param);
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
	public List<Integer> selectRecommend(String userId) throws Exception {
		return ses.selectList(ns + ".selectRecommend", userId);
	}

	@Override
	public int updateRecommend(RecommendVO recommend) {
		return ses.update(ns + ".updateRecommend", recommend);
	}
	
	@Override
	public int insertRecommend(RecommendVO recommend) throws Exception {
		return ses.insert(ns + ".insertRecommend", recommend);
	}

	@Override
	public int deleteRecommend(RecommendVO recommend) throws Exception {
		return ses.delete(ns + ".deleteRecommend", recommend);
	}

	@Override
	public int insertReview(ReviewVO review) throws Exception {
		return ses.insert(ns + ".insertReview", review);
	}

	@Override
	public int updateReview(ReviewVO review) throws Exception {
		return ses.update(ns + ".updateReview", review);
	}

	@Override
	public int deleteReview(int reviewNo) throws Exception {
		return ses.delete(ns + ".deleteReview", reviewNo);
	}

	@Override
	public int updateComment(ReviewComment comment) throws Exception {
		return ses.update(ns + ".updateComment", comment);
	}

	@Override
	public int deleteComment(int cno) throws Exception {
		return ses.delete(ns + ".deleteComment", cno);
	}

	@Override
	public int updateCommentNum2(int reviewNo) throws Exception {
		return ses.update(ns + ".updateCommentNum2", reviewNo);
	}

	@Override
	public int selectReviewNo() throws Exception {
		return ses.selectOne(ns + ".selectReviewNo");
	}

	@Override
	public int insertAttachFile(AttachFileVO attachFileVO) throws Exception {
		return ses.insert(ns + ".insertAttachfile", attachFileVO);
	}

	@Override
	public List<AttachFileVO> selectAllAttachFile(int prodNo) throws Exception {
		return ses.selectList(ns + ".selectAllAttachfile",prodNo);
	}

	@Override
	public int deleteAttachFile(int attachFileNo) throws Exception {
		return ses.delete(ns + ".deleteAttachfile", attachFileNo);
	}

	@Override
	public int getTotalPost(int prodNo) throws Exception {
		return ses.selectOne(ns + ".selectTotalPost",prodNo);
	}


}
