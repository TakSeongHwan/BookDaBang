package com.bookdabang.common.service;

import java.sql.Timestamp;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.VisitorIPCheck;
import com.bookdabang.common.persistence.IPCheckDAO;
import com.bookdabang.common.persistence.IPCheckDAOImpl;

@Service
public class IPCheckServiceImpl implements IPCheckService {
	
	@Inject
	IPCheckDAO ipDAO;

	@Override
	public Timestamp checkMaxAccessDate(String ipaddr) throws Exception {
		// TODO Auto-generated method stub
		return ipDAO.checkMaxAccessDate(ipaddr);
	}

	@Override
	public int insertAccessDate(String ipaddr) throws Exception {
		// TODO Auto-generated method stub
		return ipDAO.insertAccessDate(ipaddr);
	}

}
