
package com.bookdabang.lcs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.Refund;
import com.bookdabang.lcs.persistence.RefundDAO;

@Service
public class RefundServiceImpl implements RefundService{

	@Inject 
	private RefundDAO refundDAO;
	
	@Override
	public List<Refund> refundList() throws Exception {
		return refundDAO.refundList();
	}

	@Override
	public List<Refund> adminRefundList() throws Exception {
		return refundDAO.adminRefundList();
	}

	@Override
	public boolean refundUpdate() throws Exception {
		boolean result = false;
		if(refundDAO.refundUpdate() == 1) {
			result = true;
		}
		
		return result;
	}

}
