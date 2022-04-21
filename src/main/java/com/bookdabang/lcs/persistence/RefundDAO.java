
package com.bookdabang.lcs.persistence;

import java.util.List;

import com.bookdabang.common.domain.Refund;



public interface RefundDAO {

	//환불 리스트(로그인)
	public List<Refund> refundList() throws Exception;
	// 환불 리스트(관리자)
	public List<Refund> adminRefundList() throws Exception;
	// 환불 상태(버튼)
	public int refundUpdate() throws Exception;
	
}
