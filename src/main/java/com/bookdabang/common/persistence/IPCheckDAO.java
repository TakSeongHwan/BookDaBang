package com.bookdabang.common.persistence;

import java.sql.Timestamp;

import com.bookdabang.common.domain.VisitorIPCheck;

public interface IPCheckDAO {

	public Timestamp checkMaxAccessDate(String ipaddr) throws Exception;

	public int insertAccessDate(String ipaddr) throws Exception;

}
