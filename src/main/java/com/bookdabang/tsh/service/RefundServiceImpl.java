package com.bookdabang.tsh.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.Refund;
import com.bookdabang.tsh.persistence.RefundDAO;

@Service
public class RefundServiceImpl implements RefundService {

	@Inject
	private RefundDAO dao;
	
	@Override
	public List<Refund> selectAllRefund() throws Exception {
		return dao.selectAllRefund();
	}


}
