package com.bookdabang.ljs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.CustomerService;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.ProductQnA;
import com.bookdabang.common.domain.RecentSeenProd;
import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.ljs.domain.LoginDTO;
import com.bookdabang.ljs.persistence.MyPageDAO;

@Service
public class MyPageServiceImpl implements MyPageService {

	@Inject
	private MyPageDAO mdao;
	
	
	@Override
	public List<RecentSeenProd> showRecentSeenProd(String userId) throws Exception {
		
		return mdao.showRecentSeenProd(userId);
	}


	@Override
	public int modifyPassword(LoginDTO passwordID) throws Exception {
		
		return mdao.modifyPassword(passwordID);
	}
	
	@Override
	public String showOldPwd(String userId) throws Exception {
		
		return mdao.showOldPwd(userId);
	}


	@Override
	public List<FreeBoard> myFreeLst(String userId) throws Exception {
		// TODO Auto-generated method stub
		return mdao.myFreeLst(userId);
	}


	@Override
	public List<ReviewVO> myReviewLst(String userId) throws Exception {
		 
		return mdao.myReviewLst(userId);
	}


	@Override
	public List<ProductQnA> myQnALst(String userId) throws Exception {
		 
		return mdao.myQnALst(userId);
	}


	@Override
	public List<CustomerService> myCSLst(String userId) throws Exception {
		// TODO Auto-generated method stub
		return mdao.myCSLst(userId);
	}


	@Override
	public int delMyCSPosts(List<Integer> postNo) throws Exception {
		
		return mdao.delMyCSPosts(postNo);
	}


	@Override
	public List<MemberPoint> showTotalPoint(String userId) throws Exception {
		
		return mdao.showTotalPoint(userId);
	}


	@Override
	public List<FreeBoard> showMyLike(String userId) throws Exception {
		
		return mdao.showMyLike(userId);
	}
	
	

}
