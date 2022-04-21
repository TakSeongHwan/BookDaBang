package com.bookdabang.khn.persistence;

import java.util.List;

import com.bookdabang.common.domain.EventBoardVo;
import com.bookdabang.common.domain.EventReplyVo;

public interface EventDAO {
	public List allBestList() throws Exception;
	public List allEventList() throws Exception;
	public int insertEvent(EventBoardVo newEvent) throws Exception;
	public EventBoardVo eventDetail(int no) throws Exception;
	public int deleteEvent(int no) throws Exception;
	public int updateEvent(EventBoardVo updateEvent) throws Exception;
	public int insertReply(EventReplyVo newReply);

}
