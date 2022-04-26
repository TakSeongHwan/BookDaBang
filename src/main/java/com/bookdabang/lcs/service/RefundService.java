
package com.bookdabang.lcs.service;

import java.util.List;

import com.bookdabang.common.domain.Refund;

public interface RefundService {

	public List<Refund> refundList(String sessionId) throws Exception;
	
	public List<Refund> adminRefundList() throws Exception;
	
	public boolean refundUpdate(int refundNo) throws Exception;
}
