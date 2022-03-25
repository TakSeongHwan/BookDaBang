package com.bookdabang.lbr.persistence;

import java.util.List;

import com.bookdabang.common.domain.FreeBoard;

public interface BoardDAO {
	public List<FreeBoard> getListAllFreeBoards() throws Exception;
}
