package com.bookdabang.lbr.service;

import java.util.List;

import com.bookdabang.common.domain.FreeBoard;



public interface BoardService {
	public List<FreeBoard> listAllBoards() throws Exception;
}
