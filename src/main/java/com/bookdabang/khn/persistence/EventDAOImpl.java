package com.bookdabang.khn.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.EventBoardVo;

@Repository
public class EventDAOImpl implements EventDAO {

	@Inject
	private SqlSession ses;
	private static String ns = "com.bookdabang.mapper.eventMapper";
	
	
	@Override
	public List allEventList() throws Exception {
		return ses.selectList(ns + ".allEventList");
	}


	@Override
	public int insertEvent(EventBoardVo newEvent) throws Exception {
		return ses.insert(ns + ".insertEvent", newEvent);
	}


	@Override
	public EventBoardVo eventDetail(int no) throws Exception {
		return ses.selectOne(ns + ".readDetailEvent", no);
	}


	@Override
	public int deleteEvent(int no) throws Exception {
		return ses.delete(ns + ".delEvent", no);
	}



}
