package com.bookdabang.khn.service;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.EventBoardVo;
import com.bookdabang.common.domain.EventReplyVo;
import com.bookdabang.khn.persistence.EventDAO;

@Service // 서비스 단임을 명시
public class EventServiceImpl implements EventService {

	@Inject // DAO 객체 주입 
	private EventDAO dao;
	
	// Reading-----------------------------------------
	@Override // 전체 페이지 로딩
	public List allEventList() throws Exception {
		return dao.allEventList();
	}
	
	@Override // 디테일 페이지 로딩
	public EventBoardVo readDetailEvent(int no) throws Exception {
		return dao.eventDetail(no);
	}

	
	// Create-----------------------------------------
	@Override // 게시글 입력
	public boolean insertEvent(EventBoardVo newEvent) throws Exception {
		boolean result = false;
		newEvent.setContent(newEvent.getContent().replace("\r\n", "<br />")); // 줄바꿈 적용
		
		int result1 = dao.insertEvent(newEvent);
		
		if(result1 == 1) {
			result = true;
		}
		
		return result;
	}
	
	
	@Override // 댓글 입력
	public boolean insertReply(EventReplyVo newReply) throws Exception {
		boolean result = false;
		int result1 = dao.insertReply(newReply);
		if(result1 == 1) {
			result = true;
		}
		
		return result;
	}

	
	// Delete-----------------------------------------
	@Override
	public int deleteEvent(int no) throws Exception {
		return dao.deleteEvent(no);
	}
	
	
	// Update----------------------------------------
	@Override
	public boolean updateEvent(EventBoardVo updateEvent) throws Exception {
		boolean result = false;
		updateEvent.setContent(updateEvent.getContent().replace("\r\n", "<br />"));
		
		int result1 = dao.updateEvent(updateEvent);
		if (result1 == 1) {
			result = true;
		}
		
		return result;
	}
	
	
	// Etc-----------------------------------------
	@Override
	public Timestamp pageViewCheck(String ipAddr, int no) {
		Timestamp result = null;
		
		return result;
	}

	@Override
	public List allBestList() throws Exception {
		return dao.allBestList();
	}

	


	


}
