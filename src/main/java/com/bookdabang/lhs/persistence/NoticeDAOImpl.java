package com.bookdabang.lhs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.Notice;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.NoticeMapper";

	@Override
	public List<Notice> entireNotice() {
		// TODO Auto-generated method stub
		return ses.selectList(ns + ".getEntireNotice");
	}

	@Override
	public Notice getContentByNo(int no) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+ ".readNotice",no);
	}
	
}
