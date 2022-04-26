
package com.bookdabang.lcs.persistence;

import java.util.List;

import com.bookdabang.common.domain.Refund;



public interface RefundDAO {

	//환불 리스트(로그인)
	public List<Refund> refundList(String userId) throws Exception;
	// 환불 리스트(관리자)
	public List<Refund> adminRefundList() throws Exception;
	// 환불 상태(버튼)
	public int refundUpdate(int refundNo) throws Exception;
	/**
	 * @Method name : getOrderNo
	 * @작성일 : 2022. 4. 19.
	 * @작성자 : goott06
	 * @변경이력 :
	 * @Method 설명 : 
	 */
	public int getOrderNo(int refundNo) throws Exception;
	
}
