package com.bookdabang.ljs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.CustomerService;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.ProductQnA;
import com.bookdabang.common.domain.RecentSeenProd;
import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.ljs.domain.LoginDTO;
import com.bookdabang.ljs.domain.modifyDTO;

@Repository
public class MyPageDAOImpl implements MyPageDAO {
	
	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.memberMapper";
	private static String nsFreeBoard = "com.bookdabang.mapper.boardMapper";
	private static String nsReviewBoard = "com.bookdabang.mapper.ReviewMapper";
	private static String nsProductQnA = "com.bookdabang.mapper.productMapper";
	private static String nsCSBoard = "com.bookdabang.mapper.csBoardMapper";
	
	//selectMyQnA
	
	@Override
	public List<RecentSeenProd> showRecentSeenProd(String userId) throws Exception {
		return ses.selectList(ns + ".showRecentSeenProd", userId);
	}

	@Override
	public int modifyPassword(LoginDTO passwordID) throws Exception {
		return ses.update(ns+ ".updatePassword", passwordID);
	}

	@Override
	public String showOldPwd(String userId) throws Exception {
		
		return ses.selectOne(ns + ".showOldPwd", userId);
	}

	@Override
	public List<FreeBoard> myFreeLst(String userId) throws Exception {
		 
		return ses.selectList(nsFreeBoard + ".showPostFree", userId);
	}

	@Override
	public List<ReviewVO> myReviewLst(String userId) throws Exception {
		
		return ses.selectList(nsReviewBoard + ".showMyReview", userId);
	}

	@Override
	public List<ProductQnA> myQnALst(String userId) throws Exception {
		
		return ses.selectList(nsProductQnA + ".showMyQnA", userId);
	}

	@Override
	public List<CustomerService> myCSLst(String userId) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(nsCSBoard + ".showMyCS", userId);
	}

	@Override
	public int delMyCSPosts(List<Integer> postNo) throws Exception {
		// TODO Auto-generated method stub
		return ses.delete(nsCSBoard + ".deleteMyCS", postNo);
	}

	@Override
	public List<MemberPoint> showTotalPoint(String userId) throws Exception {
		
		return ses.selectList(ns + ".myTotalPoint", userId);
	}

	@Override
	public List<FreeBoard> showMyLike(String userId) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(nsFreeBoard + ".showMylike" , userId);
	}

	@Override
	public int modifyMemInfo(modifyDTO mdto) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns + ".updateMemInfo", mdto);
		
	}

}
