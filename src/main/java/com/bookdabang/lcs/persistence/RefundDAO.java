
package com.bookdabang.lcs.persistence;

import java.util.List;

import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.Refund;



public interface RefundDAO {

	//환불 리스트(로그인)
	public List<Refund> refundList(String userId) throws Exception;
	// 환불 리스트(관리자)
	public List<Refund> adminRefundList(int pageNo, PagingInfo pi) throws Exception;
	// 환불 상태(버튼)
	public int refundUpdate(int refundNo) throws Exception;

	public int getOrderNo(int refundNo) throws Exception;
	
	public int insertRefund(Refund refund) throws Exception;
	
	public int paging() throws Exception;
	
	
}
