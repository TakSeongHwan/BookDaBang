package com.bookdabang.tsh.service;

import java.util.List;

import com.bookdabang.common.domain.Refund;

public interface RefundService {

	public List<Refund> selectAllRefund() throws Exception;
}
