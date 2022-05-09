package com.bookdabang.ljs.service;

import java.util.List;

import com.bookdabang.common.domain.CustomerService;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.ProductQnA;
import com.bookdabang.common.domain.RecentSeenProd;
import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.ljs.domain.LoginDTO;
import com.bookdabang.ljs.domain.modifyDTO;

public interface MyPageService {
	
	public List<RecentSeenProd> showRecentSeenProd(String userId) throws Exception; 
	
	public int modifyPassword(LoginDTO passwordID) throws Exception;

	public String showOldPwd(String userId) throws Exception;
	
	public List<FreeBoard> myFreeLst(String userId) throws Exception;
	
	public List<ReviewVO> myReviewLst(String userId) throws Exception;

	public List<ProductQnA> myQnALst(String userId)throws Exception;

	public List<CustomerService> myCSLst(String userId)throws Exception;

	public int delMyCSPosts(List<Integer> postNo) throws Exception;
	
	public List<MemberPoint> showTotalPoint(String userId) throws Exception;
	
	public List<FreeBoard> showMyLike(String userId) throws Exception;

	public int modifyMemInfo(modifyDTO mdto)throws Exception;

}
