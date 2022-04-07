package com.bookdabang.khn.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.khn.persistence.EventDAO;

@Service // 서비스 단임을 명시
public class EventServiceImpl implements EventService {

	@Inject // DAO 객체 주입
	private EventDAO dao;
	
	@Override
	public List allEventList() throws Exception {
		return dao.allEventList();
	}

}
