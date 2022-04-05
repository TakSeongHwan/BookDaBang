package com.bookdabang.lbr.service;

import java.util.List;
import java.util.Map;

import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.Recommend;
import com.bookdabang.common.domain.ReportBoard;
import com.bookdabang.lbr.etc.BoardUploadFile;

public interface FreeBoardService {
	public List<FreeBoard> listAllBoards() throws Exception;

	public Map<String, Object> readFreeBoard(int no) throws Exception;

	public List<ReportBoard> listAllReportBoards() throws Exception;

	public boolean insertReportBoard(ReportBoard reportboard) throws Exception;

	public boolean createFreeBoard(FreeBoard freeBoard, List<BoardUploadFile> upfilelst) throws Exception;

	public boolean removeFreeBoard(int no) throws Exception;

	public List<FreeBoard> removeAllFreeBoard() throws Exception;

	public FreeBoard readDelBoard(int no) throws Exception;

	public boolean restorBoard(int no) throws Exception;

	public boolean likeFreeBoard(Recommend recommend) throws Exception;

	public boolean unlikeFreeBoard(Recommend recommend) throws Exception;

	public int countLikeCheck(Recommend recommend) throws Exception;
	
	public int countReportCheck(ReportBoard reportBoard) throws Exception;

	public int likeCount(int no)throws Exception;

	public int delLikeCount(int no)throws Exception;;
};
