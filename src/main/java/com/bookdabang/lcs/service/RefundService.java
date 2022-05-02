
package com.bookdabang.lcs.service;

import java.util.List;
import java.util.Map;

import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.Refund;

public interface RefundService {

	public List<Refund> refundList(String sessionId) throws Exception;
	
	public Map<String, Object> adminRefundList(int pageNo) throws Exception;
	
	public boolean refundUpdate(int refundNo) throws Exception;
	
	public boolean insertRefund(Refund refund) throws Exception;
	
}
