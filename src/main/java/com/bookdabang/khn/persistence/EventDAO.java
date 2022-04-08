package com.bookdabang.khn.persistence;

import java.util.List;

import com.bookdabang.common.domain.EventBoardVo;

public interface EventDAO {
	public List allEventList() throws Exception;
	public int insertEvent(EventBoardVo newEvent) throws Exception;
	public EventBoardVo eventDetail(int no) throws Exception;
	public int deleteEvent(int no) throws Exception;

}
