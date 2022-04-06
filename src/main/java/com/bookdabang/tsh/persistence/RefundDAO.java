package com.bookdabang.tsh.persistence;

import java.util.List;

import com.bookdabang.common.domain.Refund;

public interface RefundDAO {

	public List<Refund> selectAllRefund() throws Exception;
}
