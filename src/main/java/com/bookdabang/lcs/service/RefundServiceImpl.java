
package com.bookdabang.lcs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.Refund;
import com.bookdabang.lcs.persistence.RefundDAO;
import com.bookdabang.ljs.persistence.LoginDAO;
import com.bookdabang.tsh.persistence.OrderDAO;

@Service
public class RefundServiceImpl implements RefundService{

	@Inject 
	private RefundDAO refundDAO;
	@Inject
	private LoginDAO loginDAO;
	@Inject
	private OrderDAO orderDAO;

	
	@Override
	public List<Refund> refundList(String sessionId) throws Exception {
		String userId = loginDAO.findLoginSess(sessionId).getUserId();
		return refundDAO.refundList(userId);
	}

	@Override
	public Map<String, Object> adminRefundList(int pageNo) throws Exception {
		int paging = refundDAO.paging();
		PagingInfo pi = pagingProcess(pageNo, paging);
		List<Refund> lst = refundDAO.adminRefundList(pageNo, pi);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pi", pi);
		map.put("lst", lst);
		System.out.println(map);
		
		return map;
	}

	@Override
	public boolean refundUpdate(int refundNo) throws Exception {
		boolean result = false;
		if(refundDAO.refundUpdate(refundNo) == 1) {
			int orderNo = refundDAO.getOrderNo(refundNo);
			orderDAO.updateOrderState(5, orderNo);
			orderDAO.confirmUpdate(orderNo);
			result = true;
		}
		
		return result;
	}

	@Override
	public boolean insertRefund(Refund refund) throws Exception {
		boolean result = false;
		if(refundDAO.insertRefund(refund) == 1) {
			result = true;
		}
		
		return result;
	}

	public PagingInfo pagingProcess(int pageNo, int totalPostCnt) throws Exception {
		PagingInfo paging = new PagingInfo();
		paging.setTotalPostCnt(totalPostCnt);
		paging.setTotalPage(paging.getTotalPostCnt());
		// 현재 페이지에서 출력 시작할 글번호
		paging.setStartNum(pageNo);
		// 전체 페이징 블럭 수
		paging.setTotalPagingBlock(paging.getTotalPage());
		// 현재 페이징 블럭
		paging.setCurrentPagingBlock(pageNo);
		// 현재 페이지에서의 시작 페이징블럭
		paging.setStartNoOfCurPagingBlock(paging.getCurrentPagingBlock());
		// 현재 페이지에서의 끝 페이징 블럭
		paging.setEndNoOfCurPagingBlock(paging.getStartNoOfCurPagingBlock());
		System.out.println(paging);
		return paging;
	}
	
	
	
}
