package com.bookdabang.common.service;

import java.sql.Timestamp;

import com.bookdabang.common.domain.VisitorIPCheck;

public interface IPCheckService {
	
	public Timestamp checkMaxAccessDate(String ipaddr) throws Exception;

	public int insertAccessDate(String ipaddr) throws Exception;

}
