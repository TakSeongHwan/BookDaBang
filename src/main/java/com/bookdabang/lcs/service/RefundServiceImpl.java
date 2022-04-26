
package com.bookdabang.lcs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

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
	public List<Refund> adminRefundList() throws Exception {
		return refundDAO.adminRefundList();
	}

	@Override
	public boolean refundUpdate(int refundNo) throws Exception {
		boolean result = false;
		if(refundDAO.refundUpdate(refundNo) == 1) {
			int orderNo = refundDAO.getOrderNo(refundNo);
			orderDAO.updateOrderState(5, orderNo);
			result = true;
		}
		
		return result;
	}

}
