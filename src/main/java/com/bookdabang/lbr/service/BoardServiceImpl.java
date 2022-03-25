package com.bookdabang.lbr.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.lbr.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;
	
	
	@Override
	public List<FreeBoard> listAllBoards() throws Exception {
		
		return dao.getListAllFreeBoards();
	}

}
