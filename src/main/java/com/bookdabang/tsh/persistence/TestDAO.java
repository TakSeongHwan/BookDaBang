package com.bookdabang.tsh.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.TestVO;

@Repository
public class TestDAO {

	@Inject
	private SqlSession ses;

	private String ns = "com.bookdabang.mapper.TestMapper";

	public List<TestVO> getMember() {
		return ses.selectList(ns + ".getMember");
	}
}
